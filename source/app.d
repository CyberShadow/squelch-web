import vibe.vibe;
import std.process;

void main()
{
	auto settings = new HTTPServerSettings;
	 // Provide a default port in case of the $PORT variable isn't set.
        settings.port = environment.get("PORT", "8080").to!ushort;
	settings.bindAddresses = ["::1", "127.0.0.1"];
	listenHTTP(settings, &hello);

	logInfo("Please open http://127.0.0.1:8080/ in your browser.");
	runApplication();
}

void hello(HTTPServerRequest req, HTTPServerResponse res)
{
	res.writeBody("Hello, World!");
}
