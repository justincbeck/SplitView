//
//  JBSplitViewController.m
//  SplitView
//
//  Created by Justin Beck on 4/20/12.
//  Copyright (c) 2012 Intalgent. All rights reserved.
//

#import "JBSplitViewController.h"
#import "JBTableViewController.h"
#import "JBViewController.h"

#import <QuartzCore/QuartzCore.h>

@interface JBSplitViewController ()

@end

@implementation JBSplitViewController

@synthesize tableViewController = _tableViewController;
@synthesize tableNavigationController = _tableNavigationController;

@synthesize viewController = _viewController;
@synthesize detailNavigationController = _detailNavigationController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _tableViewController = [[JBTableViewController alloc] initWithNibName:nil bundle:nil];
        _tableNavigationController = [[UINavigationController alloc] initWithRootViewController:_tableViewController];
        
        _viewController = [[JBViewController alloc] initWithNibName:nil bundle:nil];
        _viewController.view.backgroundColor = [UIColor redColor];
        
        _rightGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideViewIn:)];
        _rightGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
        
        _leftGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideViewOut:)];
        _leftGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        
        _detailNavigationController = [[UINavigationController alloc] initWithRootViewController:_viewController];
        
        self.viewControllers = [NSArray arrayWithObjects:_tableNavigationController, _detailNavigationController, nil];
        
        self.delegate = _tableViewController;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation))
    {
        UIBarButtonItem *slideButton = [[UIBarButtonItem alloc] 
                                       initWithTitle:@"Slide"                                            
                                       style:UIBarButtonItemStyleBordered 
                                       target:self 
                                       action:@selector(slideViewIn:)];
        _viewController.navigationItem.rightBarButtonItem = slideButton;
        
        [_viewController.view addGestureRecognizer:_rightGestureRecognizer];
    }
    
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithTitle:@"Refresh" style:UIBarButtonSystemItemRefresh
                                                                     target:self
                                                                     action:@selector(refresh:)];
    
    [_tableViewController setToolbarItems:[NSArray arrayWithObjects:refreshButton, nil] animated:YES];
    _tableNavigationController.toolbarHidden = NO;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation))
    {
        [_viewController.view removeGestureRecognizer:_leftGestureRecognizer];
        [_viewController.view addGestureRecognizer:_rightGestureRecognizer];
    }
    
    [self slideViewOut:self];
}

- (void)slideViewOut:(id)sender
{
    [UIView animateWithDuration:0.2f animations:^{
        _tableNavigationController.view.frame = CGRectMake(CGRectGetWidth(_tableNavigationController.view.frame) * -1, 0.0f, CGRectGetWidth(_tableNavigationController.view.frame), CGRectGetHeight(_tableNavigationController.view.frame));
    } completion:^(BOOL finished) {
        _tableNavigationController.view.clipsToBounds = YES;
        _tableNavigationController.navigationBar.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        _tableNavigationController.navigationBar.layer.shadowRadius = 0.0f;
        _tableNavigationController.navigationBar.layer.shadowOpacity = 0.0f;
        
        _tableNavigationController.view.clipsToBounds = YES;
        _tableNavigationController.view.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        _tableNavigationController.view.layer.shadowRadius = 0.0f;
        _tableNavigationController.view.layer.shadowOpacity = 0.0f;
        
        [_viewController.view removeGestureRecognizer:_leftGestureRecognizer];
        [_viewController.view addGestureRecognizer:_rightGestureRecognizer];
    }];
}

- (void)replaceDetailViewControllerWithDetailViewController:(UIViewController *)viewController
{
    NSArray *viewControllers = [NSArray arrayWithObjects:self.tableNavigationController, [[UINavigationController alloc] initWithRootViewController:viewController], nil];

    self.viewControllers = viewControllers;
}

- (void)slideViewIn:(id)sender
{
    _tableNavigationController.view.clipsToBounds = NO;

    CGRect bounds = _tableNavigationController.navigationBar.layer.bounds;
    UIBezierPath *navigationBarShadowPath = [UIBezierPath bezierPathWithRect:bounds];

    _tableNavigationController.navigationBar.clipsToBounds = NO;
    _tableNavigationController.navigationBar.layer.shadowOffset = CGSizeMake(1.0f, 0.0f);
    _tableNavigationController.navigationBar.layer.shadowRadius = 1.0f;
    _tableNavigationController.navigationBar.layer.shadowOpacity = 0.5;
    _tableNavigationController.navigationBar.layer.shadowPath = navigationBarShadowPath.CGPath;
    _tableNavigationController.navigationBar.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    
    bounds.size.height += 5.0f;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds 
                                                   byRoundingCorners:(UIRectCornerTopRight)
                                                         cornerRadii:CGSizeMake(3.0f, 3.0f)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = bounds;
    maskLayer.path = maskPath.CGPath;
    
    [_tableNavigationController.navigationBar.layer addSublayer:maskLayer];
    _tableNavigationController.navigationBar.layer.mask = maskLayer;
    
    UIBezierPath *tableViewShadowPath = [UIBezierPath bezierPathWithRect:_tableNavigationController.view.layer.bounds];
    
    _tableNavigationController.view.layer.shadowOffset = CGSizeMake(1.0f, 0.0f);
    _tableNavigationController.view.layer.shadowRadius = 1.0f;
    _tableNavigationController.view.layer.shadowOpacity = 0.5;
    _tableNavigationController.view.layer.shadowPath = tableViewShadowPath.CGPath;
    
    [UIView animateWithDuration:0.2f animations:^{
        _tableNavigationController.view.frame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(_tableNavigationController.view.frame), CGRectGetHeight(_tableNavigationController.view.frame));
    } completion:^(BOOL finished) {
        [_viewController.view removeGestureRecognizer:_rightGestureRecognizer];
        [_viewController.view addGestureRecognizer:_leftGestureRecognizer];
    }];
}

- (void)refresh:(id)sender
{
    NSLog(@"Refresh");
}

@end
