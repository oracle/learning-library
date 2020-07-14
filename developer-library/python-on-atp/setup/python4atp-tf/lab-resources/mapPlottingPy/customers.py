# Python-ATP Workshop version 2.0.

# Copyright (c) 2020 Oracle and/or its affiliates. All Rights reserved
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/


from shapely.geometry import Point, Polygon,mapping, shape
import cx_Oracle
import geopandas as gpd
from geojson import Feature, FeatureCollection, Point
import json
import numpy as np
from bokeh.io import show, output_notebook,output_file, curdoc
from bokeh.plotting import figure
from bokeh.models import GeoJSONDataSource, LinearColorMapper, ColorBar,Slider, HoverTool,ColumnDataSource,LogColorMapper,HoverTool, PanTool, ResetTool, WheelZoomTool,FuncTickFormatter, TextInput, Paragraph, CDSView, WMTSTileSource
from bokeh.models.callbacks import CustomJS
from bokeh.palettes import brewer
from bokeh.layouts import widgetbox, row, column
import ast
import pandas as pd
import shapely.wkt
from bokeh.models.widgets import DataTable, DateFormatter, TableColumn, RadioButtonGroup
from bokeh.models.glyphs import MultiPolygons,Patches
import geojson
from pyproj import Proj
from config import conn_info

# Converting CLOB data to String
def OutputTypeHandler(cursor, name, defaultType, size, precision, scale):
    if defaultType == cx_Oracle.CLOB:
        return cursor.var(cx_Oracle.LONG_STRING, arraysize = cursor.arraysize)
    if defaultType == cx_Oracle.BLOB:
        return cursor.var(cx_Oracle.LONG_BINARY, arraysize = cursor.arraysize)

connection = cx_Oracle.connect(conn_info['user'],conn_info['password'],conn_info['service_name'])
connection.outputtypehandler = OutputTypeHandler
cursor = connection.cursor()

# Reading file of US states outline
fp = './cb_2018_us_state_500k/cb_2018_us_state_500k.shp'
map_df = gpd.read_file(fp)

new_map_df = map_df.drop(map_df.index[[13,27,37,38,42,44,45,46]])

print(map_df.head())

merged_json = json.loads(new_map_df.to_json())

json_data = json.dumps(merged_json)

contents = GeoJSONDataSource(geojson = json_data)

nearest_neighbour_query = """
SELECT /* ORDERED */
    "A1"."STREET_ADDRESS"  ,
    "A2"."CITY",
    "A2"."STREET_ADDRESS" ,
    SDO_UTIL.TO_GEOJSON("A1"."ADDRESS_POINT"),
    SDO_UTIL.TO_GEOJSON("A2"."ADDRESS_POINT"),
    "A2"."STATE_PROVINCE",
    "MDSYS"."SDO_NN_DISTANCE"(1) "DISTANCE_IN_MILES"
FROM
    "CUSTOMERS"           "A2",
    "SERVICE_PROVIDERS"   "A1"
WHERE
    "A2"."COUNTRY_ID" = 102 AND 
    "A1"."COUNTRY_ID" = 102 AND
    "MDSYS"."SDO_NN"("A1"."ADDRESS_POINT", "A2"."ADDRESS_POINT", 'sdo_num_res=1 unit=mile', 1) = 'TRUE'
ORDER BY
"MDSYS"."SDO_NN_DISTANCE"(1)
"""

nearest_neighbour_data =[]
try:
    for provider_address,cust_city,cust_address,provider_geometry,cust_geometry,state,miles in cursor.execute(nearest_neighbour_query):

        if miles < 10:
            nearest_neighbour_data.append(
                Feature(

                    geometry = ast.literal_eval(cust_geometry),
            
                    properties = ({"customer_city":cust_city,"state":state,"color":"red","distance":miles,"address":provider_address,"range": "Less than 10 miles"  })
                    )
            )
        elif miles > 10 and miles < 200:
            nearest_neighbour_data.append(
                Feature(

                    geometry = ast.literal_eval(cust_geometry),
            
                    properties = ({"customer_city":cust_city,"state":state,"color":"blue","distance":miles,"address":provider_address,"range": "10-200 miles" })
                    )
            )
        else:
            nearest_neighbour_data.append(
                Feature(

                    geometry = ast.literal_eval(cust_geometry),
            
                    properties = ({"customer_city":cust_city,"state":state,"color":"black","distance":miles,"address":provider_address,"range": "More than 200 miles"  })
                    )
            )

        nearest_neighbour_data.append(                
            Feature(
                geometry = ast.literal_eval(provider_geometry),
                properties = ({"address":cust_address,"color":"green","range": "Service Providers" })
                )
        )
