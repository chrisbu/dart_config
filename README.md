dart_config
===========

## Config files for the client and server.

Do you have code that looks like this?

    var myServerUrl = "http://localhost/foo"; // local server
    //var myServerUrl = "http://awesomeapp.com/foo"; // real server
 

Do you wish you could load settings from a config file, like this yaml below:

    # local server config.yaml
    myServerUrl: http://localhost/foo
    
or 

    # real server config.yaml
    myServerUrl: http://awesomeapp.com/foo

Now you _can_, with the same syntax whether you're running Dart in the browser,
or running Dart on the server.

### Instructions

**1.** Add a dependency to `pubspec.yaml` for `dart_config`:

    dependencies
      dart_config: any
      
**2.** If you are running in the **browser**, add the following code to
  your app to load config information from the server:

    import 'package:dart_config/default_browser.dart';
    
    main() {
      loadConfig().then(
        (Map config) {
         print(config["myServerUrl"]);
         // continue with your app here!
        }, 
        onError: (error) => print(error));
    }
    
**2.** If you are running in the **server**, add the following code to your app to
load config information from the filesystem:
 
    import 'package:dart_config/default_server.dart';
    
    main() {
      loadConfig().then(
        (Map config) {
         print(config["myServerUrl"]);
         // continue with your app here!
        }, 
        onError: (error) => print(error));
    }
    
### What just happened?

Both the client and server code looks for a file called `config.yaml`, loads 
it from the current folder (or current browser path), parses it, and returns
it to your app as a map of key/value pairs (the values may also be maps 
themselves).

Take a look at `test/test_default_browser.dart` and 
`test/test_default_server.dart`, and the associated `config.yaml` files.

### Want more control?

Of course you want more control!  The `loadConfig()` function actually takes
an optional `filename` parameter, which defaults to `config.yaml` - but you
can provide a different filename / path if you want.

### Want even more control?

Of course you do.  The `default_browser` and `default_server` libraries are 
just opinionated implementations.  Behind the scenes, they are calling code that
looks similar to this:

    var config = new Config(filename,
      new ConfigFilesystemLoader(),
      new YamlConfigParser());
  
    return config.readConfig(); // returns a Future<Map>
    
The `Config` class has a single constructor, which takes three parameters.
The first parameter is the location of the config file.  The second is an
implementation of `ConfigLoader`, and the third is an implementation of 
`ConfigParser` (this is a typical dependency injection pattern)

The `dart_config` library comes (at the moment) with two ConfigLoader 
implementations and two ConfigParser implementations:
 
[`ConfigLoaders`](https://github.com/chrisbu/dart_config/tree/master/lib/loaders):
 
- `ConfigFilesystemLoader`
- `ConfigHttpRequestLoader`

[`ConfigParsers`](https://github.com/chrisbu/dart_config/tree/master/lib/parsers):

- `YamlConfigParser`
- `JsonConfigParser`

You can use any combination of loader and parser.  At its core, the config 
system needs to know **how to load a config file** and **how to parse a config
file**.  It really is no more complex than that.

Take a look at the three files: `tests.dart` (a VM independant suite of tests), 
and the `test_browser.dart` and `test_server.dart`, which run the same set of 
tests found in `tests.dart` both in the browser and on the server.  The only
differences are `ConfigLoader` implementation, and the path to the config files.

### Want to load a config file that looks like "x"?

No problem - simply implement your own version of `ConfigLoader` - there's only
one method: `Future<String> loadConfig(pathOrUrl)` - just return the contents
of the config file in the Future<String>, and it will get passed into whatever
parser you specify.

### Want to parse a config file of type "y"?

No problem again - simply implement your own version of `ConfigParser` - there's
only one method: `Future<Map<String,Object>> parse(String configText)` - just
parse the String contents that the ConfigLoader has loaded into a Map, and 
return it in a Future.

### Written your own config loader / parser?

Great! - Please share :) - create your own pub package containing loaders and/
or parsers, or clone this library and issue pull requests. 

Some ideas (that I might work on if someone else doesn't get there first):

- [TOML](https://github.com/mojombo/toml) parser
- Key=value pair parser
- Server-side HttpClient configLoader - load config files from a remote url 
  
  
### Found a bug?  

Raise an [issue on github](https://github.com/chrisbu/dart_config/issues) 
and I'll take a look, or even better, create 
a [pull request](https://github.com/chrisbu/dart_config/pulls) with
a failing unit test or even a fix?

### Got a question?

StackOverflow is a great place for that.  Make sure you use the 
[dart](http://stackoverflow.com/questions/tagged/dart) tag, and it will find 
its way to me, or others that are very knowledgeable.
