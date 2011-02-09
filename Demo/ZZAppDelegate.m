//
//  AppDelegate_iPhone.m
//  ZZ
//
//  Created by Слава Иутин on 1/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ZZAppDelegate.h"
#import "ZZDemoCatalog.h"

@implementation ZZAppDelegate

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	_window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

	ZZDemoCatalog* demoCatalog = [[ZZDemoCatalog alloc] init];	
	UINavigationController* nc = [[UINavigationController alloc] initWithRootViewController:demoCatalog];
	[demoCatalog release];
	
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
