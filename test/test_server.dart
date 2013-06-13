library config_filesystem_test;

import 'package:dart_config/loaders/config_loader_filesystem.dart';

import 'package:unittest/unittest.dart';
import 'tests.dart' as tests;

main() {
  tests.pathMap[tests.SIMPLE_CONFIG_JSON] = "configs/testsimpleconfig.json";
  tests.pathMap[tests.NESTED_CONFIG_JSON] = "configs/testnestedconfig.json";
  tests.pathMap[tests.SIMPLE_CONFIG_YAML] = "configs/testsimpleconfig.yaml";
  tests.pathMap[tests.NESTED_CONFIG_YAML] = "configs/testnestedconfig.yaml";
  tests.loaderImpl = new ConfigFilesystemLoader();
  tests.runTests();
}

