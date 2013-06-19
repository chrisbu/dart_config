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
import 'package:dart_config/parsers/config_parser_json.dart';
import 'package:dart_config/parsers/config_parser_yaml.dart';
import 'package:dart_config/config.dart';
import 'dart:io';
import 'dart:async';

final pathMap = new Map<String,String>();
var loaderImpl;



// A list of keys that should be in the pathMap
final SIMPLE_CONFIG_JSON = "SIMPLE_CONFIG_JSON";
final SIMPLE_CONFIG_YAML = "SIMPLE_CONFIG_YAML";
final NESTED_CONFIG_JSON = "NESTED_CONFIG_JSON";
final NESTED_CONFIG_YAML = "NESTED_CONFIG_YAML";
final TEMP_CONFIG_YAML = "TEMP_CONFIG_YAML";

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


    test("nested keys and values", () {
      var config = new Config(pathMap[NESTED_CONFIG_JSON],
          loaderImpl,
          new JsonConfigParser());

      var expectedMap = {"key": {"key2":"value"}};
      var mapMatcher = new MapMatcher(expectedMap);


      var future = config.readConfig();
      expect(future, completion(mapMatcher));
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

    test("nested keys and values", () {
      var config = new Config(pathMap[NESTED_CONFIG_YAML],
          loaderImpl,
          new YamlConfigParser());

      var expectedMap = {"key": {"key2":"value"}};
      var mapMatcher = new MapMatcher(expectedMap);


      var future = config.readConfig();
      expect(future, completion(mapMatcher));
    });
  });
  
  group("temp config:", () {
    File tempConfigFile = new File(pathMap[TEMP_CONFIG_YAML]);
    setUp(() {
      var writer = tempConfigFile.openWrite();
      writer.writeln('message: This file will be deleted.');
      return writer.close();
    });
    
    test("delete config after read", () {
      var config = new Config(pathMap[TEMP_CONFIG_YAML],
          loaderImpl,
          new YamlConfigParser());
            
      var future = config.readConfig().then(
          (res) {
            expect(res, containsPair("message","This file will be deleted."));
            var completer = new Completer<bool>();
            tempConfigFile.delete()
            .then((f) => f.exists())
            .then((exists) => completer.complete(exists))
            .catchError((e) => completer.completeError(e));
            return completer.future;
        }
      );
      expect(future, completion(equals(false)));
    });
  });

}




/*
 * Recursively compares two maps, using brute-force,
 * irrespecitve of order
 */
class MapMatcher implements Matcher {
  var _map;


  MapMatcher(this._map);

  // JSON parse the item back into a map, and compare the two maps
  // (brute force, innefficient)
  bool matches(Map item, MatchState matchState) {
    var result = true;

    // try and compare the item and the map
    return _mapsAreEqual(item, _map);

  }

  Description describe(Description description) {
    description.add("_map: ${_map.toString()}");
    return description;
  }

  Description describeMismatch(item, Description mismatchDescription,
                               MatchState matchState, bool verbose) {
    mismatchDescription.add("item: ${item.toString()}");
    return mismatchDescription;

  }

  bool _listsAreEqual(List one, List two) {
    var i = -1;
    return one.every((element) {
      i++;

      return two[i] == element;
    });
  }

  bool _mapsAreEqual(Map one, Map two) {
    var result = true;

    one.forEach((k,v) {
      if (two[k] != v) {

        if (v is List) {
          if (!_listsAreEqual(one[k], v)) {
            result = false;
          }
        }
        else if (v is Map) {
          if (!_mapsAreEqual(one[k], v)) {
            result = false;
          }
        }
        else {
          result = false;
        }

      }
    });

    two.forEach((k,v) {
      if (one[k] != v) {

        if (v is List) {
          if (!_listsAreEqual(two[k], v)) {
            result = false;
          }
        }
        else if (v is Map) {
          if (!_mapsAreEqual(two[k], v)) {
            result = false;
          }
        }
        else {
          result = false;
        }
      }
    });

    return result;
  }
}