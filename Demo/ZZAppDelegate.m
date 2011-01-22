//
//  AppDelegate_iPhone.m
//  ZZ
//
//  Created by Слава Иутин on 1/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ZZAppDelegate.h"
#import "ZZDemoMainViewController.h"

@implementation ZZAppDelegate

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	_window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

	ZZDemoMainViewController* viewController = [[ZZDemoMainViewController alloc] init];	
	UINavigationController* nc = [[UINavigationController alloc] initWithRootViewController:viewController];
	[viewController release];
	
	[_window addSubview:nc.view];    
    [_window makeKeyAndVisible];
    
    return YES;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
    [_window release];
    [super dealloc];
}

@end
