#hello-world-restful

This <strong>10-liner</strong> program registers a RESTFul resource to the kappaBox. With the program installed, you will be able to see a message <strong>"It worked"</strong> printed on the browser by entering either one of the following URLs:

<pre>http://192.168.1.1/cgi-bin/api/<strong>hello</strong></pre>
<pre>https://river.kapparock.com/user/api/<strong>hello</strong></pre>

Assuming the kappaBox connected to the internet, both URLs will return the same thing. The difference is where these two URLs can be used. The first URL can only be used from a device directly connected to kappaBox via ethernet/WiFi, but it will work whether or not the kappaBox is connected to the internet. The second URL requires internet, but it can be used anywhere.

Don't be intimidated by the long URLs. In the code, you only need to specify a relative URI or Uniform Resource Identifier, which is "hello" in this case. The prefixes, `http://192.168.1.1/cgi-bin/api/` and `https://river.kapparock.com/user/api/` determine whethere the request is be routed over the internet or just locally within its LAN. In fact, the URLs are in the form: <pre>`<ROOT_URI>/hello` </pre>
where <pre>`<ROOT_URI>`</pre> can be any of the folowing strings:

|ORIGIN	|ROOT_URI	|NOTE |
|-------|:-------:|-------|
|LAN	|`<gateway IP>/cgi-bin/api/`	|does not depend on internet connection|
|kappa cloud	|`https://river.kapparock.com/user/api/`	|can be used anywhere, internet connection required|




