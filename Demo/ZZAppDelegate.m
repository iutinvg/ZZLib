/*
 * Copyright (c) Sevencrayons.com <iutinvg@gmail.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZAppDelegate.h"
#import "ZZDemoCatalog.h"
#import "ZZURLHelper.h"
#import "ZZDebug.h"

@implementation ZZAppDelegate

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // the params to add to every request
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"4a6b9d8c09da17219420854c90c0776a", @"api_key",
                            @"json", @"format",
                            @"1", @"nojsoncallback",
                            nil];
    [ZZURLHelper startWithBaseURL:@"https://api.flickr.com/services/rest/" persistentParams:params];
    
	_window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

	ZZDemoCatalog* demoCatalog = [[ZZDemoCatalog alloc] init];	
	UINavigationController* nc = [[UINavigationController alloc] initWithRootViewController:demoCatalog];
	
	_window.rootViewController = nc;
    [_window makeKeyAndVisible];
    
    return YES;
}

@end
