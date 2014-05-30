library config_default_browser;

import 'config.dart';
import 'dart:async';
import 'loaders/config_loader_httprequest.dart';
import 'parsers/config_parser_yaml.dart';

Future<Map> loadConfig([String filename="config.yaml"]) {
  var config = new Config(filename,
      new ConfigHttpRequestLoader(),
      new YamlConfigParser());
  
  return config.readConfig();
}

Map loadConfigSync([String filename="config.yaml"]) {
  var config = new Config(filename,
      new ConfigHttpRequestLoader(),
      new YamlConfigParser());

  return config.readConfigSync();
}