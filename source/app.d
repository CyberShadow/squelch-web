import vibe.vibe;
import std.process;
import std.conv;

HTTPServerSettings settings;

void main()
{
	settings = new HTTPServerSettings ;
	 // Provide a default port in case of the $PORT variable isn't set.
        settings.port = environment.get("PORT", "8080").to!ushort;
	listenHTTP(settings, &hello);

	logInfo("Heroku test application started! Listening to port " ~ to!string(settings.port));
	runApplication();
}

void hello(HTTPServerRequest req, HTTPServerResponse res)
{
	res.writeBody("Heroku test application listening to port "~ to!string(settings.port));
}
