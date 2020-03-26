var http = require('http');
var oracledb = require('oracledb');
var dbConfig = require('./dbconfig.js');
let error;
let user;
// oracledb.getConnection({

// user: 'nodeuser',
// password: 'MyATPdatabase123#',
// connectString: 'nodeappdb_high'
// },
oracledb.getConnection({
user: dbConfig.dbuser,
password: dbConfig.dbpassword,
connectString: dbConfig.connectString
},
function(err, connection) {
if (err) {
error = err;
return;
}
connection.execute('select user from dual', [], function(err, result) {
if (err) {
error = err;
return;
}
user = result.rows[0][0];
error = null;
connection.close(function(err) {
if (err) {
console.log(err);
}
});
})
}
);



http.createServer(function(request, response) {
response.writeHead(200, {
'Content-Type': 'text/plain'
});
if (error === null) {
response.end('Connection test succeeded. You connected to ATP as ' + user + '!');
} else if (error instanceof Error) {
response.write('Connection test failed. Check the settings and redeploy app!\n');
response.end(error.message);
} else {
response.end('Connection test pending. Refresh after a few seconds...');
}
}).listen(3050);