//
//  AppDelegate.m
//  SplitView
//
//  Created by Justin Beck on 4/20/12.
//  Copyright (c) 2012 Intalgent. All rights reserved.
//

#import "AppDelegate.h"

#import "JBTableViewController.h"
#import "JBDetailViewController.h"

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    JBTableViewController *tableViewController = [[JBTableViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *tableNavController = [[UINavigationController alloc] initWithRootViewController:tableViewController];
    
    JBDetailViewController *detailViewController = [[JBDetailViewController alloc] initWithNibName:nil bundle:nil];
    
    [tableViewController setDetailViewController:detailViewController];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        UINavigationController *detailNavController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
        
        NSArray *viewControllers = [NSArray arrayWithObjects:tableNavController, detailNavController, nil];

        UISplitViewController *splitViewController = [[UISplitViewController alloc] init];
        splitViewController.delegate = detailViewController;
        splitViewController.viewControllers = viewControllers;
        
        [[self window] setRootViewController:splitViewController];
    }
    else
    {
        [[self window] setRootViewController:tableNavController];
    }
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
