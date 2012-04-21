//
//  JBSplitViewController.h
//  SplitView
//
//  Created by Justin Beck on 4/20/12.
//  Copyright (c) 2012 Intalgent. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JBTableViewController.h"

@interface JBSplitViewController : UISplitViewController
{
    JBTableViewController *_tableViewController;
    UINavigationController *_tableNavigationController;
    
    UIViewController *_viewController;
    UINavigationController *_detailNavigationController;
}

@property (nonatomic, strong) JBTableViewController *tableViewController;
@property (nonatomic, strong) UINavigationController *tableNavigationController;

@property (nonatomic, strong) UIViewController *viewController;
@property (nonatomic, strong) UINavigationController *detailNavigationController;

- (void)replaceDetailViewControllerWithDetailViewController:(UIViewController *)viewController;
- (void)slideViewOut:(id)sender;

@end
