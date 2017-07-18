VirtualHost "example.com"
	enabled = true
	ssl = {
        key = "certs/localhost.key";
        certificate = "certs/localhost.crt";
	};

disco_items = {
    { "proxy.example.com", "The example.com SOCKS5 service" };
    { "conference.example.com", "The example.com MUC" };
}
