//
//  QuestionsViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 22/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "QuestionsViewController.h"

@interface QuestionsViewController ()

@end

@implementation QuestionsViewController

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
    CAGradientLayer * layer=[[CAGradientLayer alloc]init];
    layer.frame=CGRectMake(0, 0, 320, 55);
    UIColor * firstColor=[UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
    UIColor * secondColor=[UIColor colorWithRed:(CGFloat)121/255 green:(CGFloat)2/255 blue:(CGFloat)0/255 alpha:1.0];
    layer.colors=@[(id)[firstColor CGColor],(id)[secondColor CGColor]];
    [self.view.layer insertSublayer:layer atIndex:0];
    
    self.titleLabel=[[UILabel alloc]init];
    self.titleLabel.frame=CGRectMake(120, 20, 150, 25);
    self.titleLabel.textColor=[UIColor whiteColor];
    self.titleLabel.text=self.titleStr;
    self.titleLabel.font=[UIFont boldSystemFontOfSize:20];
    [self.view addSubview:self.titleLabel];
    
    self.cancelButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.frame=CGRectMake(15, 25, 60, 25);
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    self.cancelButton.titleLabel.textColor=[UIColor whiteColor];
    self.cancelButton.layer.borderColor=[[UIColor redColor]CGColor];
    self.cancelButton.backgroundColor=[UIColor clearColor];
    self.cancelButton.layer.borderWidth=0.7;
    self.cancelButton.clipsToBounds=YES;
    self.cancelButton.layer.cornerRadius=4;
    [self.cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cancelButton];
    self.title=@"Questions";
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 1);
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:                                                                [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,                                                                                                         shadow, NSShadowAttributeName,                                                                                                         [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil]];
    
    UIBarButtonItem * barButton=[[UIBarButtonItem alloc]initWithCustomView:self.cancelButton];
    self.navigationItem.leftBarButtonItem=barButton;

    // Do any additional setup after loading the view from its nib.
}

-(void)cancelButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
