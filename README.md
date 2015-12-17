# XcodePluginAdapter

###In English
Everytime you update your xcode to a new version, the plugins can't work.

This is because your xcode has a new uuid now and the plugin doesn't realise this.

The only thing this program will do is to add this new uuid to the info.plist of each plugin

The only thing you need to do after updating your xcode is to run this program once. If the out put is 'Done',

then you can go on coding with various plugins.

###中文版

每次升级Xcode版本时，之前的插件就会失效，这是因为新版本的Xcode有一个新的uuid，而插件不知道，所以插件就无法兼容新版Xcode。
这个程序会获取新的UUID然后依次写入到每个插件的info.plist中。
当你更新Xcode后，只要运行一次这个程序即可完成适配。
