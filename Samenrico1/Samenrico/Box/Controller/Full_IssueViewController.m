//
//  Full_IssueViewController.m
//  Samenrico
//
//  Created by Dhaval on 04/12/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import "Full_IssueViewController.h"
#import "About_SubcribeViewController.h"

@interface Full_IssueViewController ()

@end

@implementation Full_IssueViewController

@synthesize arrArticale;

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
    fileManager = [NSFileManager defaultManager];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    [self setframe];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(about_scrb:)];
    tapGesture.delegate = (id <UIGestureRecognizerDelegate>)self;
    [self.about_scrb addGestureRecognizer:tapGesture];
    
    NSLog(@"%@",self.arrArticale);
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)about_scrb:(UITapGestureRecognizer *)tapGesture
{
    NSLog(@"enter the subscribe");
    About_SubcribeViewController *About = [[About_SubcribeViewController alloc] initWithNibName:@"About_SubcribeViewController" bundle:nil];
    
    [self.navigationController pushViewController:About animated:YES];
    [About release];
}

-(void)viewWillAppear:(BOOL)animated
{
   
}

-(void)setframe
{
    self.header_view.frame = CGRectMake(self.header_view.frame.origin.x, self.header_view.frame.origin.y - appDelegate.posY, self.header_view.frame.size.width, self.header_view.frame.size.height);
    self.tbl_data.frame = CGRectMake(self.tbl_data.frame.origin.x, self.tbl_data.frame.origin.y - appDelegate.posY, self.tbl_data.frame.size.width, self.tbl_data.frame.size.height + appDelegate.posY);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_about_scrb release];
    [_btn_BackClick release];
    [_header_view release];
    [_tbl_data release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setAbout_scrb:nil];
    [self setBtn_BackClick:nil];
    [self setHeader_view:nil];
    [self setTbl_data:nil];
    [super viewDidUnload];
}
- (IBAction)btn_BackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark tableview delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.arrArticale count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = nil;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    //header view
    UIImageView *sectionName = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    sectionName.image = [UIImage imageNamed:@"section_img320x30.png"];
    //sectionName.backgroundColor = [UIColor colorWithRed:219.0/255.0 green:219.0/255.0 blue:219.0/255.0 alpha:1];
    
    UIImageView *lockImg = [[UIImageView alloc]initWithFrame:CGRectMake(290, 5, 15, 22)];
    lockImg.image = [UIImage imageNamed:@"lock.png"];
    [sectionName addSubview:lockImg];
    
    UILabel *lbl = [[UILabel alloc]init];
    lbl.frame = CGRectMake(10, 5, 300, 20);
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textColor = [UIColor darkGrayColor];
    lbl.shadowOffset = CGSizeMake(0.0, 1.0);
    lbl.text = [NSString stringWithFormat:@"%@",[[self.arrArticale objectAtIndex:indexPath.row]objectForKey:@"ENTRYSECTION"]];
    lbl.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [sectionName addSubview:lbl];
    [cell.contentView addSubview:sectionName];
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(20, 37, 100, 70)];
    img.tag = indexPath.row + 100;
    //img.backgroundColor = [UIColor blueColor];
    img.image = [UIImage imageNamed:@"loading.png"];
    
    NSString *str = [[self.arrArticale objectAtIndex:indexPath.row]objectForKey:@"IMAGE"];
    
    NSArray* foo = [str componentsSeparatedByString:@"_"];
    NSString* cat = [foo objectAtIndex: 0];
    
    if ([str isEqualToString:@""])
    {
        img.image = [UIImage imageNamed:@"no_image.png"];
    }
    else
    {
        /*NSString *url = [NSString stringWithFormat:@"http://www.samenrico.com/publisher/articles/1/2729/20130408/images/%@", str];*/
        
        NSString *url = [NSString stringWithFormat:@"http://www.samenrico.com/webimages/%@/%@", cat ,str];
        
        NSString *filePath = url;
        NSString *dirPath = [self getDirectoryPath:filePath];
        NSString *fName = [filePath lastPathComponent];
        
        filePath = [dirPath stringByAppendingPathComponent:fName];
        
        if ([fileManager fileExistsAtPath:filePath])
        {
            img.image = [UIImage imageWithContentsOfFile:filePath];
        }
        else
        {
            UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            activityIndicator.alpha = 1.0;
            activityIndicator.tag = img.tag + 100;
            activityIndicator.color = [UIColor blackColor];
            activityIndicator.center = CGPointMake(img.frame.size.width / 2, img.frame.size.height / 2);
            activityIndicator.hidesWhenStopped = NO;
            [img addSubview:activityIndicator];
            [activityIndicator startAnimating];
            
            //NSString *str = [[self.arrArticale objectAtIndex:indexPath.row]objectForKey:@"IMAGE"];
            //@"http://www.samenrico.com/publisher/articles/1/2729/20130408/images/money_136537418415.jpg";
            
            //NSString *url = [NSString stringWithFormat:@"http://www.samenrico.com/publisher/articles/1/2729/20130408/images/%@", str];
            
            NSLog(@"url >>>>> %@",url);
            NSURL *webURL = [[NSURL alloc] initWithString:url];
            
            NSArray * urlArray = [[NSMutableArray alloc]init];
            urlArray = [[NSArray alloc] initWithObjects:webURL, [NSString stringWithFormat:@"%d", img.tag], nil];
            
            [self performSelectorInBackground:@selector(loadImageInBackground:) withObject:urlArray];
        }
    }
    
    [cell.contentView addSubview:img];
    
    UILabel *lbl1 = [[UILabel alloc]init];
    lbl1.frame = CGRectMake(130, 37, 185, 20);
    //lbl1.backgroundColor = [UIColor yellowColor];
    lbl1.textColor = [UIColor blackColor];
    lbl1.numberOfLines = 0;
    lbl1.shadowOffset = CGSizeMake(0.0, 1.0);
    lbl1.text = [NSString stringWithFormat:@"%@",[[self.arrArticale objectAtIndex:indexPath.row]objectForKey:@"NEWSTITLE"]];
    lbl1.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    [cell.contentView addSubview:lbl1];
    
    UILabel *dec = [[UILabel alloc]init];
    dec.frame = CGRectMake(130, 60, 185, 50);
    //dec.backgroundColor = [UIColor redColor];
    dec.textColor = [UIColor darkGrayColor];
    dec.numberOfLines = 0;
    dec.shadowOffset = CGSizeMake(0.0, 1.0);
    dec.text = [NSString stringWithFormat:@"%@",[[self.arrArticale objectAtIndex:indexPath.row]objectForKey:@"FEEDTITLE"]];
    dec.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [cell.contentView addSubview:dec];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //nothing here
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115;
}

