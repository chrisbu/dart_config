library config;

import 'dart:async';

/**
 * The main config class.  
 * 
 * Create an instance of this class
 * passing in a the [_configPathOrUrl] of the config file to load,  
 * a [ConfigLoader] implementation and a 
 * [ConfigParser] implmentation.
 * 
 * Then call [readConfig] to load and parse the config.
 * 
 */
class Config  {
  final ConfigLoader _configLoader;
  final ConfigParser _configParser;
  final String _configPathOrUrl;
  
  var configValues;
  
  /**
   * 
   */
  Config(String this._configPathOrUrl,
      ConfigLoader this._configLoader, 
      ConfigParser this._configParser);
  
  /**
   * Loads the config using the [ConfigLoader] and 
   * parses the file using the [ConfigParser]
   * 
   * Returns a [Future<Map>] containing key/value pairs
   * 
   */
  Future<Map> readConfig() {
    var completer = new Completer<Map>();
    
    // load, then parse, then complete
    _configLoader.loadConfig(_configPathOrUrl).then(
        (configText) {
          _configParser.parse(configText).then(
              (Map config) {
                configValues = config;
                completer.complete(config);
              },
              onError: (err) => completer.completeError(err));
        }, 
        onError: (err) => completer.completeError(err));
    
    return completer.future;
  }
  
}

/**
 * Provides a mechanism for a config to be loaded.  From the 
 * filesystem (in server-side Dart), or from a URL in the browser 
 * (in client side Dart) are just two possible locations.
 */
abstract class ConfigLoader {
  
  
  /**
   * A config loader will load the config data from the [pathOrUrl], and
   * return the contents of the file as a `Future<String>`
   */
  Future<String> loadConfig(pathOrUrl);

}

/**
 * Provides a mechanism for a config to be parsed
 * Configs are always extracted as a `Map<String,Object>`, with
 * the map's value being one of the "primitive" Dart types:  `Map`, `List`, 
 * `int`, `num`, `double`, `String`, `bool`, `null`.
 */
abstract class ConfigParser {
  
  /**
   * Returns a Config object from the parsed config file.
   */
  Future<Map<String,Object>> parse(String configText);
}