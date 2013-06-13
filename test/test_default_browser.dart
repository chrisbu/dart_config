library test_default_browser;

import 'package:dart_config/default_browser.dart' as browser_config;

main() {
   browser_config.loadConfig().then(
      (Map config) => print(config["message"]),
      onError: (error) => print(error));
}
