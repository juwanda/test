//
//  AppDelegate.m
//  Copyright 2012 alva@metric-design.com. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "MainViewController.h"
#import "TestViewController.h"
#import "BWQuincyManager.h"

@implementation AppDelegate

static NSString *appId = @"d8eeae3d4f5159917aa8d1d69f20ff19";

@synthesize window = _window;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[BWHockeyManager sharedHockeyManager] setAlwaysShowUpdateReminder:YES];
#if defined (CONFIGURATION_Release)
    [[BWHockeyManager sharedHockeyManager] setAppIdentifier:appId];
    [[BWHockeyManager sharedHockeyManager] setDelegate:self];
#endif
    
#if defined (CONFIGURATION_Release)
    [[BWQuincyManager sharedQuincyManager] setAppIdentifier:appId];
#endif
    
    [UIApplication sharedApplication].statusBarHidden = FALSE;
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    //TestViewController *v = [[TestViewController alloc] init];
    LoginViewController *v = [[LoginViewController alloc] init];
    //MainViewController *v = [[MainViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:v];
    nav.navigationBarHidden = TRUE;
    [v release];
    [self.window setRootViewController:nav];
    [nav release];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (NSString *)customDeviceIdentifier {
#if defined (CONFIGURATION_Release)
    if ([[UIDevice currentDevice] respondsToSelector:@selector(uniqueIdentifier)])
        return [[UIDevice currentDevice] performSelector:@selector(uniqueIdentifier)];
#endif
    
    return nil;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
