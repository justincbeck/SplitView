//
//  JBTableViewController.h
//  SplitView
//
//  Created by Justin Beck on 4/20/12.
//  Copyright (c) 2012 Intalgent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JBDetailViewController.h"

@interface JBTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    JBDetailViewController *_detailViewController;
}

@property (nonatomic, strong) JBDetailViewController *detailViewController;

@end
