//
//  SignInViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 08/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "SignInViewController.h"
#import  "CustomMenuViewController.h"
#import "EncountersViewController.h"
#import "PeopleNearByViewController.h"
#import "AddphotosViewController.h"
#import "FavoritViewController.h"
#import "AppDelegate.h"
#import "ActivationViewController.h"
#import "SingletonClass.h"
#import "LikedYouViewController.h"
#import "AFNHelper.h"



@interface SignInViewController ()
{
    ActivationViewController *activationVC;
    LikedYouViewController * likedYouVC;
}
@property(nonatomic,strong)AccountInfoViewController * account;
@property(nonatomic,strong)ProfileViewController * profileVC;
@property(nonatomic,strong)AddphotosViewController * addPhoto;


@end

@implementation SignInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
           }
    return self;
}

-(AppDelegate*)appdelegate{
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view from its nib.
    windowSize=[UIScreen mainScreen].bounds.size;
    self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, windowSize.width, 55);
    UIColor *firstColor = [UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
    UIColor *secColor = [UIColor colorWithRed:(CGFloat)121/255 green:(CGFloat)2/255 blue:(CGFloat)0/255 alpha:1.0];
    layer.colors = [NSArray arrayWithObjects:(id)[firstColor CGColor],(id)[secColor CGColor], nil];
    [self.view.layer insertSublayer:layer atIndex:0];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, windowSize.width-200, 35)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.text = @"SignIn";
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
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
         layer.frame = CGRectMake(0, 0, windowSize.width, 75);
        self.titleLabel.frame=CGRectMake(windowSize.width/2-100, 25, windowSize.width/2-200, 40);
        self.cancelButton.frame = CGRectMake(windowSize.width/2-350, 25, 120, 35);
        self.cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:30];
    }
    
    [self createUI];
    
}

-(void)signInRequest{
   
}

-(void)createUI{
    
   
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(20, 122, windowSize.width-40, windowSize.width-225);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    layer.borderWidth = 0.7;
    layer.borderColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)97/255 blue:(CGFloat)97/255 alpha:1.0].CGColor;
    [self.view.layer insertSublayer:layer atIndex:0];
    
    self.userLabel=[[UILabel alloc]init];
    //self.userLabel.frame=CGRectMake(30,130,30,25);
    
    self.userLabel.text=@"User";
    self.userLabel.font=[UIFont systemFontOfSize:12];
    self.userLabel.textAlignment=NSTextAlignmentLeft;
    self.userLabel.textColor=[UIColor grayColor];
    [self.view addSubview:self.userLabel];
    
    self.passwordLabel=[[UILabel alloc]init];
   // self.passwordLabel.frame=CGRectMake(30, 180, 60, 25);
   
    self.passwordLabel.text=@"Password";
    self.passwordLabel.font=[UIFont systemFontOfSize:12];
    self.passwordLabel.textAlignment=NSTextAlignmentLeft;
    self.passwordLabel.textColor=[UIColor grayColor];
    [self.view addSubview:self.passwordLabel];
    
    
    self.userText=[[UITextField alloc]init];
   // self.userText.frame=CGRectMake(120,130,150,25);
   
      self.userText.background=[UIImage imageNamed:@"signup_greyline.png"];
    self.userText.placeholder=@"  Email ";
   // self.userText.text=@"manjunath@globussoft.com";
    self.userText.delegate=self;
    self.userText.keyboardType=UIKeyboardTypeEmailAddress;
    self.userText.layer.borderColor=[[UIColor blackColor]CGColor];
    self.userText.font=[UIFont systemFontOfSize:12];
    self.userText.textAlignment=NSTextAlignmentCenter;
//    self.userText.layer.borderWidth=0.7;
//    self.userText.clipsToBounds=YES;
//    self.userText.layer.cornerRadius=4;
    [self.view addSubview:self.userText];
    
   // [SingletonClass shareSingleton].emailID=@"manjunath@globussoft.com";
    
    self.passwordText=[[UITextField alloc]init];
    //self.passwordText.frame=CGRectMake(120, 180, 150, 25);
    
    self.passwordText.background=[UIImage imageNamed:@"signup_greyline.png"];
    self.passwordText.placeholder=@"   Required";
    //self.passwordText.text=@"12345678";
    self.passwordText.delegate=self;
    self.passwordText.textAlignment=NSTextAlignmentCenter;
    self.passwordText.layer.borderColor=[[UIColor blackColor]CGColor];
    self.passwordText.font=[UIFont systemFontOfSize:12];
    self.passwordText.secureTextEntry=YES;
