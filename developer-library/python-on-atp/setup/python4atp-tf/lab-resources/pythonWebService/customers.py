# Python-ATP Workshop version 2.0.

# Copyright (c) 2020 Oracle and/or its affiliates. All Rights reserved
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/


from __future__ import print_function
from flask import Flask, request
from flask_restful import Resource, Api, reqparse
import cx_Oracle
from config import conn_info
import ast

class Customers(Resource):

    def OutputTypeHandler(self,cursor, name, defaultType, size, precision, scale):
        if defaultType == cx_Oracle.CLOB:
            return cursor.var(cx_Oracle.LONG_STRING, arraysize = cursor.arraysize)
        if defaultType == cx_Oracle.BLOB:
            return cursor.var(cx_Oracle.LONG_BINARY, arraysize = cursor.arraysize)


    def get(self):
        connection = cx_Oracle.connect(conn_info['user'],conn_info['password'],conn_info['service_name'])
        connection.outputtypehandler = self.OutputTypeHandler
        cursor = connection.cursor()
        fetchAllCustomersQuery = """SELECT  CUST_ID, LAST_NAME, FIRST_NAME, STREET_ADDRESS, POSTAL_CODE, CITY_ID, CITY,
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
                            SDO_UTIL.TO_GEOJSON(ADDRESS_POINT) cordinates,
                            COUNTRY_CODE,
                            USERNAME FROM CUSTOMERS """

        parsedData = []
        for row in cursor.execute(fetchAllCustomersQuery):
            parsedData.append({
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
        return parsedData