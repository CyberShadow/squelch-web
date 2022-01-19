import std.process : environment;
import std.stdio : File;

import vibe.vibe;

import ae.sys.file : readFile;

import squelch.lex;
import squelch.format;
import squelch.write;

void formatSQL(HTTPServerRequest req, HTTPServerResponse res)
{
	auto src = req.form["sql"];
	auto tokens = lex(src);
	tokens = format(tokens);
	auto o = File.tmpfile();
	save(tokens, o);
	o.seek(0);
	src = cast(string)readFile(o);
	res.writeBody(src, "text/plain");
}

void main()
{
	auto settings = new HTTPServerSettings ;
	 // Provide a default port in case of the $PORT variable isn't set.
	settings.port = environment.get("PORT", "8080").to!ushort;

	auto router = new URLRouter;
	router.post("/format", &formatSQL);
	router.get("*", serveStaticFiles("./public/"));

	listenHTTP(settings, router);

	runApplication();
}
