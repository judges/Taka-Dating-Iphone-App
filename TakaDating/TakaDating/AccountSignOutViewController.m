//
//  AccountSignOutViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 15/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "AccountSignOutViewController.h"
#import "SingletonClass.h"
#import "AFNHelper.h"
#import "ViewController.h"

@interface AccountSignOutViewController ()
{
    ViewController *viewVC;
}
@end

@implementation AccountSignOutViewController

@synthesize pasword,emailText,oldPassword;

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
    
    windowSize=[UIScreen mainScreen].bounds.size;
   
    
    
    
    self.scrollView=[[UIScrollView alloc]init];
    self.scrollView.frame=CGRectMake(0, 55, windowSize.width, windowSize.height);
    self.scrollView.backgroundColor=[UIColor clearColor];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:self.scrollView];

    
    self.scrollView.contentSize=CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height*1.1);
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, windowSize.width, 55);
    UIColor *firstColor = [UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
    UIColor *secColor = [UIColor colorWithRed:(CGFloat)121/255 green:(CGFloat)2/255 blue:(CGFloat)0/255 alpha:1.0];
    layer.colors = [NSArray arrayWithObjects:(id)[firstColor CGColor],(id)[secColor CGColor], nil];
    [self.view.layer insertSublayer:layer atIndex:0];
    
    //Adding title Label
    self.titleLabel=[[UILabel alloc]init];
    self.titleLabel.frame=CGRectMake(windowSize.width/2-40, 25, 100, 25);
    self.titleLabel.text=@"SignOut";
    self.titleLabel.textColor=[UIColor whiteColor];
    self.titleLabel.font=[UIFont boldSystemFontOfSize:20];
    [self.view addSubview:self.titleLabel];
    
    //Add Cancel Button
    self.cancelButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.frame=CGRectMake(windowSize.width/2-135, 25, 60, 25);

    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    self.cancelButton.layer.borderColor=[[UIColor redColor]CGColor];
    self.cancelButton.titleLabel.font=[UIFont systemFontOfSize:15];
    self.cancelButton.layer.cornerRadius=4;
    self.cancelButton.clipsToBounds=YES;
    self.cancelButton.layer.borderWidth=0.7;
    [self.cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cancelButton];
   
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        height=75;
        self.scrollView.frame=CGRectMake(0, 75, windowSize.width, windowSize.height);
        layer.frame = CGRectMake(0, 0, windowSize.width, 75);
        self.titleLabel.frame=CGRectMake(windowSize.width/2-40, 20, 200, 40);
        self.cancelButton.frame=CGRectMake(windowSize.width/2-350, 20, 120, 40);
      self.titleLabel.font=[UIFont boldSystemFontOfSize:30];
         self.cancelButton.titleLabel.font=[UIFont boldSystemFontOfSize:20];
        font_sz=20;
        next_question=[UIImage imageNamed:@"next_question_ipad.png"];
    }
    else{
       
        height=55;
        font_sz=12;
        next_question=[UIImage imageNamed:@"next_question.png"];
       
    }

    
    
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}

