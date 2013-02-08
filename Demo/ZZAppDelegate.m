/* 
 * Copyright (c) 2011 Whirix <info@whirix.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZAppDelegate.h"
#import "ZZDemoCatalog.h"
#import "ZZURLHelper.h"
#import "ZZDebug.h"

@implementation ZZAppDelegate

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	_window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

	ZZDemoCatalog* demoCatalog = [[ZZDemoCatalog alloc] init];	
	UINavigationController* nc = [[UINavigationController alloc] initWithRootViewController:demoCatalog];
	
	_window.rootViewController = nc;
    [_window makeKeyAndVisible];
    
    [self test];
    
    return YES;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)test
{
    NSDictionary* params = [NSDictionary dictionaryWithObject:@"12312123" forKey:@"api_key"];
    [ZZURLHelper startWithBaseURL:@"http://some.url/api/v1/" persistentParams:nil];
    
    NSDictionary* p = [NSDictionary dictionaryWithObject:@"1" forKey:@"a"];
    
    ZZLOG(@"url for test: %@", [ZZURLHelper urlForMethod:@"test" params:nil]);
}

@end
