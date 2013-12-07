//
//  About_SubcribeViewController.m
//  Samenrico
//
//  Created by Dhaval on 03/12/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import "About_SubcribeViewController.h"

@interface About_SubcribeViewController ()

@end

@implementation About_SubcribeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
     [self setframe];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn_BackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

-(void)setframe
{
    self.header_view.frame = CGRectMake(self.header_view.frame.origin.x, self.header_view.frame.origin.y - appDelegate.posY, self.header_view.frame.size.width, self.header_view.frame.size.height);
    self.about_view.frame = CGRectMake(self.about_view.frame.origin.x, self.about_view.frame.origin.y - appDelegate.posY, self.about_view.frame.size.width, self.about_view.frame.size.height + appDelegate.posY);
}

- (void)dealloc {
    [_header_view release];
    [_about_view release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setHeader_view:nil];
    [self setAbout_view:nil];
    [super viewDidUnload];
}
@end
