//
//  JBTableViewController.h
//  SplitView
//
//  Created by Justin Beck on 4/20/12.
//  Copyright (c) 2012 Intalgent. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JBTableView.h"

@interface JBTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISplitViewControllerDelegate>
{
    JBTableView *_tableView;
}

@property (nonatomic, strong) UITableView *tableView;

@end
