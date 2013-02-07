/* 
 * Copyright (c) 2011 Whirix <info@whirix.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZAppDelegate.h"
#import "ZZDemoCatalog.h"

@implementation ZZAppDelegate

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	_window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

	ZZDemoCatalog* demoCatalog = [[ZZDemoCatalog alloc] init];	
	UINavigationController* nc = [[UINavigationController alloc] initWithRootViewController:demoCatalog];
	
	_window.rootViewController = nc;
    [_window makeKeyAndVisible];
    
    return YES;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

@end
