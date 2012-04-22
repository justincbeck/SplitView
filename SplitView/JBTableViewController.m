//
//  JBTableViewController.m
//  SplitView
//
//  Created by Justin Beck on 4/20/12.
//  Copyright (c) 2012 Intalgent. All rights reserved.
//

#import "JBTableViewController.h"
#import "JBDetailViewController.h"

#import <QuartzCore/QuartzCore.h>

@interface JBTableViewController ()

- (void)refresh:(id)sender;

@end

@implementation JBTableViewController

@synthesize detailViewController = _detailViewController;

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
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.navigationController.view.frame style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.view = tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithTitle:@"Refresh" style:UIBarButtonSystemItemRefresh
                                                                     target:self
                                                                     action:@selector(refresh:)];
    
    [self setToolbarItems:[NSArray arrayWithObjects:refreshButton, nil] animated:YES];
    self.navigationController.toolbarHidden = NO;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        return YES;
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
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
    
    UITableViewCell *cell = [(UITableView *)self.view dequeueReusableCellWithIdentifier:CellIdentifier];
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

    if (row == 0)
        _detailViewController.view.backgroundColor = [UIColor greenColor];
    
    else if (row == 1)
        _detailViewController.view.backgroundColor = [UIColor blueColor];
    
    if (!self.splitViewController)
        [[self navigationController] pushViewController:_detailViewController animated:YES];
}


- (void)refresh:(id)sender
{
    [(UITableView *)self.view reloadData];
}

@end
