//
//  ViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 08/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "ViewController.h"
#import "IntermediateViewController.h"
#import "AppDelegate.h"

#import  "CustomMenuViewController.h"
#import "EncountersViewController.h"
#import "PeopleNearByViewController.h"
#import "AddphotosViewController.h"
#import "FavoritViewController.h"
#import "AppDelegate.h"
#import "ActivationViewController.h"
#import "SingletonClass.h"
#import "SignUpViewController.h"
#import "SignInViewController.h"
#import "LikedYouViewController.h"

@interface ViewController ()

@property(nonatomic,strong)SignUpViewController * signUpVC;
@property(nonatomic,strong)SignInViewController * signInVC;
@end


@implementation ViewController


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
}

-(AppDelegate*)appdelegate{
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}
- (void)viewDidLoad
{
    
    
    
    [self getlocation];
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(afterLoginMoveToProfile) name:@"FacebookLogin" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(signupAction) name:@"signupAction" object:nil];
	// Do any additional setup after loading the view, typically from a nib.
    self.windowSize = [UIScreen mainScreen].bounds.size;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
                 self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"splashscreen.png"]];
        
    }
    else{
        if(self.windowSize.height>500)
        {
            NSLog(@"WindowSize %f",self.windowSize.height);
            self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"screen1_568.png"]];
        }
        else{
            NSLog(@"WindowSize %f",self.windowSize.height);

            self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"screen1_480.png"]];
        }
    
    [self createUI];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) createUI{
    CGSize windowSize=[UIScreen mainScreen].bounds.size;
    
    self.facebook_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.facebook_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.facebook_btn addTarget:self action:@selector(facebookBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.facebook_btn];
    //Add Other Option Button
    
    self.other_option_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.other_option_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.other_option_btn addTarget:self action:@selector(otherOptionBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.other_option_btn];
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        
        [self.facebook_btn setBackgroundImage:[UIImage imageNamed:@"fb_btn_ipad.png"] forState:UIControlStateNormal ];
        [self.other_option_btn setBackgroundImage:[UIImage imageNamed:@"otheroption_btn_ipad.png"] forState:UIControlStateNormal];
        self.facebook_btn.frame = CGRectMake(self.windowSize.width/2-150, self.windowSize.height - 300, 328, 62);
        self.other_option_btn.frame = CGRectMake(self.windowSize.width/2-150, self.windowSize.height - 205, 328, 62);
    }
    else{
        [self.facebook_btn setBackgroundImage:[UIImage imageNamed:@"fb_btn.png"] forState:UIControlStateNormal ];
        [self.other_option_btn setBackgroundImage:[UIImage imageNamed:@"otheroption_btn.png"] forState:UIControlStateNormal];
        self.other_option_btn.frame = CGRectMake(80, self.windowSize.height - 105, 167, 32);
        self.facebook_btn.frame = CGRectMake(80, self.windowSize.height - 155, 167, 32);
        
    }
    [self.facebook_btn setUserInteractionEnabled:YES];
    [self.other_option_btn setUserInteractionEnabled:YES];
    
  
    
    NSString * signIn=[[NSUserDefaults standardUserDefaults]objectForKey:@"signIn"];
    if ([signIn isEqualToString:@"YES"]) {
        
        [self.facebook_btn setUserInteractionEnabled:NO];
        [self.other_option_btn setUserInteractionEnabled:NO];
        [self SignInButtonAction];
        
    }

    
   
}
-(void)otherOptionBtnClicked{
    IntermediateViewController *intermediateViewController = [[IntermediateViewController alloc] initWithNibName:@"IntermediateViewController" bundle:nil];
    [self.navigationController pushViewController:intermediateViewController animated:YES];
}

-(void)facebookBtnClicked{
    AppDelegate * appdelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
  
    [appdelegate  openSessionWithAllowLoginUI:1];
   // BOOL fbConnect=[[NSUserDefaults standardUserDefaults]boolForKey:FacebookConnected];
   // if (fbConnect) {
        
    //    [self afterLoginMoveToProfile];
        
   // }
}


