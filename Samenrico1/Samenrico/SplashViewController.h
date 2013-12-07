//
//  ViewController.h
//  Samenrico
//
//  Created by Muhammad Shahzad on 3/29/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "AppDelegate.h"

@interface SplashViewController : UIViewController
{
    AppDelegate*appDelegate;
}
@property (retain, nonatomic) IBOutlet UIImageView *imgLogo;

@end
