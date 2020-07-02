
# Python-ATP Workshop version 2.0.

# Copyright (c) 2020 Oracle and/or its affiliates. All Rights reserved
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/


from __future__ import print_function
from flask import Flask, request
from flask_restful import Resource, Api
from customer import getCustomerById
from customers import Customers
from config import conn_info
from flask_cors import CORS, cross_origin

app = Flask(__name__)
app.config['CORS_HEADERS'] = 'Content-Type'

api = Api(app)
cors = CORS(app, resources={r"/*": {"origins": "*"}})

api.add_resource(Customers, '/customers')
api.add_resource(getCustomerById, '/customers/<int:ID>')

app.run(port=5001, debug=True)

