Running Tests
=============

Unit tests
-----------

From this folder, run `test_server.dart` for server-side config testing, and 
`test_browser.html` for client-side testing.  

They both try and load the config files listed in the `/configs` folder.

Examples
--------

To check out the super-simple default config file loading (which lets you 
use convention over configuration to just load a `config.yaml` file, run the 
`test_default_server.dart` or `test_default_browser.html` files.  These are not
tests, instead, they output some text to the Dart Editor console.

    "If you can read this, then the browser config has been read successfully" 