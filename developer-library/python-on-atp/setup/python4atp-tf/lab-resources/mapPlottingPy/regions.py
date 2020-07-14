# Python-ATP Workshop version 2.0.

# Copyright (c) 2020 Oracle and/or its affiliates. All Rights reserved
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

from shapely.geometry import Point, Polygon,mapping, shape
import shapely.wkt
import cx_Oracle
import geopandas as gpd
from geojson import Feature, FeatureCollection, Point
import json
from bokeh.io import show, output_notebook,output_file, curdoc
from bokeh.plotting import figure
from bokeh.models import GeoJSONDataSource, LinearColorMapper, ColorBar,Slider, HoverTool,ColumnDataSource,LogColorMapper,HoverTool, PanTool, ResetTool, WheelZoomTool,FuncTickFormatter, TextInput, Paragraph, CDSView,WMTSTileSource
from bokeh.models.callbacks import CustomJS
from bokeh.palettes import brewer
from bokeh.layouts import widgetbox, row, column
import ast
import numpy as np
import pandas as pd
from config import conn_info
from bokeh.models.widgets import DataTable, DateFormatter, TableColumn, RadioButtonGroup
from bokeh.models.glyphs import MultiPolygons,Patches
import geojson
from functools import reduce

# Converting CLOB data to String
def OutputTypeHandler(cursor, name, defaultType, size, precision, scale):
    if defaultType == cx_Oracle.CLOB:
        return cursor.var(cx_Oracle.LONG_STRING, arraysize = cursor.arraysize)
    if defaultType == cx_Oracle.BLOB:
        return cursor.var(cx_Oracle.LONG_BINARY, arraysize = cursor.arraysize)

connection = cx_Oracle.connect(conn_info['user'],conn_info['password'],conn_info['service_name'])
connection.outputtypehandler = OutputTypeHandler
cursor = connection.cursor()

query = """select STREET_ADDRESS,INCOME,STATE_PROVINCE,COUNTRY_CODE,SDO_UTIL.TO_GEOJSON(ADDRESS_POINT) cordinates,AGE FROM CUSTOMERS where ROWNUM <= 5000"""

data = []

for address,income,state,country,cordinate,age in cursor.execute(query):
    data.append(
            Feature(
              geometry = ast.literal_eval(cordinate),
              properties = ({"state":state,"country":country,"address":address,"income":income,"age":age,"color":"red" })
            )
    )

collection = FeatureCollection(data)

# Wrting File with GeoJSON data fetched from ATP

with open("GeoObs.geojson", "w") as f:
    f.write('%s' % collection)
# Reading geoJSON file we created earlier
atp_df = gpd.read_file('GeoObs.geojson')
# Converting into dataframe with required columns
location = gpd.GeoDataFrame(atp_df, columns = ['address','income','state','country','geometry','age','color'])
print("Location")
print(location.head())

# ALTERNATE METHOD TO CONVERT GEODATAFRAME FROM COLLECTION WITHOUT CREATING GEOJSON FILE
# location = gpd.GeoDataFrame.from_features(collection['features'])
# print("Location")
# print(location.head())


# Reading file of US states outline
fp = './cb_2018_us_state_500k/cb_2018_us_state_500k.shp'
map_df = gpd.read_file(fp)

print(map_df.head())

regions_file = './demo_region/demo_regions.shp'
region_df = gpd.read_file(regions_file)

# REMOVE UUNWANTED STATES FROM DATAFRAME

new_map_df = map_df.drop(map_df.index[[13,27,37,38,42,44,45,46]])

locationUS = location['country'] == 'US'
USData = location[locationUS]

conditions = [
    (USData['state'].isin(['California','Nevada'])),
    (USData['state'].isin(['Oregon','Washington','Idaho'])),
    (USData['state'].isin(['Ohio','Indiana','Illinois','Michigan'])),
    (USData['state'].isin(['Louisiana','Texas'])),
    (USData['state'].isin(['Mississippi','Florida','Alabama','Georgia'])),
    (USData['state'].isin(['Virginia','West Virginia','Massachusetts','Pennsylvania','New York','Vermont','New Hampshire','New Jersey','Maryland','Rhode Island','Connecticut'])),
]

