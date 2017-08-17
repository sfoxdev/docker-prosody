-- Prosody Configuration File
--
-- Information on configuring Prosody can be found on our
-- website at http://prosody.im/doc/configure
--
-- Tip: You can check that the syntax of this file is correct
-- when you have finished by running: luac -p prosody.cfg.lua
-- If there are any errors, it will let you know what and where
-- they are, otherwise it will keep quiet.


---------- Server-wide settings ----------
-- Settings in this section apply to the whole server and are the default settings
-- for any virtual hosts

-- Listen on IPv4 interfaces only
--interfaces = { "*" }

-- This is a (by default, empty) list of accounts that are admins
-- for the server. Note that you must create the accounts separately
-- (see http://prosody.im/doc/creating_accounts for info)
-- Example: admins = { "user1@example.com", "user2@example.net" }
admins = { "sfox@example.com", "sfoxdev@example.com" }

run_as_root = true;

-- Enable use of libevent for better performance under high load
-- For more information see: http://prosody.im/doc/libevent
use_libevent = true;

-- These paths are searched in the order specified, and before the default path
plugin_paths = { "/usr/lib/prosody/additional_modules" }

-- This is the list of modules Prosody will load on startup.
-- It looks for mod_modulename.lua in the plugins folder, so make sure that exists too.
-- Documentation on modules can be found at: http://prosody.im/doc/modules
modules_enabled = {
    -- Generally required
    "roster"; -- Allow users to have a roster. Recommended ;) (includes XEP-0237, Roster Versioning)
    "saslauth"; -- Authentication for clients and servers. Recommended if you want to log in.
    "tls"; -- Add support for secure TLS on c2s/s2s connections
    "dialback"; -- s2s dialback support
    "disco"; -- Service discovery

    -- Not essential, but recommended
    "private"; -- Private XML storage (for room bookmarks, etc.)
    "vcard"; -- Allow users to set vCards

    -- These are commented by default as they have a performance impact
    "privacy"; -- Support privacy lists
    --"compression"; -- Stream compression (Debian: requires lua-zlib module to work)

    -- Nice to have
    "version"; -- Replies to server version requests
    "uptime"; -- Report how long server has been running
    "time"; -- Let others know the time here on this server
    "ping"; -- Replies to XMPP pings with pongs
    "pep"; -- XEP-0163, Personal Eventing Protocol (Enables users to publish their mood, activity, playing music and more)
    "register"; -- Allow users to register on this server using a client and change passwords

    -- Admin interfaces
    "admin_adhoc"; -- Allows administration via an XMPP client that supports ad-hoc commands
    --"admin_telnet"; -- Opens telnet console interface on localhost port 5582

    -- HTTP modules
    "http"; -- Enable the HTTP server
    "register_web"; -- Enable web registration
    --"http_files"; -- Serve static files from a directory over HTTP
    "http_upload"; -- XEP-0363, HTTP File Upload
    "bosh"; -- XEP-0206 and XEP-0124, BOSH clients, aka "Jabber over HTTP"
    --"websocket"; -- RFC-7395, XMPP over WebSockets (0.10+)
    "http_altconnect"; -- XEP-0156, Discovering Alternative XMPP Connection Methods

    -- Other specific functionality
    "posix"; -- POSIX functionality, sends server to background, enables syslog, etc.
    "groups"; -- Shared roster support
    --"announce"; -- Send announcement to all online users
    --"welcome"; -- Welcome users who register accounts
    --"watchregistrations"; -- Alert admins of registrations
    --"motd"; -- Send a message to users when they log in
    --"legacyauth"; -- Legacy authentication. Only used by some old clients and bots.
    "limit_auth"; -- protect against password brute force: https://modules.prosody.im/mod_limit_auth.html
    --"register_redirect"; -- XEP-0077, section 5

    -- Modern XEPs
    "smacks"; -- XEP-0198, Stream Management
    "smacks_offline";
    "pinger";
    "mam"; -- XEP-0313, Message Archive Management (MAM)
    "blocking"; -- XEP-0191, Blocking Command
    "carbons"; -- XEP-0280, Message Carbons
    "cloud_notify"; -- XEP-0357, Push Notifications
    "csi"; -- XEP-0352, Client State Indication
    "filter_chatstates"; -- XEP-0352, Client State Indication
    "throttle_presence"; -- XEP-0352, Client State Indication
    --"vjud"; -- Jappix user directory search
    "muc_log";
    --"support_contact";
    --"reload_modules";
    --"pubgroups";
    "group_bookmarks";
};