-(void)afterLoginMoveToProfile{
    [SingletonClass shareSingleton].facebookLog=YES;
    
    NSString * jibField=[NSString stringWithFormat:@"%@@takadating.com",[SingletonClass shareSingleton].userID];
    NSString * passwordField=@"123456";
    
    [self setField:jibField forKey:kXMPPmyJID];
    [self setField:passwordField forKey:kXMPPmyPassword];
    
    [[self appdelegate]connect];

    
    EncountersViewController *encounterViewController = [[EncountersViewController alloc] initWithNibName:@"EncountersViewController" bundle:nil];
    encounterViewController.title = @"Encounter";
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
    
    CustomMenuViewController *customMenuViewController = [[CustomMenuViewController alloc] init];
    customMenuViewController.numberOfSections = 2;
    customMenuViewController.viewControllers = @[profileNavigationController,nearByViewController,profileViewCopntroller];
    customMenuViewController.secondSectionViewControllers=@[messagesVC,visitorsVC,favorite];
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:customMenuViewController];
    navi.navigationBar.hidden = YES;
    
    customMenuViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:navi animated:YES completion:nil];

}


#pragma mark-

- (void)setField:(NSString *)field forKey:(NSString *)key
{
    if (field != nil)
    {
        [[NSUserDefaults standardUserDefaults] setObject:field forKey:key];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
}
-(void)signupAction{
    if (self.signUpVC) {
        self.signUpVC=nil;
    }
    self.signUpVC=[[SignUpViewController alloc]initWithNibName:@"SignUpViewController" bundle:nil];
    [self.navigationController pushViewController:self.signUpVC animated:YES];
}

#pragma mark-
-(void)getlocation
{
    // self.scorlView.hidden=YES;
    
    self.manager1=[[CLLocationManager alloc]init];
    self.manager1.delegate=self;
    self.manager1.desiredAccuracy=kCLLocationAccuracyBest;
    [self.manager1 startUpdatingLocation];
    self.longitude=[NSString stringWithFormat:@"%ff",self.manager1.location.coordinate.longitude];
    self.lattitude=[NSString stringWithFormat:@"%ff",self.manager1.location.coordinate.latitude];
    [SingletonClass shareSingleton].lattitude=self.lattitude;
    [SingletonClass shareSingleton].longitude=self.longitude;
    
    
    NSLog(@"longitude %.7f",self.manager1.location.coordinate.longitude);
    NSLog(@"lattitude %.7f",self.manager1.location.coordinate.latitude);
    
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation * curLocation=[locations objectAtIndex:0];
    [self.manager1 stopUpdatingLocation];
    
    
    CLGeocoder * coder=[[CLGeocoder alloc]init];
    [coder reverseGeocodeLocation:curLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if(error)
        {
            NSLog(@"Error in location finding %@",error);
        }
        else{
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            NSLog(@"\nCurrent Location Detected\n");
            NSLog(@"placemark %@",placemark);
            //NSLog(@"lattitude %.7f",locationMgr.location.coordinate.latitude );
            // NSLog(@"longitude %.7f",locationMgr.location.coordinate.longitude);
            
             self.Area = [[NSString alloc]initWithString:placemark.locality];
            NSString *Country = [[NSString alloc]initWithString:placemark.country];
              self.CountryArea = [NSString stringWithFormat:@"%@,%@", self.Area,Country];
            [SingletonClass shareSingleton].location=self.CountryArea;
           // self.CountryArea=@"Bhilai,India";
            NSLog(@"%@",self.CountryArea);
            
        }
    }];
    
}


