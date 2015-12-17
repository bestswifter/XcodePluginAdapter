//
//  main.m
//  XcodePluginAdapter
//
//  Created by 张星宇 on 15/12/17.
//  Copyright © 2015年 张星宇. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PLIST_PATH @"/Applications/Xcode.app/Contents/Info.plist"

// When you update your xcode to a new version, the plugins can't work
// This is because your xcode has a uuid now and the plugin doesn't know this
// The only thing this code snippet do is add this new uuid to the info.plist of each plugin

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *currentUsername = NSUserName();
        NSString *pluginPath = [NSString stringWithFormat:@"/Users/%@/Library/Application Support/Developer/Shared/Xcode/Plug-ins", currentUsername];
        
        NSDictionary *xcodeInfoDictionary = [[NSDictionary alloc] initWithContentsOfFile:PLIST_PATH];
        NSString *xcodeUUID = xcodeInfoDictionary[@"DVTPlugInCompatibilityUUID"];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSError *error;
        NSArray *pathArray = [fileManager contentsOfDirectoryAtPath:pluginPath error:&error];  // Get path of all files in Plug-ins file.
        if (!error) {
            for (NSString *fileName  in pathArray) {
                if ([fileName hasSuffix:@".xcplugin"]) {
                    NSString *pluginPlistPath = [NSString stringWithFormat:@"%@/%@/Contents/Info.plist", pluginPath, fileName];
                    NSDictionary *pluginInfoDictionary = [[NSDictionary alloc] initWithContentsOfFile:pluginPlistPath];
                    NSMutableArray *supportedUUIDs = [NSMutableArray arrayWithArray:pluginInfoDictionary[@"DVTPlugInCompatibilityUUIDs"]];
                    
                    if (![supportedUUIDs containsObject:xcodeUUID]) {
                        [supportedUUIDs addObject:xcodeUUID];
                        [pluginInfoDictionary setValue:supportedUUIDs forKey:@"DVTPlugInCompatibilityUUIDs"];
                        [pluginInfoDictionary writeToFile:pluginPlistPath atomically:YES];
                    }
                }
            }
            NSLog(@"Done");
        }
        else{
            NSLog(@"Wrong path");
        }
    }
    
    return 0;
}
