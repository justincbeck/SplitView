//
//  JBTableViewController.m
//  SplitView
//
//  Created by Justin Beck on 4/20/12.
//  Copyright (c) 2012 Intalgent. All rights reserved.
//

#import "JBSplitViewController.h"
#import "JBTableViewController.h"
#import "JBViewController.h"

#import <QuartzCore/QuartzCore.h>

@interface JBTableViewController ()

@end

@implementation JBTableViewController

@synthesize tableView = _tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    _tableView = [[UITableView alloc] initWithFrame:self.navigationController.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.view = _tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"Green";
    }
    else {
        cell.textLabel.text = @"Blue";
    }
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIInterfaceOrientation orientation = self.interfaceOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation))
    {
        [UIView animateWithDuration:0.4f animations:^{
            self.navigationController.view.frame = CGRectMake(CGRectGetWidth(self.navigationController.view.frame) * -1, 0.0f, CGRectGetWidth(self.navigationController.view.frame), CGRectGetHeight(self.navigationController.view.frame));
        } completion:^(BOOL finished) {
            self.navigationController.view.clipsToBounds = YES;
            self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
            self.navigationController.navigationBar.layer.shadowRadius = 0.0f;
            self.navigationController.navigationBar.layer.shadowOpacity = 0.0f;
            
            self.navigationController.view.clipsToBounds = YES;
            self.navigationController.view.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
            self.navigationController.view.layer.shadowRadius = 0.0f;
            self.navigationController.view.layer.shadowOpacity = 0.0f;
            
            NSUInteger row = indexPath.row;
            
            JBViewController *detailViewController = nil;
            
            if (row == 0) {
                detailViewController = [[JBViewController alloc] initWithNibName:@"FirstDetailView" bundle:nil];
                detailViewController.view.backgroundColor = [UIColor greenColor];
            }
            
            if (row == 1) {
                detailViewController = [[JBViewController alloc] initWithNibName:@"SecondDetailView" bundle:nil];
                detailViewController.view.backgroundColor = [UIColor blueColor];
            }
            
            UIBarButtonItem *slideButton = [[UIBarButtonItem alloc] 
                                            initWithTitle:@"Slide"                                            
                                            style:UIBarButtonItemStyleBordered 
                                            target:self.splitViewController 
                                            action:@selector(slideViewIn:)];
            
            detailViewController.navigationItem.rightBarButtonItem = slideButton;
            
            [((JBSplitViewController *)self.splitViewController) replaceDetailViewControllerWithDetailViewController:detailViewController];
        }];
    }
    else
    {
        NSUInteger row = indexPath.row;
        
        JBViewController *detailViewController = nil;
        
        if (row == 0) {
            detailViewController = [[JBViewController alloc] initWithNibName:@"FirstDetailView" bundle:nil];
            detailViewController.view.backgroundColor = [UIColor greenColor];
        }
        
        if (row == 1) {
            detailViewController = [[JBViewController alloc] initWithNibName:@"SecondDetailView" bundle:nil];
            detailViewController.view.backgroundColor = [UIColor blueColor];
        }
        
        [((JBSplitViewController *)self.splitViewController) replaceDetailViewControllerWithDetailViewController:detailViewController];
    }
}

@end
