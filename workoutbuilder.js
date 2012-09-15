var http = require("http");
var url = require("url");
var fitness = require("./exercise");

function start(route)
{
	function onRequest(request, response)
	{
		var pathname = url.parse(request.url).pathname;
		
		route(pathname)
	}
	
	
	
}



function assembleWorkout()
{
	var workout = new WRWorkout();
	
	
	
	
}

http.createServer(function(request,response){}).listen(8888);