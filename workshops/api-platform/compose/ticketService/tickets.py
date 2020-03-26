from eve import Eve
from eve.auth import BasicAuth

# class MyBasicAuth(BasicAuth):
#    def check_auth(self, username, password, allowed_roles, resource,
#                   method):
#        return username == 'demoUSER' and password == '<you must set this!>'

# Before you deploy, you must uncomment the block above and choose a complex password!
#  The block above is to provide a simply protected resource that requires a basic auth
# in order to insert records.

ts_settings = {
  'MONGO_HOST': 'tickets-db',
  'MONGO_PORT': 27017,
  'MONGO_DBNAME': 'tms',
  'RESOURCE_METHODS': ['GET','POST'],
  'ITEM_METHODS': ['GET', 'PUT', 'PATCH', 'DELETE'],
  'PUBLIC_METHODS':['GET'],
  'DOMAIN': {
	'tickets': {
		'schema': {
			'ticketID': {'type': 'string'},
			'subject': {'type': 'string'},
			'summary': {'type': 'string'},
			'customer': {'type': 'string'},
                        'customerID': {'type': 'string'},
                        'partner': {'type': 'string'},
                        'partnerID': {'type': 'string'},
			'product': {'type': 'string'},
			'status': {'type': 'string'},
                        'tracking': {'type': 'string'}
		}
	}
  }
}

app = Eve(settings=ts_settings, auth=MyBasicAuth)

if __name__ == '__main__':
  app.run('0.0.0.0')

