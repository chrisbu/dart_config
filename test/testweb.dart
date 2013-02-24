library test_web.dart;

import 'package:unittest/unittest.dart';
import 'package:unittest/html_config.dart';

import '../lib/loaders/config_loader_httprequest.dart';
import '../lib/parsers/config_parser_json.dart';
import '../lib/parsers/config_parser_yaml.dart';
import '../lib/config.dart';


main() {
  useHtmlConfiguration();
  
  group("json:", () {
    test("simple key value", () { 
      var config = new Config("configs/testconfig.json", 
          new ConfigHttpRequestLoader(),
          new JsonConfigParser());
      
      var future = config.readConfig();
      expect(future, completion(containsPair("key","value")));
    });
    
  });
  
  group("yaml:", () {
    test("simple key value", () {
      var config = new Config("configs/testconfig.yaml",
          new ConfigHttpRequestLoader(),
          new YamlConfigParser());
      
      var future = config.readConfig();
      expect(future, completion(containsPair("key","value")));
    });
  });
}