library test_browser;

import 'package:unittest/unittest.dart';
import 'package:unittest/html_config.dart';

import 'package:dart_config/loaders/config_loader_httprequest.dart';
import 'package:dart_config/parsers/config_parser_json.dart';
import 'package:dart_config/parsers/config_parser_yaml.dart';
import 'package:dart_config/config.dart';

import 'tests.dart' as tests;

main() {
  useHtmlConfiguration();

  tests.pathMap[tests.SIMPLE_CONFIG_JSON] = "configs/testsimpleconfig.json";
  tests.pathMap[tests.NESTED_CONFIG_JSON] = "configs/testnestedconfig.json";
  tests.pathMap[tests.SIMPLE_CONFIG_YAML] = "configs/testsimpleconfig.yaml";
  tests.pathMap[tests.NESTED_CONFIG_YAML] = "configs/testnestedconfig.yaml";
  tests.loaderImpl = new ConfigHttpRequestLoader();
  tests.runTests();
}
