# Python-ATP Workshop version 2.0.

# Copyright (c) 2020 Oracle and/or its affiliates. All Rights reserved
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

from __future__ import print_function
from flask import Flask, request
from flask_restful import Resource, Api, reqparse
import cx_Oracle
from config import conn_info
import ast
import json

class getCustomerById(Resource):

    customerIdQuery = """SELECT  CUST_ID, LAST_NAME, FIRST_NAME, STREET_ADDRESS, POSTAL_CODE, CITY_ID, CITY,STATE_PROVINCE_ID, STATE_PROVINCE,
                        COUNTRY_ID,COUNTRY,CONTINENT_ID,CONTINENT,AGE, COMMUTE_DISTANCE,CREDIT_BALANCE,EDUCATION,EMAIL,
                        FULL_TIME,GENDER,HOUSEHOLD_SIZE,INCOME,INCOME_LEVEL,INSUFF_FUNDS_INCIDENTS,JOB_TYPE,LATE_MORT_RENT_PMTS,
                        MARITAL_STATUS,MORTGAGE_AMT,NUM_CARS, NUM_MORTGAGES,PET,PROMOTION_RESPONSE,RENT_OWN,SEG,
                        WORK_EXPERIENCE,YRS_CURRENT_EMPLOYER,YRS_CUSTOMER,YRS_RESIDENCE,SDO_UTIL.TO_GEOJSON(ADDRESS_POINT) cordinates,
                        COUNTRY_CODE,USERNAME FROM CUSTOMERS WHERE CUST_ID= :id"""

    def customer(self,ID,data,address):
        return(
            {
            'CUST_ID' : ID,
            'LAST_NAME' : data['LAST_NAME'],
            'FIRST_NAME' : data['FIRST_NAME'],
            'STREET_ADDRESS' : data['STREET_ADDRESS'],
            'POSTAL_CODE' : data['POSTAL_CODE'],
            'CITY_ID' : data['CITY_ID'],
            'CITY' : data['CITY'],
            'STATE_PROVINCE_ID' : data['STATE_PROVINCE_ID'],
            'STATE_PROVINCE' : data['STATE_PROVINCE'],
            'COUNTRY_ID' : data['COUNTRY_ID'],
            'COUNTRY' : data['COUNTRY'],
            'CONTINENT_ID' : data['CONTINENT_ID'],
            'CONTINENT' : data['CONTINENT'],
            'AGE' : data['AGE'],
            'COMMUTE_DISTANCE' : data['COMMUTE_DISTANCE'],
            'CREDIT_BALANCE' : data['CREDIT_BALANCE'],
            'EDUCATION' : data['EDUCATION'],
            'EMAIL' : data['EMAIL'],
            'FULL_TIME' : data['FULL_TIME'],
            'GENDER' : data['GENDER'],
            'HOUSEHOLD_SIZE' : data['HOUSEHOLD_SIZE'],
            'INCOME' : data['INCOME'],
            'INCOME_LEVEL' : data['INCOME_LEVEL'],
            'INSUFF_FUNDS_INCIDENTS' : data['INSUFF_FUNDS_INCIDENTS'],
            'JOB_TYPE' : data['JOB_TYPE'],
            'LATE_MORT_RENT_PMTS' : data['LATE_MORT_RENT_PMTS'],
            'MARITAL_STATUS' : data['MARITAL_STATUS'],
            'MORTGAGE_AMT' : data['MORTGAGE_AMT'],
            'NUM_CARS' : data['NUM_CARS'],
            'NUM_MORTGAGES' : data['NUM_MORTGAGES'],
            'PET' : data['PET'],
            'PROMOTION_RESPONSE' : data['PROMOTION_RESPONSE'],
            'RENT_OWN' : data['RENT_OWN'],
            'SEG' : data['SEG'],
            'WORK_EXPERIENCE' : data['WORK_EXPERIENCE'],
            'YRS_CURRENT_EMPLOYER' : data['YRS_CURRENT_EMPLOYER'],
            'YRS_CUSTOMER' : data['YRS_CUSTOMER'],
            'YRS_RESIDENCE' : data['YRS_RESIDENCE'],
            'ADDRESS_POINT' : address,
            'COUNTRY_CODE' : data['COUNTRY_CODE'],
            'USERNAME' : data['USERNAME']
            }
        )


    def OutputTypeHandler(self,cursor, name, defaultType, size, precision, scale):
        if defaultType == cx_Oracle.CLOB:
            return cursor.var(cx_Oracle.LONG_STRING, arraysize = cursor.arraysize)
        if defaultType == cx_Oracle.BLOB:
            return cursor.var(cx_Oracle.LONG_BINARY, arraysize = cursor.arraysize)

    def get(self,ID):
        connection = cx_Oracle.connect(conn_info['user'],conn_info['password'],conn_info['service_name'])
        # connection = cx_Oracle.connect("admin","Vaytrial2019","pythonAppDb_LOW")
        connection.outputtypehandler = self.OutputTypeHandler
        cursor = connection.cursor()

        args = { 'id' : ID }
        result = cursor.execute(self.customerIdQuery,args)
        row = result.fetchone()
        if row:
            return({
                                'CUST_ID' : row[0],
                                'LAST_NAME' : row[1],
                                'FIRST_NAME' : row[2],
                                'STREET_ADDRESS' : row[3],
                                'POSTAL_CODE' : row[4],
                                'CITY_ID' : row[5],
                                'CITY' : row[6],
                                'STATE_PROVINCE_ID' : row[7],
                                'STATE_PROVINCE' : row[8],
                                'COUNTRY_ID' : row[9],
                                'COUNTRY' : row[10],
                                'CONTINENT_ID' : row[11],
                                'CONTINENT' : row[12],
                                'AGE' : row[13],
                                'COMMUTE_DISTANCE' : row[14],
                                'CREDIT_BALANCE' : row[15],
                                'EDUCATION' : row[16],
                                'EMAIL' : row[17],
                                'FULL_TIME' : row[18],
                                'GENDER' : row[19],
                                'HOUSEHOLD_SIZE' : row[20],
                                'INCOME' : row[21],
                                'INCOME_LEVEL' : row[22],
                                'INSUFF_FUNDS_INCIDENTS' : row[23],
                                'JOB_TYPE' : row[24],
                                'LATE_MORT_RENT_PMTS' : row[25],
                                'MARITAL_STATUS' : row[26],
                                'MORTGAGE_AMT' : row[27],
                                'NUM_CARS' : row[28],
                                'NUM_MORTGAGES' : [29],
                                'PET' : row[30],
                                'PROMOTION_RESPONSE' : row[31],
                                'RENT_OWN' : row[32],
                                'SEG' : row[33],
                                'WORK_EXPERIENCE' : row[34],
                                'YRS_CURRENT_EMPLOYER' : row[35],
                                'YRS_CUSTOMER' : row[36],
                                'YRS_RESIDENCE' : row[37],
                                'ADDRESS_POINT' : ast.literal_eval(row[38]),
                                'COUNTRY_CODE' : row[39],
                                'USERNAME    ' : row[40]
                                })
            connection.close()
        else:
            return {'message': 'Product not found'}, 404

    def delete(self,ID):
        connection = cx_Oracle.connect(conn_info['user'],conn_info['password'],conn_info['service_name'])
        cursor = connection.cursor()
        productIdQuery = """DELETE FROM CUSTOMERS WHERE CUST_ID= :id"""
        id = ID
        print(ID)
        args = { 'id' : id }
        cursor.execute(productIdQuery,args)
        connection.commit()
        connection.close()
        return {'message': 'Customer deleted'}
      
    def post(self,ID):
        connection = cx_Oracle.connect(conn_info['user'],conn_info['password'],conn_info['service_name'])
        cursor = connection.cursor()
        parser = reqparse.RequestParser()
        parser.add_argument('CUST_ID', type = float,required = True, help = "Add fields to body")
        parser.add_argument('LAST_NAME', type = str, help = "Add fields to body")
        parser.add_argument('FIRST_NAME', type = str,required = False, help = "Add fields to body")
        parser.add_argument('STREET_ADDRESS', type = str,required = False, help = "Add fields to body")
        parser.add_argument('POSTAL_CODE', type = str,required = False, help = "Add fields to body")
        parser.add_argument('CITY_ID', type = float,required = False, help = "Add fields to body")
        parser.add_argument('CITY', type = str,required = False, help = "Add fields to body")
        parser.add_argument('STATE_PROVINCE_ID', type = float,required = False, help = "Add fields to body")
        parser.add_argument('STATE_PROVINCE', type = str,required = False, help = "Add fields to body")
        parser.add_argument('COUNTRY_ID', type = float,required = False, help = "Add fields to body")
        parser.add_argument('COUNTRY', type = str,required = False, help = "Add fields to body")
        parser.add_argument('CONTINENT_ID', type = float,required = False, help = "Add fields to body")
        parser.add_argument('CONTINENT', type = float,required = False, help = "Add fields to body")
        parser.add_argument('AGE', type = int, default=18, required = False, help = "Add fields to body")
        parser.add_argument('COMMUTE_DISTANCE', type = float,required = False, help = "Add fields to body")
        parser.add_argument('CREDIT_BALANCE', type = float,required = False, help = "Add fields to body")
        parser.add_argument('EDUCATION', type = float,required = False, help = "Add fields to body")
        parser.add_argument('EMAIL', type = float,required = False, help = "Add fields to body")
        parser.add_argument('FULL_TIME', type = float,required = False, help = "Add fields to body")
        parser.add_argument('GENDER', type = float,required = False, help = "Add fields to body")
        parser.add_argument('HOUSEHOLD_SIZE', type = float,required = False, help = "Add fields to body")
        parser.add_argument('INCOME', type = float,required = False, help = "Add fields to body")
        parser.add_argument('INCOME_LEVEL', type = float,required = False, help = "Add fields to body")
        parser.add_argument('INSUFF_FUNDS_INCIDENTS', type = float,required = False, help = "Add fields to body")
        parser.add_argument('JOB_TYPE', type = float,required = False, help = "Add fields to body")
        parser.add_argument('LATE_MORT_RENT_PMTS', type = float,required = False, help = "Add fields to body")
        parser.add_argument('MARITAL_STATUS', type = float,required = False, help = "Add fields to body")
        parser.add_argument('MORTGAGE_AMT', type = float,required = False, help = "Add fields to body")
        parser.add_argument('NUM_CARS', type = float,required = False, help = "Add fields to body")
        parser.add_argument('NUM_MORTGAGES', type = float,required = False, help = "Add fields to body")
        parser.add_argument('PET', type = float,required = False, help = "Add fields to body")
        parser.add_argument('PROMOTION_RESPONSE', type = float,required = False, help = "Add fields to body")
        parser.add_argument('RENT_OWN', type = float,required = False, help = "Add fields to body")
        parser.add_argument('SEG', type = float,required = False, help = "Add fields to body")
        parser.add_argument('WORK_EXPERIENCE', type = float,required = False, help = "Add fields to body")
        parser.add_argument('YRS_CURRENT_EMPLOYER', type = float,required = False, help = "Add fields to body")
        parser.add_argument('YRS_CUSTOMER', type = float,required = False, help = "Add fields to body")
        parser.add_argument('YRS_RESIDENCE', type = float,required = False, help = "Add fields to body")
        parser.add_argument('ADDRESS_POINT', type=dict,action='append',required = False, help = "Add fields to body")
        parser.add_argument('COUNTRY_CODE', type = float,required = False, help = "Add fields to body")
        parser.add_argument('USERNAME', type = float,required = False, help = "Add fields to body")                

        args = { 'id' : ID }
        result = cursor.execute(self.customerIdQuery,args)
        row = result.fetchone()
        if row:
            return {'message': "Customer with ID '{}' already exists.".format(ID)}, 400

        data = parser.parse_args()
    
        # acquire types used for creating SDO_GEOMETRY objects
        typeObj = connection.gettype("MDSYS.SDO_GEOMETRY")
        elementInfoTypeObj = connection.gettype("MDSYS.SDO_ELEM_INFO_ARRAY")
        ordinateTypeObj = connection.gettype("MDSYS.SDO_ORDINATE_ARRAY")

        # define function for creating an SDO_GEOMETRY object
        def CreateGeometryObj(*ordinates):
            geometry = typeObj.newobject()
            geometry.SDO_GTYPE = 2001
            geometry.SDO_SRID = 4326
            geometry.SDO_ELEM_INFO = elementInfoTypeObj.newobject()
            geometry.SDO_ELEM_INFO.extend([1, 1, 1])
            geometry.SDO_ORDINATES = ordinateTypeObj.newobject()
            geometry.SDO_ORDINATES.extend(ordinates)
            return geometry

        SDO_address = CreateGeometryObj(0,0)
        address = None

        if data['ADDRESS_POINT'] is None:
            SDO_address = CreateGeometryObj(0,0)
        else:
            address = data['ADDRESS_POINT']
            SDO_address = CreateGeometryObj(data['ADDRESS_POINT'][0]['coordinates'][0], data['ADDRESS_POINT'][0]['coordinates'][1])
            
      
        print(data)
        print(data['LAST_NAME'])

        Insertquery = """ Insert into CUSTOMERS (
            CUST_ID, LAST_NAME, FIRST_NAME, STREET_ADDRESS, POSTAL_CODE, CITY_ID, CITY,
                            STATE_PROVINCE_ID,
                            STATE_PROVINCE,
                            COUNTRY_ID,
                            COUNTRY,
                            CONTINENT_ID,
                            CONTINENT,
                            AGE,
                            COMMUTE_DISTANCE,
                            CREDIT_BALANCE,
                            EDUCATION,
                            EMAIL,
                            FULL_TIME,
                            GENDER,
                            HOUSEHOLD_SIZE,
                            INCOME,
                            INCOME_LEVEL,
                            INSUFF_FUNDS_INCIDENTS,
                            JOB_TYPE,
                            LATE_MORT_RENT_PMTS,
                            MARITAL_STATUS,
                            MORTGAGE_AMT,
                            NUM_CARS,
                            NUM_MORTGAGES,
                            PET,
                            PROMOTION_RESPONSE,
                            RENT_OWN,
                            SEG,
                            WORK_EXPERIENCE,
                            YRS_CURRENT_EMPLOYER,
                            YRS_CUSTOMER,
                            YRS_RESIDENCE,
                            ADDRESS_POINT,
                            COUNTRY_CODE,
                            USERNAME
        ) VALUES (
                :CUST_ID, 
                :LAST_NAME, 
                :FIRST_NAME, 
                :STREET_ADDRESS, 
                :POSTAL_CODE, 
                :CITY_ID, 
                :CITY,
                :STATE_PROVINCE_ID,
                :STATE_PROVINCE,
                :COUNTRY_ID,
                :COUNTRY,
                :CONTINENT_ID,
                :CONTINENT,
                :AGE,
                :COMMUTE_DISTANCE,
                :CREDIT_BALANCE,
                :EDUCATION,
                :EMAIL,
                :FULL_TIME,
                :GENDER,
                :HOUSEHOLD_SIZE,
                :INCOME,
                :INCOME_LEVEL,
                :INSUFF_FUNDS_INCIDENTS,
                :JOB_TYPE,
                :LATE_MORT_RENT_PMTS,
                :MARITAL_STATUS,
                :MORTGAGE_AMT,
                :NUM_CARS,
                :NUM_MORTGAGES,
                :PET,
                :PROMOTION_RESPONSE,
                :RENT_OWN,
                :SEG,
                :WORK_EXPERIENCE,
                :YRS_CURRENT_EMPLOYER,
                :YRS_CUSTOMER,
                :YRS_RESIDENCE,
                :ADDRESS_POINT,
                :COUNTRY_CODE,
                :USERNAME
                )"""
        cursor.execute(Insertquery, self.customer(ID,data,SDO_address))     
        connection.commit()
        connection.close()
        return self.customer(ID,data,address), 201

    def put(self,ID):
        connection = cx_Oracle.connect(conn_info['user'],conn_info['password'],conn_info['service_name'])
        cursor = connection.cursor()
        parser = reqparse.RequestParser()
        parser.add_argument('COUNTRY',type = str,required = True,help= "This field requires the COUNTRTY parameter ")

        data = parser.parse_args()

        country = data['COUNTRY']

        customerIdQuery = """SELECT * FROM CUSTOMERS WHERE CUST_ID= :id"""
        productUpdateQuery = """update CUSTOMERS set COUNTRY= :country where CUST_ID= :id"""

        id = ID
        args = { 'id' : id, 'COUNTRY': country}
        arg = {'id' : id}

        result = cursor.execute(customerIdQuery,arg)
        if result.fetchone():
            cursor.execute(productUpdateQuery,args)
            connection.commit()
            connection.close()
            return {'message':'Customer Updated'}
        else:
            connection.commit()
            connection.close()
            return {'message':'Customer not found'}