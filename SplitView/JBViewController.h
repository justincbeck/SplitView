//
//  JBViewController.h
//  SplitView
//
//  Created by Justin Beck on 4/20/12.
//  Copyright (c) 2012 Intalgent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JBViewController : UIViewController
{
    UILabel *_tableViewCoordinateLabel;
    UILabel *_label;
}

@property (nonatomic, strong) UILabel *tableViewCoordinateLabel;
@property (nonatomic, strong) UILabel *label;

@end
