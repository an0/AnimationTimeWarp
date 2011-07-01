//
//  AnimationTimeWarpAppDelegate.m
//  AnimationTimeWarp
//
//  Created by Ling Wang on 6/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AnimationTimeWarpAppDelegate.h"

#import "AnimationTimeWarpViewController.h"

@implementation AnimationTimeWarpAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.viewController = [[AnimationTimeWarpViewController alloc] initWithNibName:@"AnimationTimeWarpViewController" bundle:nil]; 
	self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