//    self.passwordText.layer.borderWidth=0.7;
//    self.passwordText.clipsToBounds=YES;
//    self.passwordText.layer.cornerRadius=4;
    [self.view addSubview:self.passwordText];
    
   
    UIColor *secColorfrgt = [UIColor colorWithRed:(CGFloat)199/255 green:(CGFloat)64/255 blue:(CGFloat)109/255 alpha:1.0];
    
    
    
    //Add signIn Button and forgot password button
    UIButton * signInButton=[UIButton buttonWithType:UIButtonTypeCustom];
    //signInButton.frame=CGRectMake(180, 220, 60, 25);
    [signInButton setTitle:@"Sign IN" forState:UIControlStateNormal];
    signInButton.titleLabel.font=[UIFont systemFontOfSize:13];
    [signInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //signInButton.backgroundColor=secColor;
    //[signInButton.layer insertSublayer:layer1 atIndex:0];
    signInButton.layer.cornerRadius=4;
    signInButton.clipsToBounds=YES;
    [signInButton addTarget:self action:@selector(SignInButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: signInButton];
    
    glayer=[CAGradientLayer layer];
    UIColor *firstColor = [UIColor colorWithRed:(CGFloat)139/255 green:(CGFloat)1/255 blue:(CGFloat)1/255 alpha:1.0];
    UIColor *secColor = [UIColor colorWithRed:(CGFloat)258/255 green:(CGFloat)5/255 blue:(CGFloat)6/255 alpha:1.0];
    glayer.colors = [NSArray arrayWithObjects:(id)[firstColor CGColor],(id)[secColor CGColor], nil];
    [signInButton.layer insertSublayer:glayer atIndex:0];

    
    
    UIButton * forgotPasswordBtn=[[UIButton alloc]init];
    //forgotPasswordBtn.frame= CGRectMake(35, 220, 130, 25);
   
    [forgotPasswordBtn setTitle:@" Forgot password ?" forState:UIControlStateNormal];
    [forgotPasswordBtn setTitleColor:secColorfrgt forState:UIControlStateNormal];
    forgotPasswordBtn.backgroundColor=[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    forgotPasswordBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    [forgotPasswordBtn addTarget:self action:@selector(forgotPasswordButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgotPasswordBtn];
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        blueLine=@"signup_blueline_ipad.png";
        grayLine=@"signup_greyline_ipad.png";
        layer.frame = CGRectMake(20, 150, windowSize.width-40, windowSize.width-500);
        self.userLabel.frame=CGRectMake(windowSize.width/2-250,windowSize.width/2-180,100,60);
        self.passwordLabel.frame=CGRectMake(windowSize.width/2-250, windowSize.width/2-70, 100, 60);
        self.userText.frame=CGRectMake(windowSize.width/2-100,windowSize.width/2-180,300,60);
        self.passwordText.frame=CGRectMake(windowSize.width/2-100, windowSize.width/2-70, 300, 60);
        signInButton.frame=CGRectMake(windowSize.width/2, windowSize.width/2+100, 180, 60);
        forgotPasswordBtn.frame= CGRectMake(windowSize.width/2-300, windowSize.width/2+100, 180, 60);
        
        glayer.frame=signInButton.bounds;
        
        self.userLabel.font=[UIFont boldSystemFontOfSize:18];
        self.passwordLabel.font=[UIFont boldSystemFontOfSize:18];
        self.userText.font=[UIFont systemFontOfSize:18];
        self.passwordText.font=[UIFont systemFontOfSize:18];
        
         self.userText.background=[UIImage imageNamed:@"signup_greyline_ipad.png"];
        self.passwordText.background=[UIImage imageNamed:@"signup_greyline_ipad.png"];
        signInButton.titleLabel.font=[UIFont systemFontOfSize:25];
        forgotPasswordBtn.titleLabel.font=[UIFont boldSystemFontOfSize:20];
    }
    else{
        blueLine=@"signup_blueline.png";
        grayLine=@"signup_greyline.png";
        self.userLabel.frame=CGRectMake(30,130,30,25);
        self.passwordLabel.frame=CGRectMake(30, 180, 60, 25);
        self.userText.frame=CGRectMake(120,130,150,25);
        self.passwordText.frame=CGRectMake(120, 180, 150, 25);
        signInButton.frame=CGRectMake(180, 220, 60, 25);
        forgotPasswordBtn.frame= CGRectMake(35, 220, 130, 25);
         glayer.frame=signInButton.bounds;
    }

}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    textField.background=[UIImage imageNamed:blueLine];
    return  YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (textField==self.userText) {
        [SingletonClass shareSingleton].emailID=self.userText.text;
    }
    textField.background=[UIImage imageNamed:grayLine];
    return  YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==self.userText) {
        [SingletonClass shareSingleton].emailID=self.userText.text;
    }
    [textField resignFirstResponder];
    return  YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*-(void)SignInButtonAction:(id)sender{
    
    
    
    [SingletonClass shareSingleton].facebookLog=NO;
   NSString * errorMessage=[self validationFunction];
    if(errorMessage)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:errorMessage delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
        return;
    }else{
        NSString * checkNetwork=[[NSUserDefaults standardUserDefaults]objectForKey:@"NetworkStatus"];
        if (checkNetwork) {

   NSError *error = nil;
    NSURLResponse *urlResponse=nil;
    
    NSString * urlstr=[NSString stringWithFormat:@"http://taka.dating/authentication/signin/%@/%@/",self.userText.text,self.passwordText.text];
    
     urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url=[NSURL URLWithString:urlstr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if(error)
    {
        NSLog(@"No data available %@",error);
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"The request timed out." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
    
    else{
        
     parse=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog( @"pars login %@",parse);
        NSNumber * code=[NSNumber numberWithInt:198];
         NSNumber * code1=[NSNumber numberWithInt:197];
        if([[parse objectForKey:@"code"] isEqualToNumber:code])
        {
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Not yet activated,do check your mail." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            
            [NSThread detachNewThreadSelector:@selector(accountActivationMethod) toTarget:self withObject:nil];

        }
       
        else if ([[parse objectForKey:@"code"] isEqualToNumber:code1])
        {
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Incorrect Username or password" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }
        else
        {
            
             [self getAllDataFromService];
            
               
           
            EncountersViewController *encounterViewController = [[EncountersViewController alloc] initWithNibName:@"EncountersViewController" bundle:nil];
            encounterViewController.title = @"Rendezvous";
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
            
            likedYouVC =[[LikedYouViewController alloc]initWithNibName:@"LikedYouViewController" bundle:nil];
            likedYouVC.title=@"Liked you";
            
            CustomMenuViewController *customMenuViewController = [[CustomMenuViewController alloc] init];
            customMenuViewController.numberOfSections = 2;
            customMenuViewController.viewControllers = @[profileNavigationController,nearByViewController,profileViewCopntroller];
            customMenuViewController.secondSectionViewControllers=@[messagesVC,visitorsVC,favorite,likedYouVC];
            
            UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:customMenuViewController];
            navi.navigationBar.hidden = YES;
            
            
            
            customMenuViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:navi animated:YES completion:nil];
            
        }
        
    }
        }
else{
            NSLog(@"No network");
        }
}
}
*/

-(void)SignInButtonAction:(UIButton*)sender{
    [SingletonClass shareSingleton].facebookLog=NO;
    NSString * errorMessage=[self validationFunction];
    if(errorMessage)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:errorMessage delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
        return;
    }else{
        NSString * checkNetwork=[[NSUserDefaults standardUserDefaults]objectForKey:@"NetworkStatus"];
        if (checkNetwork) {
            
            NSURL * url=[NSURL URLWithString:@"http://23.238.24.26/authentication/signin/"];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
           
            
            [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
            
            [request setHTTPMethod:@"POST"];
            
            [[NSUserDefaults standardUserDefaults]setObject:self.userText.text forKey:@"userEmail"];
           [[NSUserDefaults standardUserDefaults]setObject:self.passwordText.text forKey:@"password"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            NSString * requestBody=[NSString stringWithFormat:@"password=%@&userEmail=%@",self.passwordText.text,self.userText.text];
            [request setHTTPBody:[requestBody dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
            
            
            [NSURLConnection connectionWithRequest:request delegate:self];
            
        }
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    //Now you can do what you want with the response string from the data
    NSString* respsoneString = [NSString stringWithUTF8String:[responseData bytes]];
    NSLog(@"response string %@ -==-=-=-= ",respsoneString);
    
    NSError * error;
    parse=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
    
    
    if([[parse objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:198]])
    {
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Not yet activated,do check your mail." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        
        [NSThread detachNewThreadSelector:@selector(accountActivationMethod) toTarget:self withObject:nil];
        
    }
    
    else if ([[parse objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:197]])
    {
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Incorrect Username or password" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
    else
    {
        
        [self getAllDataFromService];
        
        NSString * jibField=[NSString stringWithFormat:@"%@@takadating.com",[SingletonClass shareSingleton].userID];
        NSString * passwordField=@"123456";
        
        [self setField:jibField forKey:kXMPPmyJID];
        [self setField:passwordField forKey:kXMPPmyPassword];
        
        [[self appdelegate]connect];
        
        EncountersViewController *encounterViewController = [[EncountersViewController alloc] initWithNibName:@"EncountersViewController" bundle:nil];
        encounterViewController.title = @"Rendezvous";
        ProfileViewController *profileViewCopntroller = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
        profileViewCopntroller.title = [SingletonClass shareSingleton].name;
        
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
        
        likedYouVC =[[LikedYouViewController alloc]initWithNibName:@"LikedYouViewController" bundle:nil];
        likedYouVC.title=@"Liked you";
        
        CustomMenuViewController *customMenuViewController = [[CustomMenuViewController alloc] init];
        customMenuViewController.numberOfSections = 2;
        customMenuViewController.viewControllers = @[profileNavigationController,nearByViewController,profileViewCopntroller];
        customMenuViewController.secondSectionViewControllers=@[messagesVC,visitorsVC,favorite,likedYouVC];
        
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:customMenuViewController];
        navi.navigationBar.hidden = YES;
        
        
        
        customMenuViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:navi animated:YES completion:nil];
        
    }
    

}

- (void)setField:(NSString *)field forKey:(NSString *)key
{
    if (field != nil)
    {
        [[NSUserDefaults standardUserDefaults] setObject:field forKey:key];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    //Do something if there is an error in the connection
    NSLog(@"Error -==- %@",error);
}

#pragma  mark- forgotpassword
-(void)forgotPasswordButtonAction:(id)sender{
    
    NSString * errorMessage=[self validationFunction];
    if(errorMessage)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:errorMessage delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
        return;
    }else{
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Forgot password " message:@"Password has been sent to your email." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        
        NSMutableDictionary * dictParm=[[NSMutableDictionary alloc]init];
        [dictParm setValue:self.userText.text  forKey:@"email"];
        
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
}

#pragma mark- getAllDataFromService

-(void)getAllDataFromService{
    NSLog(@"Parse in sign in %@",parse);
    NSDictionary * dict=[parse objectForKey:@"userdata"];
    NSString * loc=[dict objectForKey:@"location"];
    [SingletonClass shareSingleton].location=loc;
    
    NSString * name=[dict objectForKey:@"displayName"];
    [SingletonClass shareSingleton].name=name;
    
        [SingletonClass shareSingleton].bodyType=[NSString stringWithFormat:@"BodyType:%@",[self appearanceBodyType:[dict objectForKey:@"bodyType"]]];
   
    [SingletonClass shareSingleton].userID=[dict objectForKey:@"userId"];
    [[NSUserDefaults standardUserDefaults]setObject: [SingletonClass shareSingleton].userID forKey:@"userId"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [SingletonClass shareSingleton ].dob=[dict objectForKey:@"dob"];
    NSLog(@"UserID %@",[SingletonClass shareSingleton].userID);
   
        [SingletonClass shareSingleton].hairColor=[NSString stringWithFormat:@"HairColor:%@",[self appearanceHairColor:[dict objectForKey:@"hairColor"]]];
   
        [SingletonClass shareSingleton].eyeColor=[NSString stringWithFormat:@"EyeColor:%@",[self appearanceEyeColor:[dict objectForKey:@"eyeColor"]]];
       NSLog(@"eyecolor %@",[SingletonClass shareSingleton].eyeColor);
    
    
        [SingletonClass shareSingleton].income=[NSString stringWithFormat:@"Income:%@",[self appearanceIncome:[dict objectForKey:@"income"]]];
    
    
        [SingletonClass shareSingleton].height=[NSString stringWithFormat:@"Height:%@",[dict objectForKey:@"height"]];
   
    
        [SingletonClass shareSingleton].weight=[NSString stringWithFormat:@"Weight:%@",[dict objectForKey:@"weight"]];
    [SingletonClass shareSingleton].appearance=[NSString stringWithFormat:@"%@,%@,%@,%@,%@",[SingletonClass shareSingleton].height,[SingletonClass shareSingleton].weight,[SingletonClass shareSingleton].bodyType,[SingletonClass shareSingleton].hairColor,[SingletonClass shareSingleton].eyeColor];
    NSLog(@" appearance %@",[SingletonClass shareSingleton].appearance);
        [SingletonClass shareSingleton].Living=[NSString stringWithFormat:@"Living:%@",[self appearanceLving:[dict objectForKey:@"living"]]];
  
        [SingletonClass shareSingleton].children=[NSString stringWithFormat:@"Kids:%@",[self appearanceKids:[dict objectForKey:@"kids"]]];
   
        [SingletonClass shareSingleton].smoking=[NSString stringWithFormat:@"Smoking:%@",[self appearanceSmoking:[dict objectForKey:@"smoking"]]];
    
        [SingletonClass shareSingleton].dirinking=[NSString stringWithFormat:@"Drinking:%@",[self appearanceDrinking:[dict objectForKey:@"drinking"]]];
    
        [SingletonClass shareSingleton].education=[NSString stringWithFormat:@"Education:%@",[self appearanceEducation:[dict objectForKey:@"education"]]];
    
            [SingletonClass shareSingleton].relation=[NSString stringWithFormat:@"Relationship:%@",[self appearanceRelationShip:[dict objectForKey:@"relationshipStatus"]]];
    
    //    NSLog(@"Relation %@",[SingletonClass shareSingleton].relation);
    
    [SingletonClass shareSingleton].languages=[dict objectForKey:@"languagesKnown"];
    NSLog(@"Relation %@",[SingletonClass shareSingleton].languages);
        [SingletonClass shareSingleton].sexuality=[NSString stringWithFormat:@"sexuality:%@",[self appearancesexuality:[dict objectForKey:@"education"]]];
   
        [SingletonClass shareSingleton].profession=[NSString stringWithFormat:@"Profession:%@",[dict objectForKey:@"profession"]];
    
        [SingletonClass shareSingleton].aboutMe =[dict objectForKey:@"about"];
  
  
        [SingletonClass shareSingleton].hereFor =[[dict objectForKey:@"hereFor"] intValue];
   
    
         [SingletonClass shareSingleton].sex =[[dict objectForKey:@"sex"]intValue];
        
    
    
         [SingletonClass shareSingleton].interestedIn=[dict objectForKey:@"interestedIn"];
   // NSLog(@"interested in %@",[SingletonClass shareSingleton].interestedIn);
    //Profile setting data
    NSString * profileSetting=[dict objectForKey:@"profileSettings"];
   
    NSString *  data= [profileSetting stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    NSError * error=nil;

    NSData * Data=[NSData dataWithBytes:[data UTF8String] length:[data length]];
    NSDictionary * dataDict=[NSJSONSerialization JSONObjectWithData:Data options:NSJSONReadingMutableLeaves error:&error];
    if (error) {
        return;
    }
 
    
    NSDictionary * privacy=[dataDict objectForKey:@"privacy"];//privacy information
    NSLog(@"privacy %@", privacy);
    [SingletonClass shareSingleton].onlineStatus=[privacy objectForKey:@"onlineStatus"];
    [SingletonClass shareSingleton].distance=[privacy objectForKey:@"distance"];
    [SingletonClass shareSingleton].viewProfile=[privacy objectForKey:@"viewProfile"];
    [SingletonClass shareSingleton].browsing=[privacy objectForKey:@"browsing"];
     [SingletonClass shareSingleton].securityLevel=[privacy objectForKey:@"securityLevel"];
    [SingletonClass shareSingleton].publicSearch=[privacy objectForKey:@"publicSearch"];
     [SingletonClass shareSingleton].find=[privacy objectForKey:@"find"];
    
    NSDictionary * photosDict=[dataDict objectForKey:@"photos"];
    [SingletonClass shareSingleton].comment=[photosDict objectForKey:@"comment"];
    [SingletonClass shareSingleton].watermark_on=[photosDict objectForKey:@"watermark_on"];
    
    NSDictionary * languageDict=[dataDict objectForKey:@"language"];
    [SingletonClass shareSingleton].language=[languageDict objectForKey:@"language"];
    
    NSString * notification=[dict objectForKey:@"notifications"];
    
    NSString *  newNotification= [notification stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    
    
    NSData * notifyData=[NSData dataWithBytes:[newNotification UTF8String] length:[newNotification length]];
    NSDictionary * emailDict=[NSJSONSerialization JSONObjectWithData:notifyData options:NSJSONReadingMutableLeaves error:&error];
    NSDictionary * email=[emailDict objectForKey:@"Email"];
    NSDictionary * mobile=[emailDict objectForKey:@"Mobile"];
    if (error) {
        return;
    }

    [SingletonClass shareSingleton].newmsgEmail=[email objectForKey:@"newmsgEmail"];
    [SingletonClass shareSingleton].profvisitEmail=[email objectForKey:@"profvisitEmail"];
    [SingletonClass shareSingleton].alertEmail=[email objectForKey:@"alertEmail"];
    [SingletonClass shareSingleton].peopleEmail=[email objectForKey:@"peopleEmail"];
    [SingletonClass shareSingleton].newsEmail=[email objectForKey:@"newsEmail"];
    [SingletonClass shareSingleton].giftEmail=[email objectForKey:@"giftEmail"];
    [SingletonClass shareSingleton].rateEmail=[email objectForKey:@"rateEmail"];
    [SingletonClass shareSingleton].favEmail=[email objectForKey:@"favEmail"];
    
    // mobile data
    
    [SingletonClass shareSingleton].newmsgMobile=[mobile objectForKey:@"newmsgMobile"];
    [SingletonClass shareSingleton].profvisitMobile=[mobile objectForKey:@"profvisitMobile"];
    [SingletonClass shareSingleton].peopleMobile=[mobile objectForKey:@"peopleMobile"];
    [SingletonClass shareSingleton].alertMobile=[mobile objectForKey:@"alertMobile"];
    [SingletonClass shareSingleton].newsMobile=[mobile objectForKey:@"newsMobile"];
    [SingletonClass shareSingleton].giftMobile=[mobile objectForKey:@"giftMobile"];
    [SingletonClass shareSingleton].rateMobile=[mobile objectForKey:@"rateMobile"];
    [SingletonClass shareSingleton].favMobile=[mobile objectForKey:@"favMobile"];
    
 
    [SingletonClass shareSingleton].InvisibleModeSetting=[dict objectForKey:@"InvisibleModeSetting"];
    [SingletonClass shareSingleton].MessagesSetting=[dict objectForKey:@"MessagesSetting"];
    
    NSArray * imagesArr=[parse objectForKey:@"imagegallery"];
    if (imagesArr.count>0) {
    

    NSMutableDictionary * dictImges=[[NSMutableDictionary alloc]init];
    NSMutableArray * dictarr=[[NSMutableArray alloc]init];
    NSMutableArray * arr=[[ NSMutableArray alloc]init];

    for (int i=0; i<imagesArr.count; i++) {
        dict =[imagesArr objectAtIndex:i];
        if ([[dict objectForKey:@"privacy"]isEqualToString:@"3"]){
            NSString * imageName=[NSString stringWithString:[dict objectForKey:@"imageLink"]];
            [arr addObject:imageName];
            
        }
        else{
            [dictarr addObject:[dict objectForKey:@"imageLink"]];
            NSString * imageName=[NSString stringWithFormat:@"http://taka.dating%@",[dict objectForKey:@"imageLink"]];
            NSLog(@"image Name %@",imageName);
            [arr addObject:imageName];
        }
        
    }
        [SingletonClass shareSingleton].userImages =[[NSMutableArray alloc]initWithArray:arr];
}
    
    [SingletonClass shareSingleton].profileImg=[NSString stringWithFormat:@"http://taka.dating%@",[parse objectForKey:@"profileimg"]];
    
    
    NSLog(@"user profile images %@",[SingletonClass shareSingleton].userImages);
    [SingletonClass shareSingleton].profileImages=(NSArray*)imagesArr;
    
    //NSLog(@"location %@",[SingletonClass shareSingleton].location);
    // NSLog(@"userdat location %@",[[parse objectForKey:@"userdata"]objectForKey:@"location"]);
}

#pragma mark- validationFunction
    
-(NSString *)validationFunction{
    NSString * errmsg;
    NSString * regExpString=@"[^@]+@[A-Za-z0-9.-]+\\.[A-Za-z]+";
    NSRegularExpression * regExp=[[NSRegularExpression alloc]initWithPattern:regExpString options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger  regExpMatch=[regExp numberOfMatchesInString:self.userText.text options:0 range:NSMakeRange(0, [self.userText.text length])];
    if(regExpMatch==0)
    {
        errmsg=@"Please enter a valid email-Id.";
    }
    
    return errmsg;
}



#pragma mark- Appearence
-(NSString *)appearanceBodyType:(NSString *)value{
    NSString * bodyType=@"";
   
    int val= value.intValue;
    if (val==0) {
        bodyType=@"Unfilled yet";
    }
    else if(val==1)
    {
        bodyType=@"Average";
    }
    else if(val==2)
    {
        bodyType=@"A few extra pounds";
    }
    else if(val==3)
    {
        bodyType=@"Slim";
    }
    else if(val==4)
    {
        bodyType=@"Athletic";
    }
    else if(val==5)
    {
        bodyType=@"Muscular";
    }
    else
    {
        bodyType=@"Big and beautiful";
    }
       
    return bodyType;
}

-(NSString *)appearanceHairColor:(NSString *)value{
    NSString * hairColor=@"";
   
    int val= value.intValue;
    if (val==0) {
        hairColor=@"Unfilled yet";
    }
    else if(val==1)
    {
        hairColor=@"Black";
    }
    else if(val==2)
    {
        hairColor=@"Brown";
    }
    else if(val==3)
    {
        hairColor=@"Red";
    }
    else if(val==4)
    {
        hairColor=@"Grey";
    }
    else if(val==5)
    {
        hairColor=@"White";
    }
    else if(val==6)
    {
        hairColor=@"Shaved";
    }
    else if(val==7)
    {
        hairColor=@"Dyed";
    }
    else
    {
        hairColor=@"Bald";
    }
    
   
    return hairColor;

}
-(NSString *)appearanceKids:(NSString *)value{
    int val= value.intValue;
    NSString * kids=@"";
    if (val==0) {
        kids=@"Unfilled yet";
    }
    else if(val==1)
    {
        kids=@"No, Never";
    }
    else if(val==2)
    {
        kids=@"Someday";
    }
    else if(val==3)
    {
        kids=@"Already Have";
    }
    else
    {
        kids=@"Empty nest";
    }
    return kids;
}

-(NSString *)appearanceEyeColor:(NSString *)value{
    NSString * eyeColor=@"";
    
    int val= value.intValue;
    if (val==0) {
        eyeColor=@"others";
    }
    else if(val==1)
    {
        eyeColor=@"Brown";
    }
    else if(val==2)
    {
        eyeColor=@"Grey";
    }
    else if(val==3)
    {
        eyeColor=@"Green";
    }
    else if(val==4)
    {
        eyeColor=@"Blue";
    }
    else if(val==5)
    {
        eyeColor=@"Hazel";
    }
    else
    {
        eyeColor=@"Other";
    }
   
    return eyeColor;
    
}
-(NSString *)appearanceIncome:(NSString *)value{
    int val=value.intValue;
    NSString * income=@"";
    if (val==0) {
        income=@"Unfilled yet";
    }
    else if(val==1)
    {
        income=@"Low";
    }
    else if(val==2)
    {
        income=@"Average";
    }
    else
    {
        income=@"High";
    }
    return  income;
}

-(NSString *)appearanceLving:(NSString *)value{
    NSString * living=@"";
    int val= value.intValue;
    if (val==0) {
        living=@"Unfilled yet";
    }
    else if(val==1)
    {
        living=@"With Parents";
    }
    else if(val==2)
    {
        living=@"With Roomates";
    }
    else if(val==3)
    {
        living=@"Student Residence";
    }
    else if(val==4)
    {
        living=@"With Partner";
    }
    else{
        living=@"Alone";
    }
    return  living;
}
-(NSString *)appearanceSmoking:(NSString *)value{
    int val= value.intValue;
    NSString * smoking=@"";
    if (val==0) {
        smoking=@"Unfilled yet";
    }
    else if (val==1){
        smoking=@"No";
    }
    else if (val==2)
    {
        smoking=@"No, Never";
    }
    else if (val==3)
    {
        smoking=@"Yes";
    }
    else if (val==4)
    {
        smoking=@"Social";
    }
    else
    {
        smoking=@"Chain Smoker, Oxygen is overrated";
    }
    
    return smoking;
}

-(NSString *)appearanceDrinking:(NSString *)value{
    int val=value.intValue;
    NSString * drinking=@"";
    if (val==0) {
        drinking=@"Unfilled yet";
        
    }
    else if (val==1)
    {
        drinking=@"No";
        
    }
    else if (val==3)
    {
        drinking=@"With Company";
    }
    else if(val==2){
        drinking=@"No, Never";
    }
    else{
        drinking=@"Yes, Please";
    }
    return drinking;
}

-(NSString *)appearanceEducation:(NSString *)value{
    int val=value.intValue;
    NSString * edu=@"";
    if (val==0) {
        edu=@"Unfilled yet";
        
    }
    else if (val==1)
    {
        edu=@"School only";
        
    }
    else if (val==3)
    {
        edu=@"Trade/Technical";
    }
    else if(val==2){
        edu=@"College/University";
    }
    else{
        edu=@"Advanced Degree";
    }
    return edu;
}
-(NSString *)appearanceRelationShip:(NSString *)value{
    int val=value.intValue;
    NSString * relation=@"";
    if (val==0) {
        relation=@"Unfilled yet";
        
    }
    else if (val==1)
    {
        relation=@"Single";
        
    }
    else if (val==3)
    {
        relation=@"Taken";
    }
    else{
        relation=@"Open";
    }
    return relation;
}

-(NSString * )appearancesexuality:(NSString *)value
{
    int val=value.intValue;
    NSString * sex=@"";
    if (val==0) {
        sex=@"Unfilled yet";
        
    }
    else if (val==1)
    {
        sex=@"Straight";
        
    }
    else if (val==3)
    {
        sex=@"Bisexual";
    }
    else if(val==2){
        sex=@"Open Minded";
    }
    else if(val==4){
        sex=@"Gay";
    }
    else{
        sex=@"Lesbian";
    }
    return sex;

}
/*
-(NSString *)appearanceProfession:(NSString *)value{
    
    int val=value.intValue;
    NSString * sex=@"";
    if (val==0) {
        sex=@"No,Answer";
        
    }
    else if (val==1)
    {
        sex=@"Straight";
        
    }
    else if (val==3)
    {
        sex=@"Bisexual";
    }
    else if(val==2){
        sex=@"Open-minded";
    }
    else{
        sex=@"Gay";
    }
    return sex;
}*/
#pragma mark-
-(void)cancelButtonAction:(id)sender{
     [self.refreshActivityIndicator stopAnimating];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark-alert view delegate maethod
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
       /**/
        
       
        [self.refreshActivityIndicator stopAnimating];
    }
}

#pragma mark- accountActivationMethod
-(void)accountActivationMethod{
   
    
    NSString * postUrl=@"http://taka.dating/resend-activation";
    
    AFNHelper * afn=[[AFNHelper alloc]init];
    
    NSMutableDictionary * dictParm=[[NSMutableDictionary alloc]init];
    [dictParm setObject:self.userText.text forKey:@"email"];
    
    
    [afn getDataFromPath:postUrl withParamData:dictParm withBlock:^(id response, NSError *error) {
        if (error) {
            NSLog(@"Failed to resend activation");
        }
        else{
            NSLog(@"Successfull");
        }
    }];
}
@end
