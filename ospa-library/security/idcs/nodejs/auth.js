var ids = {
  oracle: {
    "ClientId": "123456789abcdefghij",
    "ClientSecret": "abcde-12345-zyxvu-98765-qwerty",
	"ClientTenant": "idcs-abcd1234",
    "IDCSHost": "https://%tenant%.identity.oraclecloud.com",
    "AudienceServiceUrl" : "https://idcs-abcd1234.identity.oraclecloud.com",
    "TokenIssuer": "https://identity.oraclecloud.com/",
    "scope": "urn:opc:idm:t.user.me openid",
    "logoutSufix": "/oauth2/v1/userlogout",
    "redirectURL": "http://localhost:3000/callback",
    "LogLevel":"warn",
    "ConsoleLog":"True"
  }
};

module.exports = ids;