-(void)SignInButtonAction{
    [SingletonClass shareSingleton].facebookLog=NO;
   
    NSString * checkNetwork=[[NSUserDefaults standardUserDefaults]objectForKey:@"NetworkStatus"];
    if (checkNetwork) {
        NSString * requestBody;
        NSString * signIn=[[NSUserDefaults standardUserDefaults]objectForKey:@"signIn"];
        if ([signIn isEqualToString:@"YES"]) {
            NSString * userName=[[NSUserDefaults standardUserDefaults]objectForKey:@"userEmail"];
            NSString * pass=[[NSUserDefaults standardUserDefaults]objectForKey:@"password"];
            [SingletonClass shareSingleton].emailID=userName;
            [SingletonClass shareSingleton].password=pass;
            requestBody=[NSString stringWithFormat:@"password=%@&userEmail=%@",pass,userName];
        }
       
        NSURL * url=[NSURL URLWithString:@"http://23.238.24.26/authentication/signin/"];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
        
        
        [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        [request setHTTPMethod:@"POST"];
        
        [request setHTTPBody:[requestBody dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
        
        [NSURLConnection connectionWithRequest:request delegate:self];
        
        
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
        [self getAllChatHistory];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"signIn"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
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
        
        LikedYouViewController *   likedYouVC =[[LikedYouViewController alloc]initWithNibName:@"LikedYouViewController" bundle:nil];
        likedYouVC.title=@"Liked you";
        
        CustomMenuViewController *customMenuViewController = [[CustomMenuViewController alloc] init];
        customMenuViewController.numberOfSections = 2;
        customMenuViewController.viewControllers = @[profileNavigationController,nearByViewController,profileViewCopntroller];
        customMenuViewController.secondSectionViewControllers=@[messagesVC,visitorsVC,favorite,likedYouVC];
        
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:customMenuViewController];
        navi.navigationBar.hidden = YES;
        
        
        
        customMenuViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:navi animated:YES completion:nil];
        
        [NSThread detachNewThreadSelector:@selector(getAllUpdatedInterests) toTarget:self withObject:nil];
        
        
    }
    
    
}
#pragma mark- get all Updated  User intrests.

-(void)getAllUpdatedInterests{
    [SingletonClass shareSingleton].selectedIntId=[[NSMutableArray alloc]init];
    [SingletonClass shareSingleton].selectedIntName=[[NSMutableArray alloc]init];
    
    NSError * error;
    NSURLResponse * urlResponse=nil;
    
    NSURL * postUrl=[NSURL URLWithString:@"http://23.238.24.26/user/get-full-user-interests"];
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:postUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSString * body=[NSString stringWithFormat:@"userId=%@",[SingletonClass shareSingleton].userID];
    [request setHTTPBody:[body dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (data==nil) {
        return;
    }
    id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"User interests %@ ",json);
    NSMutableDictionary * dict=[NSMutableDictionary dictionary];
    if ([[json objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
        NSArray *  interests=[json objectForKey:@"data"];
        for (int i=0; i<interests.count; i++) {
            dict=[interests objectAtIndex:i];
            [[SingletonClass shareSingleton].selectedIntName addObject:[dict objectForKey:@"intr_name"]];
            [[SingletonClass shareSingleton].selectedIntId addObject:[dict objectForKey:@"intr_id"]];
        }
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
    
    [SingletonClass shareSingleton].superPower=[[dict objectForKey:@"superpower"]intValue];
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

#pragma mark- getAllChat history
-(void)getAllChatHistory{
    NSError * error=nil;
    NSURLResponse * urlRsponse=nil;
    
    NSURL * postUrl=[NSURL URLWithString:@"http://23.238.24.26/chat/get-chat-data/"];
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:postUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50
                                   ];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSString * body=[NSString stringWithFormat:@"userId=%@",[SingletonClass shareSingleton].userID];
    [request setHTTPBody:[body dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlRsponse error:&error];
    if (data==nil) {
        return;
    }
    
    id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if ([[json objectForKey:@"code"]isEqualToNumber:[NSNumber numberWithInt:200]]) {
        NSArray * messages=[json objectForKey:@"data"];
        
        NSSortDescriptor * timeDescriptor=[[NSSortDescriptor alloc]initWithKey:@"sentDate" ascending:YES];
        NSArray * sortDescriptor=[NSArray arrayWithObject:timeDescriptor];
        
        [SingletonClass shareSingleton].sortedData=[messages sortedArrayUsingDescriptors:sortDescriptor];
        
        NSLog(@"Sorted messages %@",[SingletonClass shareSingleton].sortedData);
    }
}


@end
