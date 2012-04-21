//
//  JBTableViewController.m
//  SplitView
//
//  Created by Justin Beck on 4/20/12.
//  Copyright (c) 2012 Intalgent. All rights reserved.
//

#import "JBSplitViewController.h"
#import "JBTableViewController.h"

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
    
    if (indexPath.row == 0)
        cell.textLabel.text = @"Green";

    else
        cell.textLabel.text = @"Blue";
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = indexPath.row;
    UIViewController *detailViewController = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    detailViewController.view = [[UIView alloc] initWithFrame:detailViewController.navigationController.view.frame];
    
    if (row == 0)
        detailViewController.view.backgroundColor = [UIColor greenColor];
    
    else if (row == 1)
        detailViewController.view.backgroundColor = [UIColor blueColor];
    
    [((JBSplitViewController *)self.splitViewController) slideViewOut:self];
    [((JBSplitViewController *)self.splitViewController) replaceDetailViewControllerWithDetailViewController:detailViewController];
}

@end
