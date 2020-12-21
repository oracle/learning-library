# Text Blocks

## Introduction

A text block is a multi-line string literal that avoids the need for most escape sequences, automatically formats the string predictably, and gives the developer control over format when desired. The Text Blocks feature has been previewed in Java 13 and Java 14, and is now a final and permanent feature in Java 15.

Estimated Lab Time: 10 minutes

### Objectives
In this lab, you will use *Text Blocks*, a new Java 15 standard feature.

## Text Blocks in more details

Text blocks enable us to easily embed string literals spanning multiple lines (ex. structured languages such as JSON, XML, etc.) into Java source code while preserving the formatting but also the Java code readability.

For example, imagine that you have to embed in your Java code an HTML snippet that displays _All I want to see is a "_. Before Text Blocks, you would write something like

```
var element = "<p id=\"p1\">All I want to see is a \"</p>";
```

Notice that the HTML _id_ element attribute above requires its value to be enclosed in double-quotes, so those double quotes need to be escaped in the Java code. 

Things get worst if you want to preserve the readability and the formatting of the snippet. For example, to embed the following basic HTML list in Java code.

```
<ul id="example">
    <li><a href="https://abc.org/">ABC</a></li>
    <li><a href="https://xyz.org/">XYZ</a></li>
</ul>
```
you would have to write something like this

```
var example =  "<ul id=\"example\">\n" +
               "   <li><a href=\"https://abc.org/\">ABC</a></li>\n" +
               "   <li><a href=\"https://xyz.org/\">XYZ</a></li>\n" +
               "</ul>";
```


Not only such code is not easily readable, but it is hard to write and error-prone! 

Thanks to Text Blocks, it is now a lot easier! A text block is simply a [String](https://docs.oracle.com/en/java/javase/14/docs/api/java.base/java/lang/String.html) literal delimited with the new triple-quote delimiter (`"""`) instead of the traditional double-quote delimiter (`"`).

```
var element = """
        <ul id="example">
            <li><a href="https://abc.org/">ABC</a></li>
            <li><a href="https://xyz.org/">XYZ</a></li>
        </ul>
        """; 
```

As you can see from the example below
- a Text Block starts and ends with a triple-quote delimiter (`"""`)
- the line after the triple-quote opening delimiter should be empty or blank
- any double-quote embedded in the string shouldn't be escaped
- the string literal can span multiple lines without any additional escaping (\n)
- the closing delimiter drives the formatting
- the original formatting is preserved
- the code readability is improved

To preserve formatting while improving code readability, Text Blocks differentiate incidental white space, from essential white spaces. Incidental white spaces are only useful to improve code readability, they will be stripped away automatically by the Java compiler.

The following example is identical to the previous one but it doesn't use incidental white space, this impacts the code formating and hence its readability.

```
var element = """
<ul id="example">
   <li><a href="https://abc.org/">ABC</a></li>
   <li><a href="https://xyz.org/">XYZ</a></li>
</ul>
"""; 
```
The triple-quote closing delimiter defines how incidental white spaces are handled. You can check the resources at the end for more details on those rules.


## Add Text Blocks support

In the `Main.java` class, you can notice when in the routings that the application uses Helidon's Web Server [Static Content support](https://helidon.io/docs/v2/#/se/webserver/06_static-content-support) to expose some static content.

`nano src/main/java/conference/Main.java`

```
Routing.builder()
       .register("/public", 
                 StaticContentSupport.builder("public")
                 .welcomeFileName("index.html"))
...
```

This static content is exposed under the `/public` path, and is served from the `/public` directory in the `/resources` directory of the application. `index.html`is the default file served.

Run the application and access from your browser the `/public` url, ex. `http://{public-ip}:8080/public`. You should get a basic UI to list speakers.
![](.././images/lab5-1.png " ") 

If you access the root path, you will get en error as there is no handler defined to handle this path. 

![](.././images/lab5-2.png " ") 


To fix this, any HTTP request to the `/` path should be forwarded to the `/public` path.


1. In the `createRouting` method, define a Text Block that embeds some HTML content that will trigger a client-side forward to the `/public` path.


`nano src/main/java/conference/Main.java`

```
var snippet = """
              <html>
                 <title>Almost there</title>
                 <body>
                    You are being redirected...
                    <meta http-equiv="refresh" content="0; url=/public/" />
                 </body>
              </html>
              """;
```

2. Update the application routing to also serve that HTML whenever someone hits the root `/` path.


```
return Routing.builder()
        .get("/", (req, res) -> {
             res.send(snippet);})
        .register("/public", 
             StaticContentSupport.builder("public")
                                 .welcomeFileName("index.html"))
        .register("/speakers", speakerService)
        .build();
```

Let's check the following snippet

```
.get("/", (req, res) -> {
        res.send(snippet);})
```

It defines a [handler](https://helidon.io/docs/v2/apidocs/io.helidon.webserver/io/helidon/webserver/Handler.html) for any HTTP GET requests under the `/` path.  It has one method ([accept](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/function/BiConsumer.html?is-external=true#accept(T,U))) that takes a `BiConsumer<ServerRequest, ServerResponse>` to handle the request. In this case, we pass it a Lambda expression that sends the HTML snippet that will trigger the forward on the client-side.



3. Test the application

Compile, and access the application from a browser, `http://{public-ip}:8080/`


![](.././images/lab5-3.png " ") 

You can notice that the HTML formatting has been preserved which is good but that is not really what we expected as the HTML is not rendered! To understand the issue, use `curl` to get more details on the HTTP request/response.


```
> curl -v http://{public-ip}:8080
...
< HTTP/1.1 200 OK
< Content-Type: text/plain
...
```

You can see that the content type of the HTTP response is set to `text/plain` and not `text/html`, that explains why the HTML is not parsed by the browser. You can easily fix that by correctly setting the MediaType header before sending the response. 

```
.get("/", (req, res) -> {
        res.headers().contentType(MediaType.TEXT_HTML);
        res.send(snippet);})
```

💡 Make sure to update the imports to include `import io.helidon.common.http.MediaType`

Now when you access the root path, your browser should be automatically redirected to the simple HTML UI.


4. Understand how Text Block works.

Remove `<meta http-equiv="refresh" content="0; url=/public/" />` from the text block. Tweak and try mutilple variations of the HTML snippet to understand how the incidental spaces are handled. 

💡 You might want to check the resources suggested in the next section to understand some behaviors.

```
message = """
          <p>
            Does this work?
          </p>""";
```

```
message = """<p>
                What about this?
             </p>
             """;
```

```
message = """
          <p>
        And this?
      </p>
    """;
```

```
message = """
          <p>A single line Text Block?</p>""";
```

## Wrap-up


In this exercise, you have used text block, a standard Java 15 feature, to easily embed HTML into Java code. 

Simply put, text blocks enable developers to easily embed string literals spanning multiple lines into Java source code while preserving the original formatting but also the Java code readability. Text blocks are handy to deal with structured languages (ex. HTML, JSON, XML, etc.) without having to worry about escaping special characters (ex. new line, double quote) nor altering the original formatting.

Check the following resources for more details on Text Blocks.

* [JEP 378: Text Blocks](https://openjdk.java.net/jeps/378)
* [Programmer's Guide To Text Blocks](https://inside.java/2019/08/06/text-blocks-guide/)
* [Java Feature Spotlight: Text Blocks](https://inside.java/2020/05/01/spotlighttextblocks/)

*You can proceed to the next lab*

## Acknowledgements

 - **Author** - [David Delabassee](https://delabassee.com)
 - **Last updated By** - Kamryn Vinson, September 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.









