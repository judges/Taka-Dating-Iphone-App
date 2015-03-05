//
//  ActivationViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 05/12/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "ActivationViewController.h"
#import  "CustomMenuViewController.h"
#import "EncountersViewController.h"
#import "PeopleNearByViewController.h"
#import "AddphotosViewController.h"
#import "FavoritViewController.h"
#import "AppDelegate.h"
#import "AccountInfoViewController.h"
#import  "ProfileViewController.h"
#import "MessagesViewController.h"
#import  "VisitorsViewController.h"


@interface ActivationViewController ()

@end

@implementation ActivationViewController

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
    [self.view.layer insertSublayer:layer atIndex:0];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, self.view.frame.size.width-200, 35)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.text = @"Verify Account";
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
    

    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(20, 122, self.view.frame.size.width-40, 140);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    layer.borderWidth = 0.7;
    layer.borderColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)97/255 blue:(CGFloat)97/255 alpha:1.0].CGColor;
    [self.view.layer insertSublayer:layer atIndex:0];

    self.userLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 130, 30, 25)];

    self.userLabel.text=@"User";
    self.userLabel.font=[UIFont systemFontOfSize:12];
    self.userLabel.textAlignment=NSTextAlignmentLeft;
    self.userLabel.textColor=[UIColor grayColor];
    [self.view addSubview:self.userLabel];

    self.passwordLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 180, 60, 25)];
    self.passwordLabel.text=@"Password";
    self.passwordLabel.font=[UIFont systemFontOfSize:12];
    self.passwordLabel.textAlignment=NSTextAlignmentLeft;
    self.passwordLabel.textColor=[UIColor grayColor];
    [self.view addSubview:self.passwordLabel];
    
    self.activationLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 230, 60, 25)];
    self.activationLabel.text=@"Password";
    self.activationLabel.font=[UIFont systemFontOfSize:12];
    self.activationLabel.textAlignment=NSTextAlignmentLeft;
    self.activationLabel.textColor=[UIColor grayColor];
    [self.view addSubview:self.activationLabel];


    self.userText=[[UITextField alloc]initWithFrame:CGRectMake(120, 130, 150, 25)];
    self.userText.background=[UIImage imageNamed:@"signup_greyline.png"];
    self.userText.placeholder=@"   Email or Cell phone";
    self.userText.delegate=self;
    self.userText.layer.borderColor=[[UIColor blackColor]CGColor];
    self.userText.font=[UIFont systemFontOfSize:12];
//    self.userText.layer.borderWidth=0.7;
//    self.userText.clipsToBounds=YES;
//    self.userText.layer.cornerRadius=4;
    [self.view addSubview:self.userText];

    self.passwordText=[[UITextField alloc]initWithFrame:CGRectMake(120, 180, 150, 25)];
    self.passwordText.background=[UIImage imageNamed:@"signup_greyline.png"];
    self.passwordText.placeholder=@"   Required";
    self.passwordText.delegate=self;
    self.passwordText.layer.borderColor=[[UIColor blackColor]CGColor];
    self.passwordText.font=[UIFont systemFontOfSize:12];
    self.passwordText.secureTextEntry=YES;
//    self.passwordText.layer.borderWidth=0.7;
//    self.passwordText.clipsToBounds=YES;
//    self.passwordText.layer.cornerRadius=4;
    [self.view addSubview:self.passwordText];

    self.activationKey=[[UITextField alloc]initWithFrame:CGRectMake(120, 230, 150, 25)];
    self.activationKey.background=[UIImage imageNamed:@"signup_greyline.png"];
    self.activationKey.placeholder=@"   activation key";
    self.activationKey.delegate=self;
    self.activationKey.layer.borderColor=[[UIColor blackColor]CGColor];
    self.activationKey.font=[UIFont systemFontOfSize:12];
    self.activationKey.secureTextEntry=YES;
    //    self.passwordText.layer.borderWidth=0.7;
    //    self.passwordText.clipsToBounds=YES;
    //    self.passwordText.layer.cornerRadius=4;
    [self.view addSubview:self.activationKey];


    UIColor *secColor = [UIColor colorWithRed:(CGFloat)199/255 green:(CGFloat)64/255 blue:(CGFloat)109/255 alpha:1.0];

