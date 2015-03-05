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

@interface ViewController ()

@property(nonatomic,strong)SignUpViewController * signUpVC;
@end


@implementation ViewController


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
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
            self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"screen1_568.png"]];
        }
        else{
            self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"screen1_480.png"]];
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

@end
