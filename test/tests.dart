/** This is a general purpose library of tests that can be called from both
 * the client-side "test_browser_host.dart" script, and the server-side 
 * "test_server_host.dart" script.  
 *  
 * The [pathMap] top-level getter needs to be setup before running the tests
 * to enable the tests to run.  This simply contains the paths to the config
 * files - which are either going to be filesystem paths, or paths accessible 
 * from a browser.   
 * 
 * The [loader] should be set with the relevant loader
 * 
 * The test host should call the top-level function [runTests]
 */
library config_tests;

import "package:unittest/unittest.dart";
import '../lib/parsers/config_parser_json.dart';
import '../lib/parsers/config_parser_yaml.dart';
import '../lib/config.dart';


final pathMap = new Map<String,String>();
var loaderImpl;



// A list of keys that should be in the pathMap
final SIMPLE_CONFIG_JSON = "SIMPLE_CONFIG_JSON";
final SIMPLE_CONFIG_YAML = "SIMPLE_CONFIG_YAML";

// This is the method 
void runTests() {
  _jsonTests();
  _yamlTests();
}

void _jsonTests() {
  group("json:", () {
    test("simple key value", () { 
      var config = new Config(pathMap[SIMPLE_CONFIG_JSON], 
          loaderImpl,
          new JsonConfigParser());
      
      var future = config.readConfig();
      expect(future, completion(containsPair("key","value")));
    });
    
  });
}


void _yamlTests() {
  group("yaml:", () {
    test("simple key value", () {
      var config = new Config(pathMap[SIMPLE_CONFIG_YAML],
          loaderImpl,
          new YamlConfigParser());
      
      var future = config.readConfig();
      expect(future, completion(containsPair("key","value")));
    });
  });
}