//Add signIn Button and forgot password button
    UIButton * signInButton=[UIButton buttonWithType:UIButtonTypeCustom];
    signInButton.frame=CGRectMake(180, 270, 60, 25);
    [signInButton setTitle:@"Verify" forState:UIControlStateNormal];
    signInButton.titleLabel.font=[UIFont systemFontOfSize:13];
    [signInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    signInButton.backgroundColor=secColor;
    signInButton.layer.cornerRadius=4;
    signInButton.clipsToBounds=YES;
    [signInButton addTarget:self action:@selector(VerifyAccount:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: signInButton];


    

}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    textField.background=[UIImage imageNamed:@"signup_blueline.png"];
    return  YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    textField.background=[UIImage imageNamed:@"signup_greyline.png"];
    return  YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return  YES;
}

-(void)cancelButtonAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark-Verify button action

-(void)VerifyAccount:(id)sender{
    NSError *error = nil;
    NSURLResponse *urlResponse=nil;
    //http://taka.dating/account/verification/Manj@gmail.com/ZsKda7qMDt/12345
    NSString * urlstr=[NSString stringWithFormat:@"http://taka.dating/account/verification/%@/%@/%@",self.userText.text,self.activationKey.text,self.passwordText.text];
    
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url=[NSURL URLWithString:urlstr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if(error)
    {
        NSLog(@"No data available %@",error);
    }
    
    id parse=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"parse %@",parse);
    
    NSNumber * code=[NSNumber numberWithInt:198];
    if([[parse objectForKey:@"code"] isEqualToNumber:code])
    {
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Incorrect Password or Activation key" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
              
    }
    else
    {
        
        
        EncountersViewController *encounterViewController = [[EncountersViewController alloc] initWithNibName:@"EncountersViewController" bundle:nil];
        encounterViewController.title = @"Encounter";
        ProfileViewController *profileViewCopntroller = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
        profileViewCopntroller.title = @"Profile";
        
        PeopleNearByViewController *nearByViewController = [[PeopleNearByViewController alloc] initWithNibName:@"PeopleNearByViewController" bundle:nil];
        nearByViewController.title = @"People Nearby";
        
        
        
        //    UINavigationController *profileNavigationController = [[UINavigationController alloc] initWithRootViewController:profileViewCopntroller];
        //    profileNavigationController.navigationBar.hidden = YES;
        
        UINavigationController *profileNavigationController = [[UINavigationController alloc] initWithRootViewController:encounterViewController];
        profileNavigationController.navigationBar.hidden = YES;
        
        
        MessagesViewController * messagesVC=[[MessagesViewController alloc]initWithNibName:@"MessagesViewController" bundle:nil];
        messagesVC.title=@"Messages";
        
        VisitorsViewController * visitorsVC=[[VisitorsViewController alloc]initWithNibName:@"VisitorsViewController" bundle:nil];
        visitorsVC.title=@"Visitors";
        
        FavoritViewController * favorite=[[FavoritViewController alloc]initWithNibName:@"FavoritViewController" bundle:nil];
        favorite.title=@"Favorite";
        
        CustomMenuViewController *customMenuViewController = [[CustomMenuViewController alloc] init];
        customMenuViewController.numberOfSections = 2;
        customMenuViewController.viewControllers = @[profileNavigationController,nearByViewController,profileViewCopntroller];
        customMenuViewController.secondSectionViewControllers=@[messagesVC,visitorsVC,favorite];
        
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:customMenuViewController];
        navi.navigationBar.hidden = YES;
        
        customMenuViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:navi animated:YES completion:nil];
        
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
