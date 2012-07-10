//
//  LoginViewController.m
//  Copyright 2012 alva@metric-design.com. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"


@implementation LoginViewController

- (IBAction)onSkipTouch:(id)sender {
    [self showMain];
}

- (void)showMain {
    MainViewController *v = [[MainViewController alloc] init];
    [self.navigationController pushViewController:v animated:TRUE];
    [v release];
}

@end
