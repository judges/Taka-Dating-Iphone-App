//
//  IntermediateViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 08/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "IntermediateViewController.h"
#import "SignInViewController.h"
#import "SignUpViewController.h"

@interface IntermediateViewController ()
@property (nonatomic, strong) SignInViewController *signInViewController;
@property (nonatomic, strong) SignUpViewController *signUpViewController;
@end

@implementation IntermediateViewController

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
    // Do any additional setup after loading the view from its nib.
    self.windowSize = [UIScreen mainScreen].bounds.size;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"screen_ipad.png"]];
        
    }
    else{
            if(self.windowSize.height>500)
            {
                self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"screen2_568.png"]];
            }
            else{
                self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"screen2_480.png"]];
            }
    }

    [self createUI];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) createUI{
    
    self.facebook_btn = [UIButton buttonWithType:UIButtonTypeCustom];
   // self.facebook_btn.frame = CGRectMake(80, self.windowSize.height - 150,167, 32);
   // [self.facebook_btn setBackgroundImage:[UIImage imageNamed:@"fb_btn.png" ]forState:UIControlStateNormal];
    [self.facebook_btn addTarget:self action:@selector(facebook_btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.facebook_btn];
    //Add Other Option Button
    
    self.other_option_btn = [UIButton buttonWithType:UIButtonTypeCustom];
   // self.other_option_btn.frame = CGRectMake(80, self.windowSize.height - 100, 167, 31);
    //[self.other_option_btn setBackgroundImage:[UIImage imageNamed:@"email_login.png" ]forState:UIControlStateNormal];
    [self.other_option_btn addTarget:self action:@selector(otherOptionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.other_option_btn];
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        
        [self.facebook_btn setBackgroundImage:[UIImage imageNamed:@"signin_fb_btn_ipad.png"] forState:UIControlStateNormal ];
       [self.other_option_btn setBackgroundImage:[UIImage imageNamed:@"email_login_ipad.png" ]forState:UIControlStateNormal];
        self.facebook_btn.frame = CGRectMake(self.windowSize.width/2-150, self.windowSize.height - 300, 328, 62);
        self.other_option_btn.frame = CGRectMake(self.windowSize.width/2-150, self.windowSize.height - 205, 328, 62);
        font_size=20;
        privacy_font=15;
    }
    else{
        font_size=13;
        privacy_font=9;
        [self.facebook_btn setBackgroundImage:[UIImage imageNamed:@"signin_fb_btn.png"] forState:UIControlStateNormal ];
        [self.other_option_btn setBackgroundImage:[UIImage imageNamed:@"email_login.png" ]forState:UIControlStateNormal];
        self.other_option_btn.frame = CGRectMake(80, self.windowSize.height - 105, 167, 32);
        self.facebook_btn.frame = CGRectMake(80, self.windowSize.height - 155, 167, 32);
        
    }
    
    
    
    UIImageView * warningBigImage=[[UIImageView alloc]init];
    warningBigImage.backgroundColor=[UIColor clearColor];
    warningBigImage.image=[UIImage imageNamed:@"warning_icon_big.png"];
    [self.view addSubview:warningBigImage];
    
    UIImageView * tranperantImage=[[UIImageView alloc]init];
    tranperantImage.backgroundColor=[UIColor clearColor];
    tranperantImage.image=[UIImage imageNamed:@"warning_trasparent_bg.png"];
    [self.view addSubview:tranperantImage];
    
    UIImageView * warningImage1=[[UIImageView alloc]init];
    warningImage1.backgroundColor=[UIColor clearColor];
    warningImage1.image=[UIImage imageNamed:@"warning_icon_small.png"];
    [self.view addSubview:warningImage1];
    
    UIImageView * warningImage2=[[UIImageView alloc]init];
    warningImage2.backgroundColor=[UIColor clearColor];
    warningImage2.image=[UIImage imageNamed:@"warning_icon_small.png"];
    [self.view addSubview:warningImage2];
    
    UILabel * tranperantImgLabel1=[[UILabel alloc]init];
    tranperantImgLabel1.backgroundColor=[UIColor clearColor];
    tranperantImgLabel1.textColor=[UIColor whiteColor];
    tranperantImgLabel1.font=[UIFont systemFontOfSize:font_size];
    tranperantImgLabel1.text=@" All areas of the app";
    [self.view addSubview:tranperantImgLabel1];
    
    UILabel * tranperantImgLabel2=[[UILabel alloc]init];
    tranperantImgLabel2.backgroundColor=[UIColor clearColor];
    tranperantImgLabel2.textColor=[UIColor whiteColor];
    tranperantImgLabel2.font=[UIFont systemFontOfSize:font_size];
    tranperantImgLabel2.text=@" All your Facebook friends";
    [self.view addSubview:tranperantImgLabel2];
    
    
    
    UILabel * WarningLabelWhite=[[UILabel alloc]init];
    WarningLabelWhite.text=@"If You do not register with Facebook,";
    WarningLabelWhite.textColor=[UIColor whiteColor];
    WarningLabelWhite.font=[UIFont systemFontOfSize:font_size];
    [self.view addSubview:WarningLabelWhite];
    
    UILabel * WarningLabelYellow=[[UILabel alloc]init];
    WarningLabelYellow.text=@"You will not get access to:";
    WarningLabelYellow.textColor=[UIColor colorWithRed:255.0/255.0 green:245.0/255.0 blue:0.0/255.0 alpha:1.0];
     WarningLabelYellow.font=[UIFont systemFontOfSize:font_size];
    [self.view addSubview:WarningLabelYellow];
    
    UILabel * privacyLabel=[[UILabel alloc]init];
    privacyLabel.text=@"We respect your privacy and we will never post to Facebook anything without your permission.";
    privacyLabel.font=[UIFont boldSystemFontOfSize:privacy_font];
    privacyLabel.textColor=[UIColor whiteColor];
    privacyLabel.lineBreakMode=NSLineBreakByCharWrapping;
    privacyLabel.numberOfLines=0;
    [privacyLabel sizeToFit];
    [self.view addSubview:privacyLabel];
    
    
    UILabel * privacyLabelSec=[[UILabel alloc]init];
    privacyLabelSec.text=@"anything without your permission.";
    privacyLabelSec.font=[UIFont boldSystemFontOfSize:privacy_font];
    privacyLabelSec.textColor=[UIColor whiteColor];
    privacyLabelSec.lineBreakMode=NSLineBreakByCharWrapping;
    privacyLabelSec.numberOfLines=0;
    [privacyLabelSec sizeToFit];
    [self.view addSubview:privacyLabelSec];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        
        warningBigImage.frame=CGRectMake(self.windowSize.width/2-100, 90, 162, 141);
        tranperantImage.frame=CGRectMake(self.windowSize.width/2-200, 370, 375, 162);
        warningImage1.frame=CGRectMake(self.windowSize.width/2-180, 400, 52, 52);
        warningImage2.frame=CGRectMake(self.windowSize.width/2-180, 443, 52, 52);
        tranperantImgLabel1.frame=CGRectMake(self.windowSize.width/2-100, 410, 375, 30);
        tranperantImgLabel2.frame=CGRectMake(self.windowSize.width/2-100, 450, 375, 30);
        WarningLabelWhite.frame=CGRectMake(self.windowSize.width/2-150, 300, self.windowSize.width/2, 30);
        WarningLabelYellow.frame=CGRectMake(self.windowSize.width/2-130, 320, self.windowSize.width/2-100, 30);
        privacyLabel.frame=CGRectMake(self.windowSize.width/2-200, self.windowSize.height/2+50, self.windowSize.width/2+50, 30);
        privacyLabelSec.frame=CGRectMake(self.windowSize.width/2-130, self.windowSize.height/2+80, self.windowSize.width/2, 30);
        
        warningBigImage.image=[UIImage imageNamed:@"warning_icon_big_ipad.png"];
        tranperantImage.image=[UIImage imageNamed:@"warning_trasparent_bg_ipad.png"];
        warningImage1.image=[UIImage imageNamed:@"warning_icon_small_ipad.png"];
        warningImage2.image=[UIImage imageNamed:@"warning_icon_small_ipad.png"];
    }
    else{
        
        if ([UIScreen mainScreen].bounds.size.height>500) {
            warningBigImage.frame=CGRectMake(110, 90, 100, 100);
            tranperantImage.frame=CGRectMake(50, 250, 220, 80);
            warningImage1.frame=CGRectMake(57, 260, 25, 25);
            warningImage2.frame=CGRectMake(57, 293, 25, 25);
            tranperantImgLabel1.frame=CGRectMake(87, 260, 150, 25);
            tranperantImgLabel2.frame=CGRectMake(87, 293, 160, 25);
            WarningLabelWhite.frame=CGRectMake(50, 200, 248, 25);
            WarningLabelYellow.frame=CGRectMake(70, 220, 200, 25);
            privacyLabel.frame=CGRectMake(35, 340, 260, 15);
            privacyLabelSec.frame=CGRectMake(80, 355, 240, 15);
        }
        else{
            warningBigImage.frame=CGRectMake(110, 50, 100, 100);
            tranperantImage.frame=CGRectMake(50, 210, 220, 80);
            warningImage1.frame=CGRectMake(57, 220, 25, 25);
            warningImage2.frame=CGRectMake(57, 253, 25, 25);
            tranperantImgLabel1.frame=CGRectMake(87, 220, 150, 25);
            tranperantImgLabel2.frame=CGRectMake(87, 253, 160, 25);
            WarningLabelWhite.frame=CGRectMake(50, 150, 248, 25);
            WarningLabelYellow.frame=CGRectMake(70, 170, 200, 25);
            privacyLabel.frame=CGRectMake(35, 290, 260, 15);
            privacyLabelSec.frame=CGRectMake(80, 305, 240, 15);
        }
        
        
    }
    
    
}
-(void)facebook_btnAction:(id)sender{
    AppDelegate * appdelgate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    [appdelgate openSessionWithAllowLoginUI:1];
}

