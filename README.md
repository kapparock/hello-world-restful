#hello-world-restful

This <strong>10-liner</strong> program registers a RESTFul resource to the kappaBox. With the program installed, you will be able to see a message <strong>"It worked"</strong> printed on the browser by entering either one of the following URLs:

|`http://192.168.1.1/cgi-bin/api/hello`|`https://river.kapparock.com/user/api/hello`|
|---------|----------|
|![LAN](https://www.dropbox.com/s/rbfdfhpfq2c9vho/local-18.png?dl=1)|![cloud](https://www.dropbox.com/s/ek6fnx65l2f7aay/remote-17.png?dl=1)|
|![LAN](http://doc.kapparock.com/wp-content/uploads/2015/02/local_it_worked.png)|![cloud](https://doc.kapparock.com/wp-content/uploads/2015/02/remote_it_worked.png) |
Assuming the kappaBox connected to the internet, both URLs will return the same thing. The difference is where these two URLs can be used. The first URL can only be used from a device directly connected to kappaBox via ethernet/WiFi, but it will work whether or not the kappaBox is connected to the internet. The second URL requires internet, but it can be used anywhere.

Don't be intimidated by the long URLs. In the code, you only need to specify a relative URI or Uniform Resource Identifier, which is "hello" in this case. The prefixes, `http://192.168.1.1/cgi-bin/api/` and `https://river.kapparock.com/user/api/` determine whethere the request is be routed over the internet or just locally within its LAN. In fact, the URLs are in the form: <pre>&lt;ROOT_URI&gt;/hello </pre> 

where `<ROOT_URI>` can be any of the folowing strings:

|ORIGIN	|ROOT_URI	|NOTE |
|:-------|:-------:|-------|
|LAN	|`http://<gateway IP>/cgi-bin/api/`	|does not depend on internet connection|
|kappa cloud	|`https://river.kapparock.com/user/api/`	|can be used anywhere, internet connection required|
|`<@=WIDGETROOT@>`|automatic substitution| it will be automatic substituted with either LAN or cloud root, the client-side html/javascipt must be originated from kappaBox|

<a href="http://www.kapparock.com"><img src="https://www.dropbox.com/s/0amzlxbfm66t55q/log-name200x32-17-17.svg?dl=1" style="height:25%;"></a>


