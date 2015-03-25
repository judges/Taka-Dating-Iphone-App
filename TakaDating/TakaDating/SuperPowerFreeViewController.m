//
//  SuperPowerFreeViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 03/12/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "SuperPowerFreeViewController.h"
#import "SingletonClass.h"

@interface SuperPowerFreeViewController ()

@end

@implementation SuperPowerFreeViewController

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
    
    self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, self.view.frame.size.width, 55);
    UIColor *firstColor = [UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
    UIColor *secColor = [UIColor colorWithRed:(CGFloat)121/255 green:(CGFloat)2/255 blue:(CGFloat)0/255 alpha:1.0];
    layer.colors = [NSArray arrayWithObjects:(id)[firstColor CGColor],(id)[secColor CGColor], nil];
    //[self.view.layer insertSublayer:layer atIndex:0];
    [self.view.layer insertSublayer:layer atIndex:0];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, self.view.frame.size.width, 35)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.text = @"Super Power for free";
    [self.view addSubview:self.titleLabel];
    //Add Cancel BUTTON
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.frame = CGRectMake(15, 25, 60, 25);
    [self.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    self.cancelButton.layer.borderColor = [UIColor redColor].CGColor;
    self.cancelButton.layer.borderWidth = 0.7;
    self.cancelButton.layer.cornerRadius = 4;
    self.cancelButton.clipsToBounds = YES;
    [self.cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cancelButton];
    
    [self createUI];
    
    

    // Do any additional setup after loading the view from its nib.
}


-(void)createUI{
    
    UILabel * inviteLabel=[[UILabel alloc]init];
    inviteLabel.frame=CGRectMake(30, 80, 260, 80);
    inviteLabel.text=@"Invite more than 30 friends to Taka and active Super Powers for free !";
    inviteLabel.textAlignment=NSTextAlignmentCenter;
    inviteLabel.font=[UIFont boldSystemFontOfSize:20];
    inviteLabel.lineBreakMode=NSLineBreakByCharWrapping;
    inviteLabel.numberOfLines=0;
    [self.view addSubview:inviteLabel];
    
    UILabel  * label=[[UILabel alloc]init];
    label.frame=CGRectMake(20, 200, 280, 30);
    label.textAlignment=NSTextAlignmentCenter;
    label.text=@"We supprot 65 email providers";
    label.font=[UIFont systemFontOfSize:12];
    label.textColor=[UIColor grayColor];
    [self.view addSubview:label];
    
    UIView * bottomView=[[UIView alloc]init];
    if ([UIScreen mainScreen].bounds.size.height<500) {
        bottomView.frame=CGRectMake(0, self.view.frame.size.height-135, self.view.frame.size.width, 50);
    }
    else{
        bottomView.frame=CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 50);
    }
    bottomView.backgroundColor=[UIColor blackColor];
    [self.view addSubview:bottomView];
    
    UIButton * howItWorks=[UIButton buttonWithType:UIButtonTypeCustom];
    howItWorks.frame=CGRectMake(90, 10, 120, 30);
    [howItWorks setTitle:@"How it works" forState:UIControlStateNormal];
    [howItWorks setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [howItWorks addTarget:self action:@selector(howItWorksButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:howItWorks];
    
    
}

#pragma mark-howItWorksButtonAction


-(void)howItWorksButtonAction:(id)sender{
    NSString * message=@"By proceeding you're giving Taka permission to access your friends' contact details from your phone book,email account,social network,or any address you type in. We will store these addresses securely and we won't share them with anyone.";
    
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:message message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}

#pragma mark-Cancel Button

-(void)cancelButtonAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
//    [[[[[UIApplication sharedApplication]keyWindow]subviews]lastObject]removeFromSuperview];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