#pragma mark private

- (void) loadImageInBackground:(NSArray *)urlAndTagReference
{
	NSData *imgData = [NSData dataWithContentsOfURL:[urlAndTagReference objectAtIndex:0]];
    
	UIImage *img    = [[UIImage alloc] initWithData:imgData];
    
    NSArray *arr = [[NSArray alloc] initWithObjects:img, [urlAndTagReference objectAtIndex:1],[urlAndTagReference objectAtIndex:0], nil];
    
	[self performSelectorOnMainThread:@selector(assignImageToImageView:) withObject:arr waitUntilDone:YES];
}

- (void) assignImageToImageView:(NSArray *)imgAndTagReference
{
    if(imgAndTagReference.count != 0)
    {
        UIImageView *img = (UIImageView *)[self.view viewWithTag:[[imgAndTagReference objectAtIndex:1]integerValue]];
        //[btn setBackgroundImage:(UIImage *)[imgAndTagReference objectAtIndex:0] forState:UIControlStateNormal];
        img.image = (UIImage *)[imgAndTagReference objectAtIndex:0];
        
        UIActivityIndicatorView *activity = (UIActivityIndicatorView *)[img viewWithTag:img.tag + 100];
        
        [activity removeFromSuperview];
        
        NSString *filePath = [[imgAndTagReference objectAtIndex:2] absoluteString];
        NSString *dirPath = [self getDirectoryPath:filePath];
        NSString *fName = [filePath lastPathComponent];
        filePath = [dirPath stringByAppendingPathComponent:fName];
        
        [UIImagePNGRepresentation([imgAndTagReference objectAtIndex:0]) writeToFile:filePath atomically:YES];
    }
}

-(NSString *)getDirectoryPath:(NSString *)aUrl
{
    NSURL* url = [NSURL URLWithString:[aUrl stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSArray *arrPath = [[NSArray alloc]init];
    arrPath = [url pathComponents];
    
    NSString *dirPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    BOOL isDir;
    NSError *error;
    
    for(int i = 1; i < [arrPath count] - 1; i++)
    {
        dirPath = [dirPath stringByAppendingPathComponent:[arrPath objectAtIndex:i]];
        
        fileManager = [NSFileManager defaultManager];
        
        if (([fileManager fileExistsAtPath:dirPath isDirectory:&isDir] && isDir) == FALSE)
        {
            [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:NO attributes:nil error:&error];
        }
    }
    
    return dirPath;
}
@end
