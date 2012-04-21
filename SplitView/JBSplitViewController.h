//
//  JBSplitViewController.h
//  SplitView
//
//  Created by Justin Beck on 4/20/12.
//  Copyright (c) 2012 Intalgent. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JBTableViewController.h"
#import "JBViewController.h"

@interface JBSplitViewController : UISplitViewController
{
    JBTableViewController *_tableViewController;
    UINavigationController *_tableNavigationController;
    
    JBViewController *_viewController;
    UINavigationController *_detailNavigationController;
    
    UISwipeGestureRecognizer *_rightGestureRecognizer;
    UISwipeGestureRecognizer *_leftGestureRecognizer;
}

@property (nonatomic, strong) JBTableViewController *tableViewController;
@property (nonatomic, strong) UINavigationController *tableNavigationController;

@property (nonatomic, strong) JBViewController *viewController;
@property (nonatomic, strong) UINavigationController *detailNavigationController;

- (void)replaceDetailViewControllerWithDetailViewController:(UIViewController *)viewController;

@end
