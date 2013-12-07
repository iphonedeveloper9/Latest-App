//
//  ViewController.m
//  Samenrico
//
//  Created by Muhammad Shahzad on 3/29/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import "SplashViewController.h"

#import "HomeViewController.h"


@interface SplashViewController ()
@end

@implementation SplashViewController

- (void)viewDidLoad {
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
   // [self performSelector:@selector(nextView) withObject:nil afterDelay:0.0];

    [self performSelector:@selector(animationView) withObject:nil afterDelay:2.5];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc {
    [_imgLogo release];
    [super dealloc];
}
-(void)animationView{
    
    self.imgLogo.frame=CGRectMake(97, 0, 0, 0);
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:3.0];

    self.imgLogo.image=[UIImage imageNamed:@"tramp.png"];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568)
        
        self.imgLogo.frame=CGRectMake(25, 234 - appDelegate.posY, 270, 100);
    
    else
        
        self.imgLogo.frame=CGRectMake(25, 190 - appDelegate.posY, 270, 100);

    [UIView commitAnimations];
    [self performSelector:@selector(nextView) withObject:nil afterDelay:5.5];
}

-(void)nextView
{
    HomeViewController *home;
    home = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    [self.navigationController pushViewController:home animated:YES];
    [home release];
}


@end
