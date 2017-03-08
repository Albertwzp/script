'use strict'
var http=require('http');
var server=http.createServer();
server.on('request',function(req,res){
	res.writeHead(200,{'Content-Type':'text/plain'});
	res.end('Hello World\n');
});
server.listen('8000');
console.log('Server running');
