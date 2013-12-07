//
//  Full_IssueViewController.h
//  Samenrico
//
//  Created by Dhaval on 04/12/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface Full_IssueViewController : UIViewController
{
    NSMutableArray *arrArticale;
    NSFileManager *fileManager;
    
    AppDelegate *appDelegate;
}

@property (retain, nonatomic) IBOutlet UIView *header_view;
@property (retain, nonatomic) IBOutlet UITableView *tbl_data;
@property (nonatomic,retain) NSMutableArray *arrArticale;
@property (retain, nonatomic) IBOutlet UIView *about_scrb;
@property (retain, nonatomic) IBOutlet UIButton *btn_BackClick;
- (IBAction)btn_BackClick:(id)sender;
@end
