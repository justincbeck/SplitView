//
//  JBViewController.m
//  SplitView
//
//  Created by Justin Beck on 4/20/12.
//  Copyright (c) 2012 Intalgent. All rights reserved.
//

#import "JBViewController.h"

#import <QuartzCore/QuartzCore.h>

@interface JBViewController ()

@end

@implementation JBViewController

@synthesize tableViewCoordinateLabel = _tableViewCoordinateLabel;
@synthesize label = _label;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIView *view = [[UIView alloc] initWithFrame:self.navigationController.view.frame];
        view.backgroundColor = [UIColor whiteColor];
        _label = [[UILabel alloc] initWithFrame:CGRectMake(100.0f, 100.0f, 200.0f, 40.0f)];
        _label.backgroundColor = [UIColor whiteColor];
        [view addSubview:_label];
        
        self.view = view;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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

@end
