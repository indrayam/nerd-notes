# chrome

## Google Chrome forcibly redirects all calls to a host to HTTPS

**Why is this an issue?**

I had setup an Nginx proxy on a new host. Let's say the DNS entry for this host was `example.com`. I configured Nginx to redirect all HTTP requests to HTTPS. Things worked swimmingly well after that for  a bit. Then one day, I setup another HTTP listener. The actual software providing HTTP listener behavior does not really matter. This HTTP listener was listening on port 1234. Again, the actual port number does not matter.

When I went to Chrome to connect to this new HTTP listener by typing the following in the URL bar:

> example.com:1234


I kept getting the following error in Google Chrome:

> This site can’t provide a secure connection hackmd.cisco.com sent an invalid response. ERR_SSL_PROTOCOL_ERROR

I could not understand why I kept getting the error. Accessing the same URL using `curl` did no such thing. Even using a different browser (which I had not used before to connect to example.com) did no such thing. 

This Stackoverflow article came to the rescue:

Source: [Google Chrome redirecting localhost to https](https://stackoverflow.com/questions/25277457/google-chrome-redirecting-localhost-to-https)

Turns out this issue had nothing to do with my new HTTP listener or the Nginx configuration. The real culprit was [HSTS](http://en.wikipedia.org/wiki/HTTP_Strict_Transport_Security).

As the article said, to get around it, I did the following:

- In the Chrome address bar type "chrome://net-internals/#hsts"
- Look for *Query HSTS/PKP domain* textbox. Enter `example.com` to see if the DNS entry is known to the browser. In my case, I got the following:

```bash
Found:
static_sts_domain: 
static_upgrade_mode: UNKNOWN
static_sts_include_subdomains: 
static_sts_observed: 
static_pkp_domain: 
static_pkp_include_subdomains: 
static_pkp_observed: 
static_spki_hashes: 
dynamic_sts_domain: example.com
dynamic_upgrade_mode: FORCE_HTTPS
dynamic_sts_include_subdomains: true
dynamic_sts_observed: 1550755186.191118
dynamic_sts_expiry: 1582291186.191114
```

If it says "Not found" then this is not the answer you are looking for.

- If it is, DELETE the `example.com` domain using the *Delete domain security policies* textbox. 

After that, I was able to make calls using HTTP to `1234`
