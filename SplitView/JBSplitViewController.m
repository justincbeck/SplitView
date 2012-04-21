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
        _viewController.label.text = @"Initial View";
        
        _detailNavigationController = [[UINavigationController alloc] initWithRootViewController:_viewController];
        
        self.viewControllers = [NSArray arrayWithObjects:_tableNavigationController, _detailNavigationController, nil];
        
        self.delegate = _tableViewController;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *slideButton = [[UIBarButtonItem alloc] 
                                   initWithTitle:@"Slide"                                            
                                   style:UIBarButtonItemStyleBordered 
                                   target:self 
                                   action:@selector(slideViewIn:)];
    _viewController.navigationItem.rightBarButtonItem = slideButton;
    
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithTitle:@"Refresh" style:UIBarButtonSystemItemRefresh
                                                                     target:self
                                                                     action:@selector(refresh:)];
    
    [_tableViewController setToolbarItems:[NSArray arrayWithObjects:refreshButton, nil] animated:YES];
    _tableNavigationController.toolbarHidden = NO;
    
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideViewIn:)];
    gestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    [_viewController.view addGestureRecognizer:gestureRecognizer];
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

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self slideViewOut:self];
}

- (void)slideViewOut:(id)sender
{
    [UIView animateWithDuration:0.4f animations:^{
        _tableNavigationController.view.frame = CGRectMake(CGRectGetWidth(_tableNavigationController.view.frame) * -1.0f, 0.0f, CGRectGetWidth(_tableNavigationController.view.frame), CGRectGetHeight(_tableNavigationController.view.frame));
    } completion:^(BOOL finished) {
        _tableNavigationController.view.clipsToBounds = YES;
        _tableNavigationController.navigationBar.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        _tableNavigationController.navigationBar.layer.shadowRadius = 0.0f;
        _tableNavigationController.navigationBar.layer.shadowOpacity = 0.0f;
        
        _tableNavigationController.view.clipsToBounds = YES;
        _tableNavigationController.view.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        _tableNavigationController.view.layer.shadowRadius = 0.0f;
        _tableNavigationController.view.layer.shadowOpacity = 0.0f;
        
        for (UIGestureRecognizer *gr in _viewController.view.gestureRecognizers)
        {
            [_viewController.view removeGestureRecognizer:gr];
        }
        
        UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideViewIn:)];
        gestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
        
        [_viewController.view addGestureRecognizer:gestureRecognizer];
    }];
}

- (void)replaceDetailViewControllerWithDetailViewController:(UIViewController *)viewController
{
    NSArray *viewControllers = [NSArray arrayWithObjects:self.tableNavigationController, [[UINavigationController alloc] initWithRootViewController:viewController], nil];

    UISwipeGestureRecognizer *rightGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideViewIn:)];
    rightGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    [viewController.view addGestureRecognizer:rightGestureRecognizer];
    
    UISwipeGestureRecognizer *leftGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideViewOut:)];
    leftGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [viewController.view addGestureRecognizer:leftGestureRecognizer];
    
    self.viewControllers = viewControllers;
}

- (void)slideViewIn:(id)sender
{
    _tableNavigationController.view.clipsToBounds = NO;
    _tableNavigationController.navigationBar.layer.shadowOffset = CGSizeMake(1.0f, 0.0f);
    _tableNavigationController.navigationBar.layer.shadowRadius = 1.0f;
    _tableNavigationController.navigationBar.layer.shadowOpacity = 0.5;
    _tableNavigationController.navigationBar.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    
    CGRect bounds = _tableNavigationController.navigationBar.layer.bounds;
    bounds.size.height += 5.0f;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds 
                                                   byRoundingCorners:(UIRectCornerTopRight)
                                                         cornerRadii:CGSizeMake(3.0f, 3.0f)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = bounds;
    maskLayer.path = maskPath.CGPath;
    
    [_tableNavigationController.navigationBar.layer addSublayer:maskLayer];
    _tableNavigationController.navigationBar.layer.mask = maskLayer;
    
    _tableNavigationController.view.clipsToBounds = NO;
    _tableNavigationController.view.layer.shadowOffset = CGSizeMake(1.0f, 0.0f);
    _tableNavigationController.view.layer.shadowRadius = 1.0f;
    _tableNavigationController.view.layer.shadowOpacity = 0.5;
    
    [UIView animateWithDuration:0.4f animations:^{
        _tableNavigationController.view.frame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(_tableNavigationController.view.frame), CGRectGetHeight(_tableNavigationController.view.frame));
    } completion:^(BOOL finished) {
        for (UIGestureRecognizer *gr in _viewController.view.gestureRecognizers)
        {
            [_viewController.view removeGestureRecognizer:gr];
        }
        
        UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideViewOut:)];
        gestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        
        [_viewController.view addGestureRecognizer:gestureRecognizer];
    }];
}

- (void)refresh:(id)sender
{
    NSLog(@"Refresh");
}

@end
