library config_filesystem_test;

import '../lib/loaders/config_loader_filesystem.dart';
import '../lib/parsers/config_parser_json.dart';
import '../lib/parsers/config_parser_yaml.dart';
import '../lib/config.dart';

import 'package:unittest/unittest.dart';

main() {
  
  group("json:", () {
    test("simple key value", () { 
      var config = new Config("test/configs/testconfig.json", 
          new ConfigFilesystemLoader(),
          new JsonConfigParser());
      
      var future = config.readConfig();
      expect(future, completion(containsPair("key","value")));
    });
    
  });
  
  group("yaml:", () {
    test("simple key value", () {
      var config = new Config("test/configs/testconfig.yaml",
          new ConfigFilesystemLoader(),
          new YamlConfigParser());
      
      var future = config.readConfig();
      expect(future, completion(containsPair("key","value")));
    });
  });
}

