//
//  JBSplitViewController.m
//  SplitView
//
//  Created by Justin Beck on 4/20/12.
//  Copyright (c) 2012 Intalgent. All rights reserved.
//

#import "JBSplitViewController.h"
#import "JBTableViewController.h"

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
        
        _viewController = [[UIViewController alloc] initWithNibName:nil bundle:nil];
        _viewController.view = [[UIView alloc] initWithFrame:_viewController.navigationController.view.frame];
        _viewController.view.backgroundColor = [UIColor redColor];
        
        _detailNavigationController = [[UINavigationController alloc] initWithRootViewController:_viewController];
        
        self.viewControllers = [NSArray arrayWithObjects:_tableNavigationController, _detailNavigationController, nil];
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
        
        NSLog(@"Add right gesture");
        UISwipeGestureRecognizer *rightGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideViewIn:)];
        rightGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
        [_viewController.view addGestureRecognizer:rightGestureRecognizer];
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
    for (UIGestureRecognizer *sgr in _viewController.view.gestureRecognizers)
    {
        NSLog(@"Removing gesture");
        [_viewController.view removeGestureRecognizer:sgr];
    }

    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation))
    {
        NSLog(@"Adding left gesture");
        UISwipeGestureRecognizer *leftGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideViewOut:)];
        leftGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        [_viewController.view removeGestureRecognizer:leftGestureRecognizer];

        NSLog(@"Adding right gesture");
        UISwipeGestureRecognizer *rightGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideViewIn:)];
        rightGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
        [_viewController.view addGestureRecognizer:rightGestureRecognizer];
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
        
        NSLog(@"Remove left gesture");
        for (UIGestureRecognizer *sgr in _viewController.view.gestureRecognizers)
        {
            [_viewController.view removeGestureRecognizer:sgr];
        }
        
        NSLog(@"Add right gesture");
        UISwipeGestureRecognizer *rightGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideViewIn:)];
        rightGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
        [_viewController.view addGestureRecognizer:rightGestureRecognizer];
    }];
}

- (void)replaceDetailViewControllerWithDetailViewController:(UIViewController *)viewController
{
    _viewController = (UIViewController *)viewController;
    
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation))
    {
        UIBarButtonItem *slideButton = [[UIBarButtonItem alloc] 
                                        initWithTitle:@"Slide"                                            
                                        style:UIBarButtonItemStyleBordered 
                                        target:self.splitViewController 
                                        action:@selector(slideViewIn:)];
        
        _viewController.navigationItem.rightBarButtonItem = slideButton;
        
        NSLog(@"Add right gesture");
        UISwipeGestureRecognizer *rightGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideViewIn:)];
        rightGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
        [viewController.view addGestureRecognizer:rightGestureRecognizer];
    }
    
    NSArray *viewControllers = [NSArray arrayWithObjects:self.tableNavigationController, [[UINavigationController alloc] initWithRootViewController:viewController], nil];

    self.viewControllers = viewControllers;
}

- (void)slideViewIn:(id)sender
{
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
    
    _tableNavigationController.view.clipsToBounds = NO;
    _tableNavigationController.view.layer.shadowOffset = CGSizeMake(1.0f, 0.0f);
    _tableNavigationController.view.layer.shadowRadius = 1.0f;
    _tableNavigationController.view.layer.shadowOpacity = 0.5;
    _tableNavigationController.view.layer.shadowPath = tableViewShadowPath.CGPath;
    
    [UIView animateWithDuration:0.2f animations:^{
        _tableNavigationController.view.frame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(_tableNavigationController.view.frame), CGRectGetHeight(_tableNavigationController.view.frame));
    } completion:^(BOOL finished) {
        NSLog(@"Remove right gesture");
        for (UISwipeGestureRecognizer *sgr in _viewController.view.gestureRecognizers)
        {
            [_viewController.view removeGestureRecognizer:sgr];
        }

        NSLog(@"Add left gesture");
        UISwipeGestureRecognizer *leftGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideViewOut:)];
        leftGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        [_viewController.view addGestureRecognizer:leftGestureRecognizer];
    }];
}

- (void)refresh:(id)sender
{
    NSLog(@"Refresh");
}

@end