colours = ['yellow', 'blue', 'purple','grey','pink','orange']
regions = ['West Region','Northwest Region','Central Region','South Central Region','South Region','East Region']
USData['color'] = np.select(conditions, colours, default='white')
USData['region'] = np.select(conditions, regions, default=None)
USData = USData[USData['region'] != None]

print("USA Data")
print(USData.head())

# GET X AND Y CORDINATE FROM THE POINT 

def getPointCoords(row, geom, coord_type):
    """Calculates coordinates ('x' or 'y') of a Point geometry"""
    if coord_type == 'x':
        return row[geom].x
    elif coord_type == 'y':
        return row[geom].y

USData['sizes'] = USData['income']/10000
USData['x'] = USData.apply(getPointCoords, geom='geometry', coord_type='x', axis=1)
USData['y'] = USData.apply(getPointCoords, geom='geometry', coord_type='y', axis=1)

# Creating new df with mean income per state data
mean_df = USData.groupby('region', as_index=False)['income','age','state'].mean()
# WE JUST NEED STATE, INCOME and AGE COLUMN FROM THIS DATAFRAME

print("MEAN DF")
print(mean_df.head())

columns = ['region','state','income','age']
avg_income_df = mean_df.reindex(columns=columns)


print("AVERAGE INCOME DF")
print(avg_income_df.head())

# # Merging data from state oultine and geoJSON with index of state
merged = region_df.set_index('Region').join(avg_income_df.set_index('region'))
merged['Region'] = merged.index

# merged['income'] = round(merged['income'],2)

colors = ["#F1EEF6","#F1EEF6", "red","red", "black","black", "#DF65B0","#DF65B0", "#DD1C77", "#DD1C77", "#980043","#980043"]

#CONVERT DATAFRAME TO GEOJSON

merged_json = json.loads(new_map_df.to_json())
json_data = json.dumps(merged_json)
contents = GeoJSONDataSource(geojson = json_data)

merged_json1 = json.loads(merged.to_json())
json_data1 = json.dumps(merged_json1)
contents1 = GeoJSONDataSource(geojson = json_data1)

# Create column data source

source =ColumnDataSource(data= dict(
                        x=list(USData['x']), 
                        y=list(USData['y']),
                        address=list(USData['address']),
                        income=list(USData['income']),
                        sizes=list(USData['sizes'] ),
                        age = list(USData['age']),
                        distance = list(USData['age']),
                        color = list(USData['color'])
                       ))

palette = brewer['YlGnBu'][8]
palette = palette[::-1]
color_mapper_income = LinearColorMapper(palette = palette,low = 0, high = 100000, nan_color = '#d9d9d9')

#CREATE FIGURE 

# ADD HOVER TOOL 
my_hover = HoverTool(names=["states"])
my_hover.tooltips = [('Address:', '@address'),('Income:', '@income')]

region_hover = HoverTool(names=["map"])
region_hover.tooltips = [('Name of Region:','@Region'),('Average age of region:', '@age'),('Average income of region:', '@income{int}')]

p = figure(title="Average income in US", plot_width=1000,tools=[my_hover,region_hover,WheelZoomTool(),'box_zoom','reset'] ,plot_height=700, toolbar_location="below",
           toolbar_sticky=False)

p.grid.grid_line_color = None

field = ["income","age","address"]

plot1 = p.patches(xs='xs',ys='ys', fill_alpha=0.06,fill_color='grey',line_color = 'grey', line_width = 0.25,source = contents)
plot2 = p.patches(xs='xs',ys='ys', fill_alpha=0.7, fill_color={"field":'income',"transform":color_mapper_income}, line_color = 'black', line_width = 0.45,name= "map",source = contents1)

p.circle(x='x',y='y', size='sizes', source=source, line_color="color", fill_color="color",fill_alpha=0.05, name="states")

layout = column(p)

curdoc().add_root(layout)

