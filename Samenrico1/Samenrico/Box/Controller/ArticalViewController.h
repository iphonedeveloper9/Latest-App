//
//  AricalViewController.h
//  Samenrico
//
//  Created by B's Mac on 06/12/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "requriedFunction.h"


@interface ArticalViewController : UIViewController
{
    AppDelegate *appDelegate;
    NSString * strCachesDirectoryPath;
    NSFileManager *fileManager;
}
-(id)initWithAricleArray:(NSArray*)array;
@property (retain, nonatomic) IBOutlet UIScrollView *mainScroll;
@property (nonatomic, retain)NSArray *arrArticles;
- (IBAction)btnBack_Click:(id)sender;
@end
