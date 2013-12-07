//
//  About_SubcribeViewController.h
//  Samenrico
//
//  Created by Dhaval on 03/12/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface About_SubcribeViewController : UIViewController
{
        AppDelegate *appDelegate;
}
- (IBAction)btn_BackClick:(id)sender;
@property (retain, nonatomic) IBOutlet UIView *header_view;
@property (retain, nonatomic) IBOutlet UIView *about_view;

@end