#pragma  mark- createUI
-(void)createUI{
    NSLog(@"Email ID : %@",[SingletonClass shareSingleton].emailID);
    self.emailIdLabel=[[UILabel alloc]init];
    self.emailIdLabel.frame=CGRectMake(windowSize.width/2-80, 100, 200, 25);
    self.emailIdLabel.font=[UIFont boldSystemFontOfSize:font_sz];
    self.emailIdLabel.text=[SingletonClass shareSingleton].emailID;
    self.emailIdLabel.textColor=[UIColor blackColor];
    [self.scrollView addSubview:self.emailIdLabel];
    
    self.signOutButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.signOutButton.frame=CGRectMake(windowSize.width/2-80, 150, 167, 32);
    [self.signOutButton setTitle:@"Sign Out" forState:UIControlStateNormal];
    [self.signOutButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.signOutButton.titleLabel.font=[UIFont systemFontOfSize:font_sz];
    self.signOutButton.layer.borderColor=[[UIColor blackColor]CGColor];
   
    self.signOutButton.clipsToBounds=YES;
    self.signOutButton.layer.cornerRadius=4;
    [self.signOutButton setBackgroundColor:[UIColor colorWithPatternImage:next_question]];
    //self.signOutButton.backgroundColor=[UIColor lightGrayColor];
    [self.signOutButton addTarget:self action:@selector(signOutButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.signOutButton];
    
    self.fogotPassword=[UIButton buttonWithType:UIButtonTypeCustom];
    self.fogotPassword.frame=CGRectMake(windowSize.width/2-80, 200, 167, 32);
    [self.fogotPassword setTitle:@"Forgot password" forState:UIControlStateNormal];
    [self.fogotPassword setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.fogotPassword.titleLabel.font=[UIFont systemFontOfSize:font_sz];
    self.fogotPassword.layer.borderColor=[[UIColor blackColor]CGColor];
    
    self.fogotPassword.clipsToBounds=YES;
    self.fogotPassword.layer.cornerRadius=4;
    [self.fogotPassword setBackgroundColor:[UIColor colorWithPatternImage:next_question]];
    //self.fogotPassword.backgroundColor=[UIColor lightGrayColor];
    [self.fogotPassword addTarget:self action:@selector(forgotPasswordButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.fogotPassword];
    
    self.deleteAccountButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteAccountButton.frame=CGRectMake(windowSize.width/2-110, 380, 200, 30);
    [self.deleteAccountButton setTitle:@"Delete Account" forState:UIControlStateNormal];
    [self.deleteAccountButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.deleteAccountButton.titleLabel.font=[UIFont systemFontOfSize:font_sz];
    [self.deleteAccountButton addTarget:self action:@selector(deleteAccountButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.deleteAccountButton];
    
    
    self.changePassword=[UIButton buttonWithType:UIButtonTypeCustom];
    self.changePassword.frame=CGRectMake(windowSize.width/2-80, 250, 167, 32);
    [self.changePassword setTitle:@"Change passowrd" forState:UIControlStateNormal];
    [self.changePassword setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.changePassword.titleLabel.font=[UIFont systemFontOfSize:font_sz];
   
    self.changePassword.clipsToBounds=YES;
    self.changePassword.layer.cornerRadius=4;
   // self.changePassword.backgroundColor=[UIColor lightGrayColor];
    [self.changePassword setBackgroundColor:[UIColor colorWithPatternImage:next_question]];
    [self.changePassword addTarget:self action:@selector(changePasswordtButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.changePassword];
    
    
    self.changeEmail=[UIButton buttonWithType:UIButtonTypeCustom];
    self.changeEmail.frame=CGRectMake(windowSize.width/2-80, 300, 167, 32);
    [self.changeEmail setTitle:@"Change email" forState:UIControlStateNormal];
    [self.changeEmail setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.changeEmail.titleLabel.font=[UIFont systemFontOfSize:font_sz];
    
    self.changeEmail.clipsToBounds=YES;
    self.changeEmail.layer.cornerRadius=4;
    // self.changePassword.backgroundColor=[UIColor lightGrayColor];
    [self.changeEmail setBackgroundColor:[UIColor colorWithPatternImage:next_question]];
    [self.changeEmail addTarget:self action:@selector(changeEmailtButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.changeEmail];
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        self.emailIdLabel.frame=CGRectMake(windowSize.width/2-140, 100, 328, 25);
        self.signOutButton.frame=CGRectMake(windowSize.width/2-160, 200, 328, 62);
        self.fogotPassword.frame=CGRectMake(windowSize.width/2-160, 300, 328, 62);
        self.deleteAccountButton.frame=CGRectMake(windowSize.width/2-200, 580, 328, 62);
         self.changePassword.frame=CGRectMake(windowSize.width/2-160, 400, 328, 62);
         self.changeEmail.frame=CGRectMake(windowSize.width/2-160, 500, 328, 62);
      
    }
}


#pragma mark- signOutButtonAction

-(void)signOutButtonAction:(id)sender{
    if (!self.actionSheet) {
        self.actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Sign Out", nil];
        
    }
    [self.actionSheet showInView:self.view];
    
}

#pragma mark- Change Email
-(void)changeEmailtButtonAction:(id)sender{
    
    [UIView animateWithDuration:0.5 animations:^{
        [self createUIForChangeEmail];
    } completion:^(BOOL finished) {
        
    }];

}
#pragma  mark-changePasswordtButtonAction

-(void)changePasswordtButtonAction:(id)sender{
    
    [UIView animateWithDuration:0.5 animations:^{
         [self createPopUpView];
    } completion:^(BOOL finished) {
        
    }];
   
   
    
}



-(void)createUIForChangeEmail{
    if (!self.displayView) {
        self.displayView=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        self.displayView.backgroundColor=[UIColor blackColor];
        [self.displayView setAlpha:1.0];
        [self.view addSubview:self.displayView];
    
    if (self.changePassowrdView) {
        self.changePassowrdView=nil;
    }
    self.changePassowrdView =[[UIView alloc]init];
    self.changePassowrdView.frame=CGRectMake(50, 300, 220, 150);
    self.changePassowrdView.backgroundColor=[UIColor whiteColor];
    self.changePassowrdView.layer.cornerRadius=4.0;
    self.changePassowrdView.clipsToBounds=YES;
    self.changePassowrdView.layer.borderWidth=0.7;
    self.changePassowrdView.layer.borderColor=[[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)97/255 blue:(CGFloat)97/255 alpha:1.0]CGColor];
    [self.displayView addSubview:self.changePassowrdView];
    
    UIView * view=[[UIView alloc]init];
    view.frame=CGRectMake(0, 110, 220, 40);
    view.backgroundColor=[UIColor colorWithRed:(CGFloat)193/255 green:(CGFloat)193/255 blue:(CGFloat)193/255 alpha:1.0];
    [self.changePassowrdView addSubview:view];
    
    if (self.emailText) {
        self.emailText=nil;
    }
    
    self.emailText=[[UITextField alloc]init];
    self.emailText.frame=CGRectMake(10, 5,200, 30);
    self.emailText.placeholder=@"Email ID";
    self.emailText.textAlignment=NSTextAlignmentCenter;
    self.emailText.layer.borderColor=[UIColor colorWithRed:(CGFloat)158/255 green:(CGFloat)158/255 blue:(CGFloat)158/255 alpha:1.0].CGColor;
    self.emailText.layer.borderWidth=0.2;
    self.emailText.layer.cornerRadius=4.0;
    self.emailText.clipsToBounds=YES;
    self.emailText.delegate=self;
    [self.changePassowrdView addSubview: self.emailText];
    
    /* UIImageView * lineone=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"red_line.png"]];
     lineone.frame=CGRectMake(0, 45, 220, 1);
     [self.changePassowrdView addSubview:lineone];*/
    if (self.newemailText) {
        self.newemailText=nil;
    }
    self.newemailText=[[UITextField alloc]init];
    self.newemailText.frame=CGRectMake(10, 40,200, 30);
    self.newemailText.placeholder=@"New email";
    self.newemailText.textAlignment=NSTextAlignmentCenter;
    self.newemailText.layer.borderColor=[UIColor colorWithRed:(CGFloat)158/255 green:(CGFloat)158/255 blue:(CGFloat)158/255 alpha:1.0].CGColor;
    self.newemailText.layer.borderWidth=0.2;
    self.newemailText.layer.cornerRadius=4.0;
    self.newemailText.clipsToBounds=YES;
    self.newemailText.delegate=self;
    self.newemailText.secureTextEntry=YES;
    [self.changePassowrdView addSubview: self.newemailText];
    
    /* UIImageView * linetwo=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"red_line.png"]];
     linetwo.frame=CGRectMake(0, 80, 220, 1);
     [self.changePassowrdView addSubview:linetwo];*/
    if (self.pasword) {
        self.pasword=nil;
    }
    self.pasword=[[UITextField alloc]init];
    self.pasword.frame=CGRectMake(10, 75,200, 30);
    self.pasword.placeholder=@"Password";
    self.pasword.textAlignment=NSTextAlignmentCenter;
    self.pasword.layer.borderColor=[UIColor colorWithRed:(CGFloat)158/255 green:(CGFloat)158/255 blue:(CGFloat)158/255 alpha:1.0].CGColor;
    self.pasword.layer.borderWidth=0.2;
    self.pasword.layer.cornerRadius=4.0;
    self.pasword.clipsToBounds=YES;
    self. pasword.delegate=self;
    self.pasword.secureTextEntry=YES;
    [self.changePassowrdView addSubview: self.pasword];
    
    UIImageView * linethree=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"red_line.png"]];
    linethree.frame=CGRectMake(0, 110, 220, 1);
    [self.changePassowrdView addSubview:linethree];
    
    UIButton * okButton=[[UIButton alloc]init];
    okButton.frame=CGRectMake(140, 5, 60, 30);
    [okButton setTitle:@"OK" forState:UIControlStateNormal];
    [okButton addTarget:self action:@selector(emailButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okButton setBackgroundColor:[UIColor colorWithRed:(CGFloat)10/255 green:(CGFloat)157/255 blue:(CGFloat)14/255 alpha:1.0]];
    okButton.layer.borderColor=[UIColor whiteColor].CGColor;
    okButton.layer.borderWidth=0.5;
    okButton.titleLabel.font=[UIFont systemFontOfSize:12];
    [view addSubview:okButton];
    
    UIButton * cancelButton=[[UIButton alloc]init];
    cancelButton.frame=CGRectMake(20, 5, 60, 30);
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelButton setBackgroundColor:[UIColor colorWithRed:(CGFloat)204 /255 green:(CGFloat)0/255 blue:(CGFloat)0/255 alpha:1.0]];
    cancelButton.layer.borderColor=[UIColor whiteColor].CGColor;
    cancelButton.layer.borderWidth=0.5;
    cancelButton.titleLabel.font=[UIFont systemFontOfSize:12];
    [cancelButton addTarget:self action:@selector(cancelButtonMethod:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:cancelButton];
    }
}

-(void)createPopUpView{
    if (!self.displayView) {
        self.displayView=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        self.displayView.backgroundColor=[UIColor blackColor];
        [self.displayView setAlpha:1.0];
        [self.view addSubview:self.displayView];
    if (self.changePassowrdView) {
        self.changePassowrdView=nil;
    }
    self.changePassowrdView =[[UIView alloc]init];
    self.changePassowrdView.frame=CGRectMake(50, 300, 220, 150);
    self.changePassowrdView.backgroundColor=[UIColor whiteColor];
    self.changePassowrdView.layer.cornerRadius=4.0;
    self.changePassowrdView.clipsToBounds=YES;
    self.changePassowrdView.layer.borderWidth=0.7;
    self.changePassowrdView.layer.borderColor=[[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)97/255 blue:(CGFloat)97/255 alpha:1.0]CGColor];
    [self.view addSubview:self.changePassowrdView];
    
    UIView * view=[[UIView alloc]init];
    view.frame=CGRectMake(0, 110, 220, 40);
    view.backgroundColor=[UIColor colorWithRed:(CGFloat)193/255 green:(CGFloat)193/255 blue:(CGFloat)193/255 alpha:1.0];
    [self.changePassowrdView addSubview:view];
    
    if (self.emailText) {
        self.emailText=nil;
    }
    
   self.emailText=[[UITextField alloc]init];
    self.emailText.frame=CGRectMake(10, 5,200, 30);
    self.emailText.placeholder=@"Email ID";
    self.emailText.textAlignment=NSTextAlignmentCenter;
    self.emailText.layer.borderColor=[UIColor colorWithRed:(CGFloat)158/255 green:(CGFloat)158/255 blue:(CGFloat)158/255 alpha:1.0].CGColor;
    self.emailText.layer.borderWidth=0.2;
    self.emailText.layer.cornerRadius=4.0;
    self.emailText.clipsToBounds=YES;
    self.emailText.delegate=self;
    [self.changePassowrdView addSubview: self.emailText];
    
    /* UIImageView * lineone=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"red_line.png"]];
     lineone.frame=CGRectMake(0, 45, 220, 1);
     [self.changePassowrdView addSubview:lineone];*/
    if (self.oldPassword) {
        self.oldPassword=nil;
    }
    self.oldPassword=[[UITextField alloc]init];
    self.oldPassword.frame=CGRectMake(10, 40,200, 30);
    self.oldPassword.placeholder=@"Old password";
    self.oldPassword.textAlignment=NSTextAlignmentCenter;
    self.oldPassword.layer.borderColor=[UIColor colorWithRed:(CGFloat)158/255 green:(CGFloat)158/255 blue:(CGFloat)158/255 alpha:1.0].CGColor;
    self.oldPassword.layer.borderWidth=0.2;
    self.oldPassword.layer.cornerRadius=4.0;
    self.oldPassword.clipsToBounds=YES;
    self.oldPassword.delegate=self;
    self.oldPassword.secureTextEntry=YES;
    [self.changePassowrdView addSubview: self.oldPassword];
    
    /* UIImageView * linetwo=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"red_line.png"]];
     linetwo.frame=CGRectMake(0, 80, 220, 1);
     [self.changePassowrdView addSubview:linetwo];*/
    if (self.pasword) {
        self.pasword=nil;
    }
    self.pasword=[[UITextField alloc]init];
    self.pasword.frame=CGRectMake(10, 75,200, 30);
    self.pasword.placeholder=@"New password";
    self.pasword.textAlignment=NSTextAlignmentCenter;
    self.pasword.layer.borderColor=[UIColor colorWithRed:(CGFloat)158/255 green:(CGFloat)158/255 blue:(CGFloat)158/255 alpha:1.0].CGColor;
    self.pasword.layer.borderWidth=0.2;
    self.pasword.layer.cornerRadius=4.0;
    self.pasword.clipsToBounds=YES;
   self. pasword.delegate=self;
    self.pasword.secureTextEntry=YES;
    [self.changePassowrdView addSubview: self.pasword];
    
    UIImageView * linethree=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"red_line.png"]];
    linethree.frame=CGRectMake(0, 110, 220, 1);
    [self.changePassowrdView addSubview:linethree];
    
    UIButton * okButton=[[UIButton alloc]init];
    okButton.frame=CGRectMake(140, 5, 60, 30);
    [okButton setTitle:@"OK" forState:UIControlStateNormal];
    [okButton addTarget:self action:@selector(okButtonaction:) forControlEvents:UIControlEventTouchUpInside];
    [okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okButton setBackgroundColor:[UIColor colorWithRed:(CGFloat)10/255 green:(CGFloat)157/255 blue:(CGFloat)14/255 alpha:1.0]];
    okButton.layer.borderColor=[UIColor whiteColor].CGColor;
    okButton.layer.borderWidth=0.5;
    okButton.titleLabel.font=[UIFont systemFontOfSize:12];
    [view addSubview:okButton];
    
    UIButton * cancelButton=[[UIButton alloc]init];
    cancelButton.frame=CGRectMake(20, 5, 60, 30);
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelButton setBackgroundColor:[UIColor colorWithRed:(CGFloat)204 /255 green:(CGFloat)0/255 blue:(CGFloat)0/255 alpha:1.0]];
    cancelButton.layer.borderColor=[UIColor whiteColor].CGColor;
    cancelButton.layer.borderWidth=0.5;
    cancelButton.titleLabel.font=[UIFont systemFontOfSize:12];
    [cancelButton addTarget:self action:@selector(cancelButtonMethod:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:cancelButton];
    }
}


#pragma  mark- Change Emai pop up
-(void)emailButtonAction:(id)sender{

        NSLog(@"Ok buton Clicked");
        
        NSError *error = nil;
        NSURLResponse *urlResponse=nil;
        
   /* NSString * urlstr=[NSString stringWithFormat:@"http://taka.dating/change/useremail/%@/%@/%@",self.emailText.text,self.newemailText.text,self.pasword.text];
        
        
        urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL * url=[NSURL URLWithString:urlstr];*/
    NSURL * url=[NSURL URLWithString:@"http://23.238.24.26/settings/change-email"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSString * body=[NSString stringWithFormat:@"UserEmail=%@&newEmail=%@&password=%@",self.emailText.text,self.oldPassword.text,self.pasword.text];
    [request setHTTPBody:[body dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    
    
        NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
        if(error)
        {
            NSLog(@"No data available %@",error);
        }
        
        else{
            
            id parse=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"change passowrd %@",parse);
            NSNumber * code=[NSNumber numberWithInt:200];
            if ([[parse objectForKey:@"code"] isEqualToNumber:code ]) {
                
                [UIView animateWithDuration:0.5 animations:^{
                    [UIView animateWithDuration:0.5 animations:^{
                        self.changePassowrdView.hidden=YES;
                        self.changePassowrdView=nil;
                        
                    }];
                    self.changePassowrdView.frame=CGRectMake(50, 300, 220, 150);
                } completion:^(BOOL finished) {
                    [self alertViewNotification:@"Successfull changed EmailId"];
                }];
                
            }
            else{
                [self alertViewNotification:@"EmailId not updated"];
                [UIView animateWithDuration:0.5 animations:^{
                    self.displayView.hidden=YES;
                    self.displayView=nil;
                    self.changePassowrdView.hidden=YES;
                    self.changePassowrdView=nil;
                    
                }];
            }
            
        }
        
    }


#pragma mark- Change password pop up

-(void)okButtonaction:(id)sender{
    NSLog(@"Ok buton Clicked");
   
    NSError *error = nil;
    NSURLResponse *urlResponse=nil;
    
   /* NSString * urlstr=[NSString stringWithFormat:@"http://taka.dating/change/userpassword/%@/%@/%@",self.emailText.text,self.oldPassword.text,self.pasword.text];
    
    
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];*/
    NSURL * url=[NSURL URLWithString:@"http://23.238.24.26/settings/change-passwrd"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSString * body=[NSString stringWithFormat:@"userEmail=%@&=%@&newPassword=%@",self.emailText.text,self.oldPassword.text,self.pasword.text];
    [request setHTTPBody:[body dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if(error)
    {
        NSLog(@"No data available %@",error);
    }
    
    else{
        
       id parse=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"change passowrd %@",parse);
        NSNumber * code=[NSNumber numberWithInt:200];
        if ([[parse objectForKey:@"code"] isEqualToNumber:code ]) {
            
            [UIView animateWithDuration:0.5 animations:^{
                [UIView animateWithDuration:0.5 animations:^{
                    self.changePassowrdView.hidden=YES;
                    self.changePassowrdView=nil;
                    
                }];
               self.changePassowrdView.frame=CGRectMake(50, 300, 220, 150);
            } completion:^(BOOL finished) {
                [self alertViewNotification:@"Successfull changed password"];
            }];

        }
        else{
             [self alertViewNotification:@"Password not updated"];
            [UIView animateWithDuration:0.5 animations:^{
                self.displayView.hidden=YES;
                self.displayView=nil;
                self.changePassowrdView.hidden=YES;
                self.changePassowrdView=nil;
                
            }];
        }
    
    }
    
}

-(void)cancelButtonMethod:(id)sender{
    NSLog(@"Cancelbuton Clicked");
    [UIView animateWithDuration:0.5 animations:^{
        [UIView animateWithDuration:0.5 animations:^{
            self.displayView.hidden=YES;
            self.displayView=nil;
            self.changePassowrdView.hidden=YES;
            self.changePassowrdView=nil;
            
        }];
        self.changePassowrdView.frame=CGRectMake(50, 300, 220, 150);
    } completion:^(BOOL finished) {
        
    }];
    
}

#pragma  mark- forgotpassword
-(void)forgotPasswordButtonAction:(id)sender{
    
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Forgot password " message:@"Password has been sent to your email." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        
        NSMutableDictionary * dictParm=[[NSMutableDictionary alloc]init];
        [dictParm setValue:[SingletonClass shareSingleton].emailID forKey:@"email"];
        
        NSString * postUrl=@"http://taka.dating/forgot-password";
        AFNHelper * afn=[[AFNHelper alloc]init];
        
        
        
        [afn getDataFromPath:postUrl withParamData:dictParm withBlock:^(id response, NSError *error) {
            if (error) {
                NSLog(@"Fail to post");
            }
            else{
                NSLog(@"Posted successfully");
            }
        }];
   
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        NSLog(@"For got password button clicked");
    }
}


#pragma mark- Action sheet delegate method
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        NSLog(@"Sign Out button clicked");
    }
}

#pragma  mark-deleteAccountButtonAction

-(void)deleteAccountButtonAction:(id)sender{
   /* if (!deleteVC) {
        deleteVC=[[DeleteAccountViewController alloc]initWithNibName:@"DeleteAccountViewController" bundle:nil];
    }
    appdelegate=[UIApplication sharedApplication].delegate;
    [appdelegate.window addSubview:deleteVC.view];*/
    
    
    NSError * error=nil;
    NSURLResponse * urlResponse=nil;
    NSURL * postUrl=[NSURL URLWithString:@"http://23.238.24.26/settings/delete/"];
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:postUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSString * body=[NSString stringWithFormat:@"=%@&=%@",[SingletonClass shareSingleton].emailID,[SingletonClass shareSingleton].password];
    [request setHTTPBody:[body dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (data==nil) {
        return;
    }
    id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"parse %@",json);
    if ([[json objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
        viewVC=[[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
        [self presentViewController:viewVC animated:YES completion:nil];
    }
    
    
}

#pragma mark- cancel button
-(void)cancelButtonAction:(id)sender{
      //[[[[[UIApplication sharedApplication]keyWindow]subviews]lastObject]removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark-text methods delegates

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.changePassowrdView.frame=CGRectMake(50, 100, 220, 150);
    }];
    return  YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return  YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return  YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark- aletview
-(void)alertViewNotification:(NSString *)notify{
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:notify delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}

@end