-- These modules are auto-loaded, but should you want
-- to disable them then uncomment them here:
modules_disabled = {
    -- "offline"; -- Store offline messages
    -- "c2s"; -- Handle client connections
    -- "s2s"; -- Handle server-to-server connections
};

-- Disable account creation by default, for security
-- For more information see http://prosody.im/doc/creating_accounts
allow_registration = true;

-- Debian:
--   send the server to background.
daemonize = false;

-- Debian:
--   Please, don't change this option since /var/run/prosody/
--   is one of the few directories Prosody is allowed to write to
pidfile = "/var/run/prosody/prosody.pid";

-- These are the SSL/TLS-related settings. If you don't want
-- to use SSL/TLS, you may comment or remove this
ssl = {
    key = "certs/localhost.key";
    certificate = "certs/localhost.crt";
}

-- Force clients to use encrypted connections? This option will
-- prevent clients from authenticating unless they are using encryption.

c2s_require_encryption = true

-- Force certificate authentication for server-to-server connections?
-- This provides ideal security, but requires servers you communicate
-- with to support encryption AND present valid, trusted certificates.
-- NOTE: Your version of LuaSec must support certificate verification!
-- For more information see http://prosody.im/doc/s2s#security

s2s_secure_auth = false

-- Many servers don't support encryption or have invalid or self-signed
-- certificates. You can list domains here that will not be required to
-- authenticate using certificates. They will be authenticated using DNS.

--s2s_insecure_domains = { "gmail.com" }

-- Even if you leave s2s_secure_auth disabled, you can still require valid
-- certificates for some domains by specifying a list here.

--s2s_secure_domains = { "jabber.org" }

-- HTTP CONFIG --
-- We run an Apache reverse-proxy on the server. It redirects all traffic from
-- HTTP (port 80) to HTTPS (port 443). It also handels Let's Encrypt
-- verification. All traffice on port 443 is forwarded to Prosody which runs on
-- it's default ports (see below).

--http_ports = { 5280 }
--http_interfaces = { "*" }
--https_ports = { 5281 }
--https_interfaces = { "*" }
VirtualHost = "localhost"
--VirtualHost = "www.jabber.example.com"
VirtualHost = "example.com"
http_host = "example.com"
http_default_host = "example.com"
https_ssl = {
    key = "certs/localhost.key";
    certificate = "certs/localhost.crt";
}

-- The paths used by various HTTP modules
http_paths = {
    register_web = "/register-on-$host";
}

-- Maximum file size for http_upload
http_upload_file_size_limit = 10485760 -- 10 MB
http_upload_expire_after = 2592000 -- 60*60*24*30 - 30 days

--http_upload_external_base_url = "https://otr.ddp.chat/upload/"
--http_upload_external_secret = "L1G0V4RnwFa6L1G0a6L1G0V4RnwFV4RaV4RnwFnwF"
--http_upload_external_file_size_limit = 104857600 -- 1024*1024*100 - 100 MB

-- Inform prosody about it's public / external Address. This is required
-- when running Prosody behind a proxy. Used by http_upload and mosh.
-- We trick all modules into using HTTPS only with this trick.
http_external_url = "https://example.com:443/"
https_external_url = "https://example.com:443/"

-- Configure BOSH
-- Since we're always using HTTPS, we can regard our connections as secure
consider_bosh_secure = true;
-- Allow cross-domain Javascript execution. Makes sense since we're not offering a Webclient ourselves
cross_domain_bosh = true;

-- Configuration of the websockets module
--consider_websocket_secure = true;
--cross_domain_websocket = true;

-- We're not using http_files
--http_files_dir = "/var/www/prosody";

-- Configure register redirect
registrarion_url = "https://example.com/jabber.html"
registration_text = "In-band registration is disabled. Please register your account via our website https://example.com/jabber.html"

-- Push Notification test
push_notification_with_body = true
push_notification_with_sender = true

------------------ Extra modules and tuning --------------------------------------------------------------------------------