except cx_Oracle.DatabaseError as exc:
    print(str(type(exc)))                      # <class 'cx_Oracle.NotSupportedError'>
    print(repr(exc))                           # NotSupportedError('Variable_TypeByValue(): unhandled data type dict',)
    error, = exc.args                          # "error" is a str, NOT a cx_Oracle._Error object
    print("Oracle-Error-Code:", error.code)    # AttributeError: 'str' object has no attribute 'code'
    print("Oracle-Error-Message:", error.message)


collection = FeatureCollection(nearest_neighbour_data)

# Wrting File with GeoJSON data fetched from ATP
with open("NearestServiceProvider.geojson", "w") as f:
    f.write('%s' % collection)

df = gpd.read_file('NearestServiceProvider.geojson')
# print("Dataframe")
# print(df.geometry)

# Converting into dataframe with required columns
location = gpd.GeoDataFrame(df, columns = ['customer_city','address','geometry','state','distance','color','range'])

# print("Location")
# print(location.head())
def getPointCoords(row, geom, coord_type):
    """Calculates coordinates ('x' or 'y') of a Point geometry"""
    if coord_type == 'x':
        return row[geom].x
    elif coord_type == 'y':
        return row[geom].y


location['x'] = location.apply(getPointCoords, geom='geometry', coord_type='x', axis=1)
location['y'] = location.apply(getPointCoords, geom='geometry', coord_type='y', axis=1)
length = len(location['y'])

for x in range(1,length):
    location['sizes'] = 10

# Create column data source
NNSource = dict(
                        lon=list(location['x']), 
                        lat=list(location['y']),
                        address= list(location['address']),
                        sizes = list(location['sizes']),
                        income=list(location['color']),
                        age = list(location['customer_city']),
                        distance = list(location['distance']),
                        color = list(location['color']),
                        range =  list(location['range'])
                    )
source =  pd.DataFrame(NNSource)



# print(source['lon'])

def wgs84_to_web_mercator(df, lon="lon", lat="lat"):
    """Converts decimal longitude/latitude to Web Mercator format"""
    k = 6378137
    df["x"] = df[lon] * (k * np.pi/180.0)
    df["y"] = np.log(np.tan((90 + df[lat]) * np.pi/360.0)) * k
    return df


wgs84_to_web_mercator(source)

palette = brewer['YlGnBu'][8]
palette = palette[::-1]
color_mapper_age = LinearColorMapper(palette = palette,low = 0, high = 90, nan_color = '#d9d9d9')
color_mapper_income = LinearColorMapper(palette = palette,low = 0, high = 100000, nan_color = '#d9d9d9')

#CREATE FIGURE 

# ADD HOVER TOOL 
my_hover = HoverTool(names=["states"])
my_hover.tooltips = [('Nearest service provider:', '@address'),('Distance:', '@distance')]

# p = figure(title="Average income in US", plot_width=1000,tools=[my_hover,WheelZoomTool(),'box_zoom','reset'] ,plot_height=700, toolbar_location="below",
#            toolbar_sticky=False)

# p.grid.grid_line_color = None

field = ["income","age","address"]

USA = x_range,y_range = ((-13884029,-7453304), (2698291,6455972))

p = figure(plot_width=1000,plot_height=700,tools=[my_hover,WheelZoomTool(),'box_zoom','reset'], x_range=x_range, y_range=y_range, toolbar_location="below",
           x_axis_type="mercator", y_axis_type="mercator")

url = 'https://elocation.oracle.com/mapviewer/mcserver/ELOCATION_MERCATOR/osm_positron/{Z}/{Y}/{X}.png'
attribution = "© OpenMapTiles © OpenStreetMap contributors"

p.add_tile(WMTSTileSource(url=url, attribution=attribution))

# plot1 = p.patches(xs='xs',ys='ys', fill_alpha=0.07,fill_color="grey",line_color = 'black', line_width = 0.25,name= "map",source = contents)

p.circle(x='x',y='y', size='sizes', source=source, line_color="color", fill_color="color",fill_alpha=0.05, name="states", legend='range')

p.legend.location = "top_left"
p.legend.click_policy="mute"


layout = column(p)

curdoc().add_root(layout)

