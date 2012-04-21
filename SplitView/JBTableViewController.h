//
//  JBTableViewController.h
//  SplitView
//
//  Created by Justin Beck on 4/20/12.
//  Copyright (c) 2012 Intalgent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JBTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
}

@property (nonatomic, strong) UITableView *tableView;

@end
