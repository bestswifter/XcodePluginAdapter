# XcodePluginAdapter

Everytime you update your xcode to a new version, the plugins can't work.

This is because your xcode has a new uuid now and the plugin doesn't realise this.

The only thing this program will do is to add this new uuid to the info.plist of each plugin