c2s_idle_timeout = 30
c2s_ping_timeout = 30

smacks_hibernation_time = 300 -- 300 (5 minutes) The number of seconds a disconnected session should stay alive for (to allow reconnect)
smacks_enabled_s2s = true -- Enable Stream Management on server connections
smacks_max_unacked_stanzas = 0 -- How many stanzas to send before requesting acknowledgement
smacks_max_ack_delay = 60 -- 60 (1 minute) The number of seconds an ack must be unanswered to trigger an "smacks-ack-delayed" event
smacks_max_hibernated_sessions = 10 -- The number of allowed sessions in hibernated state (limited per user)
smacks_max_old_sessions = 10 -- The number of allowed sessions with timed out hibernation for which the h-value is still kept (limited per user)

muc_log_by_default = true; -- Enable logging by default (can be disabled in room config)
muc_log_all_rooms = true; -- set to true to force logging of all rooms
--max_history_messages = 20; -- This is the largest number of messages that are allowed to be retrieved when joining a room.

vjud_mode = "all" -- all/opt-in

groups_file = "/etc/prosody/prosody.groups.txt"

group_bookmarks_file = "/etc/prosody/prosody.group.bookmarks.txt"

--pubgroups_file = "/etc/prosody/prosody.pubgroups.txt"

--reload_modules = { "groups" }


--support_contact_group = "support"

---------------------------------------------------------------------------------------------------------------------------


-- Select the authentication backend to use. The 'internal' providers
-- use Prosody's configured data storage to store the authentication data.
-- To allow Prosody to offer secure authentication mechanisms to clients, the
-- default provider stores passwords in plaintext. If you do not trust your
-- server please see http://prosody.im/doc/modules/mod_auth_internal_hashed
-- for information about using the hashed backend.

authentication = "internal_hashed"

-- Select the storage backend to use. By default Prosody uses flat files
-- in its configured data directory, but it also supports more backends
-- through modules. An "sql" backend is included by default, but requires
-- additional dependencies. See http://prosody.im/doc/storage for more info.

storage = "sql"

-- For the "sql" backend, you can uncomment *one* of the below to configure:
sql = {
    driver = "MySQL",
    database = "prosody",
    username = "admin",
    password = "a6L1G0V4RnwF",
    host = "mariadb"
}

-- Logging configuration
-- For advanced logging see http://prosody.im/doc/logging
--
-- Debian:
--  Logs info and higher to /var/log
--  Logs errors to syslog also
log = {
    warn = "/var/log/prosody/prosody.log";
    error = "/var/log/prosody/prosody.err";
    info = "/var/log/prosody/prosody.info.log";
    --debug = "/var/log/prosody/prosody.debug.log";
    -- Syslog:
    { levels = { "error" }; to = "syslog";  };
}

------ Components ------
-- You can specify components to add hosts that provide special services,
-- like multi-user conferences, and transports.
-- For more information on components, see http://prosody.im/doc/components

---Set up a MUC (multi-user chat) room server on conference.example.com:
Component "conference.example.com" "muc"
    --name = "The otr.ddp.chat chatrooms server"
    restrict_room_creation = true -- If true will only allow admins to create new chatrooms otherwise anyone can create a room
    max_history_messages = 20 -- This is the largest number of messages that are allowed to be retrieved when joining a room.
    modules_enabled = {
    mam_muc;
    }

-- Set up a SOCKS5 bytestream proxy for server-proxied file transfers:
Component "proxy.example.com" "proxy65" -- XEP-0065, SOCKS5 Bytestreams
    proxy65_address = "example.com"
    proxy65_acl = { "example.com" }

---Set up a PubSub server
Component "pubsub.example.com" "pubsub"

---Set up a VJUD service
Component "search.example.com" "vjud"


---Set up an external component (default component port is 5347)
--
-- External components allow adding various services, such as gateways/
-- transports to other networks like ICQ, MSN and Yahoo. For more info
-- see: http://prosody.im/doc/components#adding_an_external_component
--
--Component "gateway.example.com"
--	component_secret = "password"

------ Additional config files ------
-- For organizational purposes you may prefer to add VirtualHost and
-- Component definitions in their own config files. This line includes
-- all config files in /etc/prosody/conf.d/

Include "conf.d/*.cfg.lua"
