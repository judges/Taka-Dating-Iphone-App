//
//  AboutMeViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 28/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "AboutMeViewController.h"
#import "SingletonClass.h"

@interface AboutMeViewController ()

@end

@implementation AboutMeViewController

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
    [super viewDidLoad];
    
    windowSize=[UIScreen mainScreen].bounds.size;
    //self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    
    self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)148/255 blue:(CGFloat)214/255 alpha:1.0];
    self.headerView=[[UIView alloc]init];
    self.headerView.frame=CGRectMake(0, 0, self.view.frame.size.width, 55);
    
    [self.view addSubview:self.headerView];
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, windowSize.width, 55);
    //UIColor *firstColor = [UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
  //  UIColor *secColor = [UIColor colorWithRed:(CGFloat)121/255 green:(CGFloat)2/255 blue:(CGFloat)0/255 alpha:1.0];
    UIColor *firstColor = [UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)88/255 blue:(CGFloat)211/255 alpha:1.0];
    UIColor *secColor = [UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)0/255 blue:(CGFloat)155/255 alpha:1.0];
    layer.colors = [NSArray arrayWithObjects:(id)[firstColor CGColor],(id)[secColor CGColor], nil];
    [self.headerView.layer insertSublayer:layer atIndex:0];
    self.headerView.layer.shadowRadius = 5.0;
    self.headerView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.headerView.layer.shadowOpacity = 0.6;
    self.headerView.layer.shadowOffset = CGSizeMake(0.0f,5.0f);
    self.headerView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.headerView.bounds].CGPath;
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(windowSize.width/2-60, 20, windowSize.width-200, 35)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.text = @"About me";
    [self.headerView addSubview:self.titleLabel];
    //Add Cancel BUTTON
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.frame = CGRectMake(windowSize.width/2-145, 25, 60, 25);
    [self.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    self.cancelButton.layer.borderColor = [UIColor redColor].CGColor;
    self.cancelButton.layer.borderWidth = 0.7;
    self.cancelButton.layer.cornerRadius = 4;
    self.cancelButton.clipsToBounds = YES;
    [self.cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:self.cancelButton];
    
    self.saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saveButton.frame = CGRectMake(windowSize.width-70, 25, 60, 25);
    [self.saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.saveButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.saveButton setTitle:@"Save" forState:UIControlStateNormal];
    self.saveButton.layer.borderColor = [UIColor redColor].CGColor;
    self.saveButton.layer.borderWidth = 0.7;
    self.saveButton.layer.cornerRadius = 4;
    self.saveButton.clipsToBounds = YES;
    [self.saveButton addTarget:self action:@selector(saveButtonAboutMeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:self.saveButton];
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        self.headerView.frame=CGRectMake(0, 0, windowSize.width, 75);
        layer.frame =self.headerView.bounds;
        self.titleLabel.frame=CGRectMake(windowSize.width/2-270, 25, windowSize.width-200, 35);
        self.cancelButton.frame = CGRectMake(windowSize.width/2-350, 25, 120, 40);
        self.saveButton.frame = CGRectMake(windowSize.width-150, 25, 120, 40);
        self.saveButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:30];
        lblFont=20;
        height_frm_top=75;
    }
    else{
        lblFont=12;
        height_frm_top=55;
    }

    
    
    [self createUI];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)createUI{
    
    NSString * str=@"What makes you stand out? The more you share,the more interesting and real you become.";
    
    UILabel * label=[[UILabel alloc]init];
    label.frame=CGRectMake(windowSize.width/2-150, 0, windowSize.width-20, 80);
    label.backgroundColor=[UIColor clearColor];
    label.font=[UIFont systemFontOfSize:lblFont];
    label.textColor=[UIColor blackColor];
    label.text=str;
    label.lineBreakMode=NSLineBreakByCharWrapping;
    label.numberOfLines=0;
    label.textAlignment=NSTextAlignmentCenter;
    
    self.scrollView=[[UIScrollView alloc]init];
    self.scrollView.frame=CGRectMake(0, height_frm_top, windowSize.width, windowSize.height);
    self.scrollView.backgroundColor=[UIColor clearColor];
    [self.view addSubview: self.scrollView];
    
    [self.scrollView addSubview: label];
    
    self.scrollView.contentSize=CGSizeMake(windowSize.width, windowSize.height*1.1);
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    
    self.textView=[[UITextView alloc]init];
    self.textView.frame=CGRectMake(windowSize.width/2-150, 90, 300, 170);
    self.textView.layer.cornerRadius=4;
    self.textView.clipsToBounds=YES;
    if ([SingletonClass shareSingleton].aboutMe) {
        self.textView.text=[SingletonClass shareSingleton].aboutMe;
    }
    
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        label.frame=CGRectMake(windowSize.width/2-340, 30, windowSize.width-145, 80);
        //self.scrollView.frame=CGRectMake(0, height_frm_top, 320, self.view.frame.size.height);
        self.textView.frame=CGRectMake(windowSize.width/2-320, windowSize.height/2-300, windowSize.width-130, 400);
        self.textView.font=[UIFont systemFontOfSize:25];
    }
    
    
    [self.scrollView addSubview:self.textView];
    for (UIView * view  in self.scrollView.subviews )
    {
        if ([view isKindOfClass:[UITextView  class]])
        {
            [view becomeFirstResponder];
        
        }
    }
    
    
    
    
}

-(void)saveButtonAboutMeAction:(id)sender{
    NSError * error=nil;
    NSURLResponse * urlResponse=nil;
    
    [SingletonClass shareSingleton].interestedIn=self.textView.text;
    NSLog(@"%@ ==--== ",[SingletonClass shareSingleton].interestedIn);
   /* NSString * urlstr=[NSString stringWithFormat:@"http://taka.dating/aboutme-update/about/%@/%@ ",[SingletonClass shareSingleton].userID,[SingletonClass shareSingleton].aboutMe];
    
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];*/
    NSURL * url=[NSURL URLWithString:@"http://23.238.24.26/user/aboutme-update"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSString * body=[NSString stringWithFormat:@"userId=%@&aboutme=%@",[SingletonClass shareSingleton].userID,[SingletonClass shareSingleton].aboutMe];
    [request setHTTPBody:[body dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    
    
    if (!data) {
        NSLog(@"No Data available");
        return;
    }
    id parse_interrested_in=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"parse_interrested_in %@",parse_interrested_in);
    
    if ([[parse_interrested_in objectForKey:@"code"]isEqualToNumber:[NSNumber numberWithInt:198]]) {
        NSLog(@"Failed to do changes");
    }
    else{
        NSLog(@"Successfull");
    }
}



-(void)cancelButtonAction:(id)sender{
    
    [SingletonClass shareSingleton].aboutMe=self.textView.text;
    NSLog(@"%@ ==--== ",[SingletonClass shareSingleton].aboutMe);
   // [[[[[UIApplication sharedApplication]keyWindow]subviews]lastObject]removeFromSuperview];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"AboutMe" object:nil userInfo:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
