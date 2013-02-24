library config_default_server;

import 'config.dart';
import 'dart:async';
import 'loaders/config_loader_filesystem.dart';
import 'parsers/config_parser_yaml.dart';

Future<Map> loadConfig([String filename="config.yaml"]) {
  var config = new Config(filename,
      new ConfigFilesystemLoader(),
      new YamlConfigParser());
  
  return config.readConfig();
}