-(void) otherOptionButtonAction:(id)sender{
    if (!self.optionActionSheet) {
        self.optionActionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Sign into Taka",@"Create an account", nil];
    }
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
       
        [self.optionActionSheet showFromRect:[(UIButton *)sender frame] inView:self.view animated:YES ];
        
        
    }
    else{
            [self.optionActionSheet showInView:self.view];
    }
}
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString * checkNetwork=[[NSUserDefaults standardUserDefaults]objectForKey:@"NetworkStatus"];
    if (checkNetwork) {
        
       if (buttonIndex==0) {
        NSLog(@"Display Sign in");
        [self displaySignINViewController];
    }
    else if(buttonIndex == 1){
        NSLog(@"Display Sign Up Page");
        [self displaySignUpViewController];
    }
    }
}
-(void) displaySignINViewController{
    if (!self.signInViewController) {
        self.signInViewController = [[SignInViewController alloc] initWithNibName:@"SignInViewController" bundle:nil];
    }
    [self.navigationController pushViewController:self.signInViewController animated:YES];
}
-(void) displaySignUpViewController{
    if (!self.signUpViewController) {
        self.signUpViewController = [[SignUpViewController alloc] initWithNibName:@"SignUpViewController" bundle:nil];
    }
    [self.navigationController pushViewController:self.signUpViewController animated:YES];
}
@end
