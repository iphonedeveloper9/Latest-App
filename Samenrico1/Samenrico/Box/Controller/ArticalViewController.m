//
//  AricalViewController.m
//  Samenrico
//
//  Created by B's Mac on 06/12/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import "ArticalViewController.h"

@interface ArticalViewController ()

@end

@implementation ArticalViewController
@synthesize mainScroll, arrArticles;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithAricleArray:(NSArray*)array
{
    arrArticles = array;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"%@", arrArticles);
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
        mainScroll.frame = CGRectMake(0, 63 - appDelegate.posY, 320, [[UIScreen mainScreen] bounds].size.height - 63 );
    
    strCachesDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    fileManager = [NSFileManager defaultManager];
    
    for (int i = 0; i < arrArticles.count; i++)
    {
        UIScrollView *anArtical = [[UIScrollView alloc]init];
        anArtical.frame = CGRectMake(i * mainScroll.frame.size.width, 0, mainScroll.frame.size.width,mainScroll.frame.size.height);
        anArtical.backgroundColor = [UIColor clearColor];
        [mainScroll addSubview:anArtical];
        
        
        UILabel *lblArtSection = [[UILabel alloc]init];
        lblArtSection.backgroundColor = [UIColor clearColor];
        lblArtSection.textColor = [UIColor redColor];
        lblArtSection.font = [UIFont boldSystemFontOfSize:14];
        
        if ([[arrArticles objectAtIndex:i]objectForKey:@"ENTRYSECTION"] != [NSNull null]) {
            lblArtSection.text = [[arrArticles objectAtIndex:i]objectForKey:@"ENTRYSECTION"];
        }
        
        lblArtSection.frame = CGRectMake(5, 5, anArtical.frame.size.width - 10,[self labelHeightForText:lblArtSection.text andFont:lblArtSection.font]);
        [anArtical addSubview:lblArtSection];
        
        
        UILabel *lblArtTitle = [[UILabel alloc]init];
        lblArtTitle.backgroundColor = [UIColor clearColor];
        lblArtTitle.textColor = [UIColor blackColor];
        lblArtTitle.font = [UIFont boldSystemFontOfSize:26];
        lblArtTitle.numberOfLines = 0;
        
        if ([[arrArticles objectAtIndex:i]objectForKey:@"NEWSTITLE"] != [NSNull null]) {
            lblArtTitle.text = [[arrArticles objectAtIndex:i]objectForKey:@"NEWSTITLE"];
        }
        
        lblArtTitle.frame = CGRectMake(5, lblArtSection.frame.origin.y + lblArtSection.frame.size.height + 5, anArtical.frame.size.width - 10, [self labelHeightForText:lblArtTitle.text andFont:lblArtTitle.font]);
        [anArtical addSubview:lblArtTitle];
        
        
        UILabel *lblArtFeed = [[UILabel alloc]init];
        lblArtFeed.backgroundColor = [UIColor clearColor];
        lblArtFeed.textColor = [UIColor blackColor];
        lblArtFeed.font = [UIFont boldSystemFontOfSize:16];
        lblArtFeed.numberOfLines = 0;
        
        if ([[arrArticles objectAtIndex:i]objectForKey:@"FEEDTITLE"] != [NSNull null]) {
            lblArtFeed.text = [[arrArticles objectAtIndex:i]objectForKey:@"FEEDTITLE"];
        }
        [lblArtFeed setFrame:CGRectMake(5, lblArtTitle.frame.origin.y + lblArtTitle.frame.size.height +5, anArtical.frame.size.width - 10, [self labelHeightForText:lblArtFeed.text andFont:lblArtFeed.font])];
        [anArtical addSubview:lblArtFeed];
        
        NSLog(@"%@", NSStringFromCGRect(anArtical.frame));
        NSLog(@"%@", NSStringFromCGRect(mainScroll.frame));
        NSLog(@"%@", NSStringFromCGRect([UIScreen mainScreen].bounds));
        
        
        UIImageView *imgArticalPic = [[UIImageView alloc ]initWithFrame:CGRectMake(5, lblArtFeed.frame.origin.y + lblArtFeed.frame.size.height + 5, anArtical.frame.size.width - 10, 280)];
        imgArticalPic.backgroundColor = [UIColor clearColor];
        imgArticalPic.tag = 100 + i;
        [anArtical addSubview:imgArticalPic];
        
        
        
        UILabel *lblArtDetail = [[UILabel alloc]initWithFrame:CGRectMake(5, imgArticalPic.frame.origin.y + imgArticalPic.frame.size.height + 5, anArtical.frame.size.width - 10, 60)];
        lblArtDetail.backgroundColor = [UIColor clearColor];
        lblArtDetail.textColor = [UIColor colorWithRed:41.0f/255 green:1.0f/255 blue:1.0f/255 alpha:1];
        lblArtDetail.font = [UIFont systemFontOfSize:16];
        lblArtDetail.numberOfLines = 0;
        
        if ([[arrArticles objectAtIndex:i]objectForKey:@"NEWSDESCRIPTION"] != [NSNull null]) {
            lblArtDetail.text = [[arrArticles objectAtIndex:i]objectForKey:@"NEWSDESCRIPTION"];
        }
        
        [anArtical addSubview:lblArtDetail];
        
        CGRect newFrame = lblArtDetail.frame;
        newFrame.size.height = [self labelHeightForText:lblArtDetail.text andFont:lblArtDetail.font];
        lblArtDetail.frame = newFrame;
        
        [anArtical setContentSize:CGSizeMake(anArtical.frame.size.width, lblArtDetail.frame.size.height + lblArtDetail.frame.origin.y)];
        
        NSString *imgPath = [NSString stringWithFormat:@"http://www.samenrico.com/webimages/home/%@", [[arrArticles objectAtIndex:i]objectForKey:@"IMAGE"]];
        
        NSString *filePath = imgPath;
        NSString *dirPath = [self getDirectoryPath:filePath];
        NSString *fName = [filePath lastPathComponent];
        
        filePath = [dirPath stringByAppendingPathComponent:fName];
        
        if ([fileManager fileExistsAtPath:filePath]) {
            [imgArticalPic setImage:[UIImage imageWithContentsOfFile:filePath]];
        }
        else
        {
            UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            activityIndicator.alpha = 1.0;
            activityIndicator.tag = imgArticalPic.tag + 100;
            activityIndicator.center = CGPointMake(imgArticalPic.frame.size.width / 2, imgArticalPic.frame.size.height / 2);
            activityIndicator.hidesWhenStopped = NO;
            [imgArticalPic addSubview:activityIndicator];
            [activityIndicator startAnimating];
            NSURL *webURL = [[NSURL alloc] initWithString:imgPath];
            
            NSLog(@"%@", webURL);
            
            
            NSArray * urlArray = [[NSMutableArray alloc]init];
            urlArray = [[NSArray alloc] initWithObjects:webURL, [NSString stringWithFormat:@"%d", imgArticalPic.tag], nil];
            
            [self performSelectorInBackground:@selector(loadImageInBackground:) withObject:urlArray];
        }

    }
    
    mainScroll.contentSize = CGSizeMake(mainScroll.frame.size.width *arrArticles.count, mainScroll.frame.size.height);
    mainScroll.pagingEnabled = YES;
    // Do any additional setup after loading the view from its nib.
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
        [img setImage:(UIImage *)[imgAndTagReference objectAtIndex:0]];
        
        UIActivityIndicatorView *activity = (UIActivityIndicatorView *)[img viewWithTag:img.tag + 100];
        
        
        [activity removeFromSuperview];
        
        NSString *filePath = [[imgAndTagReference objectAtIndex:2] absoluteString];
        NSString *dirPath = [self getDirectoryPath:filePath];
        NSString *fName = [filePath lastPathComponent];
        filePath = [dirPath stringByAppendingPathComponent:fName];
        
        [UIImagePNGRepresentation([imgAndTagReference objectAtIndex:0]) writeToFile:filePath atomically:YES];
    }
}

-(float)labelHeightForText:(NSString *)text andFont:(UIFont *)font
{
    CGSize maximumLabelSize = CGSizeMake(300,9999);
    
    CGSize expectedLabelSize = [text
                                sizeWithFont:font constrainedToSize:maximumLabelSize
                                lineBreakMode:NSLineBreakByWordWrapping];
    return expectedLabelSize.height;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [mainScroll release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMainScroll:nil];
    [super viewDidUnload];
}
- (IBAction)btnBack_Click:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
