//
//  ProfileViewController.m
//  TakaDating
//
//  Created by GBS-ios on 11/10/14.
//  Copyright (c) 2014 Globussoft. All rights reserved.
//

#import "UserDetailsViewController.h"
#import "ProfileViewController.h"
#import "SettingViewController.h"
#import "InterestViewController.h"
#import "ApperrenceViewController.h"
#import "RelationshipViewController.h"
#import "AppDelegate.h"
#import "AboutMeViewController.h"
#import "WorkAsViewController.h"
#import "PhotoViewController.h"
#import "SingletonClass.h"
#import  "UIImageView+WebCache.h"
#import  "InetrestedINViewController.h"
#import "ISpeakLanguageViewController.h"
#import "AwardSectionViewController.h"




@interface ProfileViewController ()
{
    AppDelegate *appdelegate ;
    UIImageView * profileImg;
    PhotoViewController * photoVC;
    ISpeakLanguageViewController *  labguages;
    AwardSectionViewController * awardVC;
    RefillCreditsViewController * creditsVC;
}
@property(nonatomic,strong)SettingViewController * settingVC;
@property(nonatomic,strong)InterestViewController * interestVC;
@property(nonatomic,strong)ApperrenceViewController * apperenceVC;
@property(nonatomic,strong)RelationshipViewController * relationVC;
@property(nonatomic,strong)AboutMeViewController * aboutMeVC;
@property(nonatomic,strong)WorkAsViewController * workasVC;
@property(nonatomic,strong)InetrestedINViewController * interestedIn;

@end

@implementation ProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillAppear:(BOOL)animated{
    if (self.secondView.hidden==NO) {
        if(self.profileTableView.hidden==NO)
        {
            [self.profileTableView reloadData];
           // [[NSNotificationCenter defaultCenter]removeObserver:self name:@"AboutMe" object:nil];
        }
        if (self.creditsTableView.hidden==NO) {
            [self.creditsTableView reloadData];
        }
    }
    if (viewAppear==NO) {
        [self createScrollUI];
        viewAppear=YES;
    }
    
    
}
- (void)viewDidLoad
{
    windowSize=[UIScreen mainScreen].bounds.size;
    [super viewDidLoad];
     appdelegate = [UIApplication sharedApplication].delegate;
    self.selectedIndex=0;
    facebookVerify=YES;
    self.sectionTwoData=[NSArray arrayWithObjects:@"Location",@"About Me",@"Interested In",@"Relationship",@"Sexuality",@"Appearence",@"Living",@"Children",@"Smoking",@"Drinking",@"Education",@"I Speak",@"I Work as", nil];
    
    
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        row_hh=80;
        credts_hh=400;
        font_size=25;
        self.sectionTwoImages=[NSArray arrayWithObjects:@"location_ipad.png",@"about_me_ipad.png",@"interested_in_ipad.png",@"relationship_ipad.png",@"sexuality_ipad.png",@"apperance_ipad.png",@"living_ipad.png",@"kids_ipad.png",@"smoking_ipad.png",@"drinking_ipad.png",@"education_ipad.png",@"language_ipad.png",@"work_ipad.png", nil];
         self.awardImages=[NSArray arrayWithObjects:@"award_1_iPad.png",@"award_3_iPad.png",@"award_2_interest_iPad.png",@"award_4_iPad.png",@"award_5_iPad.png", nil];
    }
    else{
        row_hh=40;
        credts_hh=250;
        font_size=12;
        self.sectionTwoImages=[NSArray arrayWithObjects:@"location.png",@"about_me.png",@"add_interest.png",@"relationship.png",@"sexuality.png",@"apperance.png",@"living.png",@"kids.png",@"smoking.png",@"drinking.png",@"education.png",@"language.png",@"work.png", nil];
        self.awardImages=[NSArray arrayWithObjects:@"award_1.png",@"award_3.png",@"award_2_interest.png",@"award_4.png",@"award_5.png", nil];
    }
    
    // Do any additional setup after loading the view from its nib.
    //-----
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tableReloadAction) name:@"AboutMe" object:nil];
    [self createUI];
    
   
  
}





-(void)tableReloadAction{
    if (self.secondView.hidden==NO) {
        if (self.profileTableView.hidden==NO) {
            [self.profileTableView reloadData];
        }
    }
    //[[NSNotificationCenter defaultCenter]removeObserver:self name:@"AboutMe" object:nil];
}




#pragma mark-creatUI
-(void)createUI{
    
     self.screen_width=[UIScreen mainScreen].bounds.size.width;
    if(!self.parentView)
    {
        self.parentView=[[UIView alloc]init];
        self.parentView.frame=[UIScreen mainScreen].bounds;
        
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            self.parentView.frame=CGRectMake(0, 0, windowSize.width, windowSize.height-25);
           // self.parentView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"profile_screen_bg_ipad.png"]];
        }
        else{
            if ([UIScreen mainScreen].bounds.size.height>500) {
                self.parentView.frame=CGRectMake(0, 0, windowSize.width, self.view.frame.size.height);
            }
            else{
                self.parentView.frame=CGRectMake(0, 0, windowSize.width, self.view.frame.size.height-80);
            }
           // self.parentView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"profile_screen_bg.png"]];
        }
        CAGradientLayer *layer = [CAGradientLayer layer];
        layer.frame = self.parentView.bounds;
        UIColor *firstColor = [UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)88/255 blue:(CGFloat)211/255 alpha:1.0];
        UIColor *secColor = [UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)0/255 blue:(CGFloat)50/255 alpha:1.0];
        
        layer.colors = [NSArray arrayWithObjects:(id)[firstColor CGColor],(id)[secColor CGColor], nil];
        [self.parentView.layer insertSublayer:layer atIndex:0];

        
        [self.view addSubview:self.parentView];
       
        
    }
    self.parentView.hidden=NO;
    
    

    
    if(!self.tabView)
    {
        self.tabView=[[UIView alloc]init];
        self.tabView.backgroundColor=[UIColor clearColor];
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            self.tabView.frame=CGRectMake(0, self.parentView.frame.size.height-130, windowSize.width, 80);
        }
        else{
            if([UIScreen mainScreen].bounds.size.height>500)
            {
                self.tabView.frame=CGRectMake(0, 465, 320, 50);
            }
            else{
                self.tabView.frame=CGRectMake(0, 375, 320, 50);
                }
            }
        
        //self.tabView.backgroundColor=[UIColor blackColor];
            [self.parentView addSubview:self.tabView];
        CAGradientLayer * tabLayer=[CAGradientLayer layer];
        tabLayer.frame=CGRectMake(0, 0, self.tabView.frame.size.width, self.tabView.frame.size.height);
        UIColor * firstColor=[UIColor colorWithRed:(CGFloat)38/255 green:(CGFloat)38/255 blue:(CGFloat)38/255 alpha:1.0];
        UIColor  * secondColor=[UIColor colorWithRed:(CGFloat)0/255 green:(CGFloat)0/255 blue:(CGFloat)0/255 alpha:1.0];
        tabLayer.colors=[NSArray arrayWithObjects:(id)[firstColor CGColor],(id)[secondColor CGColor], nil];
        [self.tabView.layer insertSublayer:tabLayer atIndex:0];

    }
    self.tabView.hidden=YES;
    
    self.swipe=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeGesture:)];
    self.swipe.direction=UISwipeGestureRecognizerDirectionUp;
    [self.parentView addGestureRecognizer:self.swipe];

    
    
    UIButton * profile=[[UIButton alloc]init];
    
    //[profile setTitle:@"Profile" forState:UIControlStateNormal];
    [profile setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    profile.titleLabel.font=[UIFont systemFontOfSize:12];
    profile.layer.cornerRadius=4;
    profile.clipsToBounds=YES;
    profile.tag=1;
    [profile setImage:[UIImage imageNamed:@"profile_male_grey.png"] forState:UIControlStateNormal];
    [profile addTarget:self action:@selector(profileButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabView addSubview:profile];
            
        UIButton * photosBtn=[UIButton buttonWithType:UIButtonTypeCustom];
       // [photosBtn setTitle:@"photos" forState:UIControlStateNormal];
    
        photosBtn.titleLabel.font=[UIFont boldSystemFontOfSize:9];
    [photosBtn setImage:[UIImage imageNamed:@"photo_icon_grey.png"] forState:UIControlStateNormal];
        [photosBtn addTarget:self action:@selector(photoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    photosBtn.tag=2;
        [self.tabView addSubview:photosBtn];
        
        UIButton * CreditsBtn=[UIButton buttonWithType:UIButtonTypeCustom];
       // [CreditsBtn setTitle:@"Credits" forState:UIControlStateNormal];
    
        CreditsBtn.titleLabel.font=[UIFont boldSystemFontOfSize:9];
        [CreditsBtn setImage:[UIImage imageNamed:@"credit_icon_grey.png"] forState:UIControlStateNormal];
        CreditsBtn.tag=3;
        [CreditsBtn addTarget:self action:@selector(creditsButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.tabView addSubview:CreditsBtn];
        
        UIButton * OffBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        //[OffBtn setTitle:@"Off" forState:UIControlStateNormal];
    
        OffBtn.titleLabel.font=[UIFont boldSystemFontOfSize:9];
        [OffBtn setImage:[UIImage imageNamed:@"off_icon_grey.png"] forState:UIControlStateNormal];
        OffBtn.tag=4;
        [OffBtn addTarget:self action:@selector(superPowerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabView addSubview:OffBtn];
    

    self.tabView.hidden=NO;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        
         [profile setImage:[UIImage imageNamed:@"profile_male_grey_ipad.png"] forState:UIControlStateNormal];
        
         [photosBtn setImage:[UIImage imageNamed:@"photo_icon_grey_ipad.png"] forState:UIControlStateNormal];
        [CreditsBtn setImage:[UIImage imageNamed:@"credit_icon_grey_ipad.png"] forState:UIControlStateNormal];
        [OffBtn setImage:[UIImage imageNamed:@"off_icon_grey_ipad.png"] forState:UIControlStateNormal];

        
        profile.frame=CGRectMake(windowSize.width-700, 10, 60, 50);
        photosBtn.frame=CGRectMake(windowSize.width-500, 10, 50, 50);
        CreditsBtn.frame=CGRectMake(windowSize.width-300, 10, 50, 50);
        OffBtn.frame=CGRectMake(windowSize.width-100, 10, 50, 50);
    }
    else{
        profile.frame=CGRectMake(windowSize.width-310, 10, 60, 30);
        photosBtn.frame=CGRectMake(windowSize.width-225, 10, 50, 30);
        CreditsBtn.frame=CGRectMake(windowSize.width-135, 10, 50, 30);
        OffBtn.frame=CGRectMake(windowSize.width-55, 10, 50, 30);
        
    }
    
    
}

#pragma mark-scrollImageView

-(void)createScrollUI{
    
    NSString *online;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        
        imageScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.parentView.frame.size.width, self.parentView.frame.size.height-150)];
        online=@"online_icon_ipad.png";
    }
    else{
        online=@"online_icon.png";
        if ([UIScreen mainScreen].bounds.size.height>500) {

            imageScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.parentView.frame.size.width, self.parentView.frame.size.height-100)];
        }
        else{
            imageScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.parentView.frame.size.width, self.parentView.frame.size.height-150)];
            }
    }

    imageScroll.pagingEnabled=YES;
    imageScroll.delegate=self;
    [imageScroll setShowsHorizontalScrollIndicator:NO];
    [self.parentView addSubview:imageScroll];
   // NSArray * arrOfImages=[NSArray arrayWithArray:[SingletonClass shareSingleton].userImages];
    NSMutableArray * arrOfImages=[[NSMutableArray alloc]init];
     NSString * imageUrl;
    
    //NSLog(@"arr count %lu",(unsigned long)[SingletonClass shareSingleton].profileImages.count);
    if([SingletonClass shareSingleton].profileImages){
    for (int s=0; s<[SingletonClass shareSingleton].profileImages.count; s++) {
        NSMutableDictionary * dict=[[SingletonClass shareSingleton].profileImages objectAtIndex:s];
     
            
            if ([[dict objectForKey:@"privacy"]isEqualToString:@"3"]) {
                imageUrl=[NSString stringWithString:[dict objectForKey:@"imageLink"]];
            }
            else{
                imageUrl=[NSString stringWithFormat:@"http://taka.dating/%@",[dict objectForKey:@"imageLink"]];
            }
            [arrOfImages addObject:imageUrl];
        }

    
   
    for (int i=0; i<arrOfImages.count; i++) {
        
         CGFloat x = i * self.view.frame.size.width;
        profileImg=[[UIImageView alloc]init];
        if ([UIScreen mainScreen].bounds.size.height<500) {
            profileImg.frame=CGRectMake(x, 0, imageScroll.frame.size.width, imageScroll.frame.size.height);
        }
        else{
        profileImg.frame=CGRectMake(x, 0, imageScroll.frame.size.width, imageScroll.frame.size.height);
        }
        profileImg.userInteractionEnabled=YES;
       NSURL * url =[NSURL URLWithString:[arrOfImages objectAtIndex:i]];
        //NSURL * url =[NSURL URLWithString:imageUrl];
        [profileImg setImageWithURL:url];
        [imageScroll addSubview:profileImg];
    }
    }
    imageScroll.contentSize=CGSizeMake(imageScroll.frame.size.width*arrOfImages.count, imageScroll.frame.size.height);
    [self.parentView addSubview:imageScroll];
    
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(10, 20, 70, 25)];
    view.backgroundColor=[UIColor grayColor];
    view.layer.cornerRadius=5;
    view.clipsToBounds=YES;
    if ([SingletonClass shareSingleton].profileImages.count==0) {
        view.hidden=YES;
    }
    else{
        view.hidden=NO;
    }
    [self.parentView addSubview:view];
    
    UIImageView * imgVw=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 15)];
    imgVw.image=[UIImage imageNamed:@"photo_icon.png"];
    [view addSubview:imgVw];
    
   imageCount=[[UILabel alloc]initWithFrame:CGRectMake(40, 20, 50, 25)];
    imageCount.textColor=[UIColor whiteColor];
    imageCount.font=[UIFont systemFontOfSize:12];
    if ([SingletonClass shareSingleton].profileImages.count==0) {
        imageCount.hidden=YES;
    }
    else{
     imageCount.text=[NSString stringWithFormat:@"1/%lu",(unsigned long)[SingletonClass shareSingleton].profileImages.count];
    }
    [self.parentView addSubview:imageCount];
    
    isOnline=[[UIImageView alloc]init];
    isOnline.image=[UIImage imageNamed:online];
    [self.parentView addSubview:isOnline];
    UILabel *  ProfileName=[[UILabel alloc]init];
    
    if ([UIScreen mainScreen].bounds.size.height<500) {
        ProfileName.frame=CGRectMake(40, self.parentView.frame.size.height-220, self.parentView.frame.size.width-150, 30);
        isOnline.frame=CGRectMake(10, self.parentView.frame.size.height-220, 30, 30);
    }
    else{
        ProfileName.frame=CGRectMake(40, self.parentView.frame.size.height-180, 200, 30);
        isOnline.frame=CGRectMake(10, self.parentView.frame.size.height-180, 30, 30);
    }
    ProfileName.textColor=[UIColor blackColor];
    ProfileName.text=[SingletonClass shareSingleton].name;
    [self.parentView addSubview:ProfileName];
    
    UILabel *  tagLine=[[UILabel alloc]init];
    if ([UIScreen mainScreen].bounds.size.height<500) {
        tagLine.frame=CGRectMake(40, self.parentView.frame.size.height-200, self.parentView.frame.size.width, 30);
    }
    else{
    tagLine.frame=CGRectMake(40, self.parentView.frame.size.height-160, 230, 30);
    }
    tagLine.textColor=[UIColor blackColor];
    NSString * str;
    if ([SingletonClass shareSingleton].hereFor==0) {
        
        str=@"I'am here to make new firends";
    }
    else if([SingletonClass shareSingleton].hereFor==1){
        
        if ([SingletonClass shareSingleton].with==0) {
            str=@"I'am here to chat with guys";
        }
        else if ([SingletonClass shareSingleton].with==1)
        {
            str=@"I'am here to chat with girls";
        }
        else{
            str=@"I'am here to chat with both";
        }
    }
    else{
        if ([SingletonClass shareSingleton].with==0) {
            str=@"I'am here to date with guys";
        }
        else if ([SingletonClass shareSingleton].with==1)
        {
            str=@"I'am here to date with girls";
        }
        else{
            str=@"I'am here to date with both";
        }
        
    }
    tagLine.text=str;

    [self.parentView addSubview:tagLine];

    
}


#pragma mark- scroll delegate methods

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
   
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    page=page+1;
    if ([SingletonClass shareSingleton].profileImages.count==0) {
        imageCount.hidden=YES;
    }
    else{
    imageCount.text=[NSString stringWithFormat:@"%d/%lu",page,(unsigned long)[SingletonClass shareSingleton].profileImages.count];
    }
    NSLog(@"Scrolling - You are now on page %i",page);
}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *) targetContentOffset
NS_AVAILABLE_IOS(5_0){
    
   
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    NSLog(@"Dragging - You are now on page %i",page);
    
}


#pragma mark- gesutre recognizer

-(void)handleSwipeGesture:(UISwipeGestureRecognizer *)swipe{
    
    NSLog(@"%f",self.parentView.frame.origin.y);
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        CGRect frame=CGRectMake(0, -windowSize.width/2, windowSize.width, windowSize.height);
        [self swipeGesture:frame];
    }
    else{
        CGRect frame=CGRectMake(0, -300, windowSize.width, windowSize.height);
        [self swipeGesture:frame];
       }
   
}

-(void)swipeGesture:(CGRect)frame{
    if(self.parentView.frame.origin.y==0)
    {
        [NSThread detachNewThreadSelector:@selector(showAwards) toTarget:self withObject:nil];
        [UIView animateWithDuration:0.5 animations:^{
            
            if ([UIScreen mainScreen].bounds.size.height>500) {
                
               // self.parentView.frame=CGRectMake(0, -300, windowSize.width, windowSize.height);
                self.parentView.frame=frame;
            }
            else{
                //self.parentView.frame=CGRectMake(0, -300, windowSize.width, windowSize.height);
                self.parentView.frame=frame;
            }
        } completion:^(BOOL finished) {
            CGRect ff;
            if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
                ff=CGRectMake(0, windowSize.height/2+55, windowSize.width,(windowSize.height-windowSize.height/2-80));
            }
            else{
           
            if ([UIScreen mainScreen].bounds.size.height>500) {
                ff=CGRectMake(0, 220, windowSize.width, 300);
            }
            else{
                ff=CGRectMake(0, 125, windowSize.width, 450);
            }
            }
            int tagValue=1;
            self.selectedIndex=0;
            self.state=YES;
            [self createTableView:ff tagvalue: tagValue];
            self.swipe.direction = UISwipeGestureRecognizerDirectionDown;
        }];
    }
    else{
        
        [UIView animateWithDuration:0.5 animations:^{
            self.parentView.frame=CGRectMake(0,0 ,self.screen_width, self.view.frame.size.height);
            self.secondView.hidden=YES;
        } completion:^(BOOL finished) {
            self.swipe.direction=UISwipeGestureRecognizerDirectionUp;
            self.state=NO;
        }];
    }

}

#pragma mark-TableView Creation
-(void)createTableView:(CGRect)frame tagvalue:(int) tagvalue{
    
    if(self.secondView)
    {
        self.secondView=nil;
    }
    self.secondView=[[UIView alloc]initWithFrame:frame];
    self.secondView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:self.secondView];
    
    if (tagvalue==1) {
        self.creditsTableView=nil;
        if(self.profileTableView)
        {
            self.profileTableView=nil;
        }
        self.profileTableView=[[UITableView alloc]init];
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            self.profileTableView.frame=CGRectMake(0, 0, self.secondView.frame.size.width, self.secondView.frame.size.height);
        }
        else{
               if ([UIScreen mainScreen].bounds.size.height<500) {
            self.profileTableView.frame=CGRectMake(0, 0, self.secondView.frame.size.width, self.secondView.frame.size.height-150);
        }
        else {
            self.profileTableView.frame=CGRectMake(0, 0, self.secondView.frame.size.width, self.secondView.frame.size.height);
            }
        }
        self.profileTableView.delegate=self;
        self.profileTableView.dataSource=self;
        self.profileTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        self.profileTableView.estimatedRowHeight=70;
        self.profileTableView.rowHeight=UITableViewAutomaticDimension;
        self.profileTableView.backgroundColor=[UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)148/255 blue:(CGFloat)214/255 alpha:1.0];

        [self.profileTableView setShowsVerticalScrollIndicator:NO];
        [self.secondView addSubview:self.profileTableView];
        
    }
    else if (tagvalue==3)
    {
        self.profileTableView=nil;
        if(self.creditsTableView)
        {
            self.creditsTableView=nil;
        }
        self.creditsTableView=[[UITableView alloc]init];
        
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            self.creditsTableView.frame=CGRectMake(0, 0, self.secondView.frame.size.width, self.secondView.frame.size.height);
        }
        else{
        
        if ([UIScreen mainScreen].bounds.size.height<500) {
            self.creditsTableView.frame=CGRectMake(0, 0, self.secondView.frame.size.width, self.secondView.frame.size.height);
        }
        else{
        self.creditsTableView.frame=CGRectMake(0, 0, self.secondView.frame.size.width, self.secondView.frame.size.height-80);
        }
    }
        self.creditsTableView.delegate=self;
        self.creditsTableView.dataSource=self;
        self.creditsTableView.backgroundColor=[UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)148/255 blue:(CGFloat)214/255 alpha:1.0];
          [self.creditsTableView setShowsVerticalScrollIndicator:NO];
        [self.secondView addSubview:self.creditsTableView];
        
    }
}

#pragma mark- show all Awards 

-(void)showAwards{
    
    
    //Activate Aeards here
    NSError* error=nil;
    NSURLResponse * urlResponse=nil;
    NSString * firstRun=[[NSUserDefaults standardUserDefaults]objectForKey:@"profileFirstRun"];
    if (!firstRun) {
       
        NSURL * postUrl=[NSURL URLWithString:@"http://23.238.24.26/award/activate-awards/"];
        
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
        if ([[json objectForKey:@"code"]isEqualToNumber:[NSNumber numberWithInt:200]]|| [[json objectForKey:@"code"]isEqualToNumber:[NSNumber numberWithInt:197]]) {
            [self getAllAwards];
            [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"profileFirstRun"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
        
        
        
       
    }
    else
    {
        [self getAllAwards];
    }
}

#pragma mark- get All Awards

-(void)getAllAwards{

    // check Awards
    NSError* error=nil;
    NSURLResponse * urlResponse=nil;
    
    NSURL * postUrl=[NSURL URLWithString:@"http://23.238.24.26/award/show-awards/"];
    
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
    NSLog(@"Award %@",json);
    NSMutableDictionary * dict=[NSMutableDictionary dictionary];
    dict=[json objectForKey:@"awards"];
    if ([[dict objectForKey:@"2"] isEqualToString:@"1"]) {
        
        [SingletonClass shareSingleton].likesAward=YES;
    }
    else{
         [SingletonClass shareSingleton].likesAward=NO;
    }
    
     if ([[dict objectForKey:@"3"] isEqualToString:@"1"]) {
        [SingletonClass shareSingleton].userLikesAward=YES;
    }
     else{
         [SingletonClass shareSingleton].userLikesAward=NO;
     }
    
    if ([[dict objectForKey:@"4"] isEqualToString:@"1"]) {
        [SingletonClass shareSingleton].interestAward=YES;
    }
    else{
        [SingletonClass shareSingleton].interestAward=NO;
    }
    
    if ([[dict objectForKey:@"5"] isEqualToString:@"1"]) {
        
        [SingletonClass shareSingleton].visitorAward=YES;
    }
    else{
        [SingletonClass shareSingleton].visitorAward=NO;
    }
    
   if ([[dict objectForKey:@"6"] isEqualToString:@"1"]) {
        [SingletonClass shareSingleton].viewsAward=YES;
    }
   else{
        [SingletonClass shareSingleton].viewsAward=NO;
   }
    
}


#pragma mark- profile button action

-(void)profileButtonClick:(UIButton*)sender{
    [NSThread detachNewThreadSelector:@selector(showAwards) toTarget:self withObject:nil];
    [NSThread detachNewThreadSelector:@selector(getUserinterests) toTarget:self withObject:nil];
    int tagValue=(int)[sender tag];
    CGRect frame;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
       frame=CGRectMake(0, -windowSize.width/2, windowSize.width, windowSize.height);
          }
    else{
         frame=CGRectMake(0, -300, windowSize.width, windowSize.height);
        
    }
    
    
    [self animationMethod:tagValue frame:(CGRect)frame];
}

-(void)photoButtonAction:(UIButton*)sender{
    CGRect frame;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        frame=CGRectMake(0, -windowSize.width/2, windowSize.width, windowSize.height);
    }
    else{
        frame=CGRectMake(0, -300, windowSize.width, windowSize.height);
        
    }
     int tagValue=(int)[sender tag];
      [self animationMethod:tagValue frame:(CGRect)frame];
}

-(void)creditsButtonAction:(UIButton*)sender{
    CGRect frame;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        frame=CGRectMake(0, -windowSize.width/2, windowSize.width, windowSize.height);
    }
    else{
        frame=CGRectMake(0, -300, windowSize.width, windowSize.height);
        
    }
    int tagValue=(int)[sender tag];
    [self animationMethod:tagValue frame:(CGRect)frame];
}

-(void)superPowerButtonAction:(UIButton*)sender{
    CGRect frame;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        frame=CGRectMake(0, -windowSize.width/2, windowSize.width, windowSize.height);
    }
    else{
        frame=CGRectMake(0, -300, windowSize.width, windowSize.height);
        
    }
    int tagValue=(int)[sender tag];
    [self animationMethod:tagValue frame:(CGRect)frame];
}

#pragma mark- superView

-(void)createSuperPowerView:(CGRect)frame{
    
    if(self.secondView)
    {
        self.secondView=nil;
    }
    self.secondView=[[UIView alloc]initWithFrame:frame];
    self.secondView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:self.secondView];
    
    if (superPower) {
        superPower=nil;
    }
    
    //superPower = [[SuperPowerViewController alloc] initWithNibName:@"SuperPowerViewController" bundle:nil];
    if (UI_USER_INTERFACE_IDIOM()!=UIUserInterfaceIdiomPad) {
        if (windowSize.height>500) {
            superPower=[[SuperPowerViewController alloc]initWithFrame:CGRectMake(0, 0, self.secondView.frame.size.width, self.secondView.frame.size.height)];

        }
        else{
            superPower=[[SuperPowerViewController alloc]initWithFrame:CGRectMake(0, 0, self.secondView.frame.size.width, self.secondView.frame.size.height-150)];
        
            }
    }
    else{
        superPower=[[SuperPowerViewController alloc]initWithFrame:CGRectMake(0, 0, self.secondView.frame.size.width, self.secondView.frame.size.height+45)];
    }
    [self addChildViewController:superPower];
  
    [self.secondView addSubview:superPower.view];
}
#pragma  mark-Photo View
-(void)createPhotoView:(CGRect)frame{
    if(self.secondView)
    {
        self.secondView=nil;
    }
    self.secondView=[[UIView alloc]initWithFrame:frame];
    self.secondView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:self.secondView];
    
    if (photoVC) {
        photoVC=nil;
    }
     //[SingletonClass shareSingleton].frame=frame;
   // NSLog(@"%f",[SingletonClass shareSingleton].frame);
    
  // photoVC = [[PhotoViewController alloc] initWithNibName:@"PhotoViewController" bundle:nil];
    if (UI_USER_INTERFACE_IDIOM()!=UIUserInterfaceIdiomPad) {
        if(windowSize.height>500)
        {
            photoVC=[[PhotoViewController alloc]initWithFrame:CGRectMake(0, 0, self.secondView.frame.size.width, self.secondView.frame.size.height)];
        }
        else{
            photoVC=[[PhotoViewController alloc]initWithFrame:CGRectMake(0, 0, self.secondView.frame.size.width, self.secondView.frame.size.height-150)];
        }
    }
    else{
        photoVC=[[PhotoViewController alloc]initWithFrame:CGRectMake(0, 0, self.secondView.frame.size.width, self.secondView.frame.size.height+45)];
    }
   
    [self addChildViewController:photoVC];
    
    [self.secondView addSubview:photoVC.view];
}

#pragma  mark- animation

-(void)animationMethod:(int)tagValue frame:(CGRect)frame{
    if (self.state==NO || tagValue==self.selectedIndex) {
        
    
    
    if(self.parentView.frame.origin.y==0)
    {
        
        [UIView animateWithDuration:0.5 animations:^{
            self.parentView.frame=frame;
        } completion:^(BOOL finished) {
            CGRect  ff;
            if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
                ff=CGRectMake(0, windowSize.height/2+55, windowSize.width,(windowSize.height-windowSize.height/2-80));
            }
            else{
                
                if ([UIScreen mainScreen].bounds.size.height>500) {
                    ff=CGRectMake(0, 220, windowSize.width, 300);
                }
                else{
                    ff=CGRectMake(0, 125, windowSize.width, 450);
                }
            }
            if (tagValue!=4&&tagValue!=2) {
                CGRect frame;
                if (UI_USER_INTERFACE_IDIOM()!=UIUserInterfaceIdiomPad) {
                    
                
                if (windowSize.height>500) {
                    frame=CGRectMake(0, 220, windowSize.width, 300);
                     [self createTableView:frame tagvalue: tagValue];
                }
                else{
                      [self createTableView:ff tagvalue: tagValue];
                }
            }
                else{
                
                        [self createTableView:ff tagvalue: tagValue];
                }
                
            }
            else if(tagValue==4){
                [self createSuperPowerView:ff];
            }
            else{
                [self createPhotoView:ff];
            }
            self.swipe.direction = UISwipeGestureRecognizerDirectionDown;
        }];
        self.state=YES;
    }
    else{
        self.secondView.hidden=YES;
        [self.profileTableView removeFromSuperview];
        [self.creditsTableView removeFromSuperview];
        [photoVC.view removeFromSuperview];
        [superPower.view removeFromSuperview];
       // self.profileTableView=nil;
       // self.creditsTableView=nil;
        //photoVC=nil;
       // superPower=nil;
       // self.secondView=nil;
        [UIView animateWithDuration:0.5 animations:^{
            self.parentView.frame=CGRectMake(0,0 , self.screen_width, windowSize.height);
        } completion:^(BOOL finished) {
            self.swipe.direction=UISwipeGestureRecognizerDirectionUp;
            
        }];
        self.state=NO;
    }    self.selectedIndex=tagValue;
    }
    else{
       
        self.secondView.hidden=YES;
        [self.profileTableView removeFromSuperview];
        [self.creditsTableView removeFromSuperview];
        [photoVC.view removeFromSuperview];
        [superPower.view removeFromSuperview];
      //  self.profileTableView=nil;
      //  self.creditsTableView=nil;
      //  photoVC=nil;
      //  superPower=nil;
      //  self.secondView=nil;
        CGRect  ff;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            ff=CGRectMake(0, windowSize.height/2+55, windowSize.width,(windowSize.height-windowSize.height/2-80));
        }
        else{
            
            if ([UIScreen mainScreen].bounds.size.height>500) {
                ff=CGRectMake(0, 220, windowSize.width, 300);
            }
            else{
                ff=CGRectMake(0, 125, windowSize.width, 450);
            }
        }
        if (tagValue!=4&&tagValue!=2) {
            CGRect frame;
            
            if (UI_USER_INTERFACE_IDIOM()!=UIUserInterfaceIdiomPad) {
                
                
                if (windowSize.height>500) {
                    frame=CGRectMake(0, 220, windowSize.width, 300);
                    [self createTableView:frame tagvalue: tagValue];
                }
                else{
                    [self createTableView:ff tagvalue: tagValue];
                }
            }
            else{
                
                [self createTableView:ff tagvalue: tagValue];
            }
            
        }
        else if(tagValue==4){
            
            [self createSuperPowerView:ff];
        }
        else{
           
            [self createPhotoView:ff];
        }
        self.swipe.direction = UISwipeGestureRecognizerDirectionDown;
        self.state=YES;
         self.selectedIndex=tagValue;
    }
    
    
    
}

#pragma mark- table view delegate methods

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView==self.creditsTableView) {
        if (section==0) {
            return 0;
        }
    }
    if (tableView==self.profileTableView) {
        if (section==0) {
            return 0;
        }
    }
        return row_hh+20;
    
}





-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int rows=0;
    if (tableView==self.profileTableView) {
        if (section==1|| section==2) {
            rows=1;
            return rows;
        }
        else if (section==0)
        {
            rows=0;
            return rows;
            
        }
        else if(section==3)
        {
            rows=(int)self.sectionTwoData.count;
            return rows;
        }
       
    }
    if (tableView==self.creditsTableView) {
        rows=1;
        return rows;
    }
    return rows;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * facebook_img,* side_arrow,* awards,*super_powers;
    static NSString * cellIdentifier=@"cell";
    
    UITableViewCell * cell=[tableView cellForRowAtIndexPath:indexPath];
    if(!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        cell.textLabel.font=[UIFont boldSystemFontOfSize:22];
        cell.detailTextLabel.font=[UIFont systemFontOfSize:20];
        
        facebook_img=@"fb_icon_ipad.png";
        side_arrow=@"side_arrow_ipad.png";
        super_powers=@"super_power_ipad.png";
        awards=@"award_ipad.png";
        
    }
    else{
        facebook_img=@"fb_verify_icon.png";
        side_arrow=@"side_arrow.png";
        super_powers=@"super_power.png";
        awards=@"award.png";

        cell.textLabel.font=[UIFont boldSystemFontOfSize:12];
        cell.detailTextLabel.font=[UIFont systemFontOfSize:12];
        
    }
        if(tableView==self.profileTableView)
        {
            if (indexPath.section==0) {
                if (indexPath.row==0) {
                    
                    cell.textLabel.text=@"Facebook";
                    
                    cell.imageView.image=[UIImage imageNamed:facebook_img];
                    if (facebookVerify==YES) {
                        UIImageView * imgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"select.png"]];
                        cell.accessoryView=imgView;
                    }
                    else{
                        UIImageView * imgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:side_arrow]];
                        cell.accessoryView=imgView;
                    }
                    
                }
                else{
                    cell.textLabel.text=@"Taka Super Powers";
                    cell.imageView.image=[UIImage imageNamed:super_powers];
                    if (spVerify==YES) {
                        UIImageView * imgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"select.png"]];                        cell.accessoryView=imgView;
                    }
                    else{
                        UIImageView * imgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:side_arrow]];
                        cell.accessoryView=imgView;
                    }
                }
            }
            
            
            if(indexPath.section==1)
            {
              
                if(indexPath.row==0)
                {
                    for(int i=0;i<5;i++)
                    {
                        UIImageView * imgView=[[UIImageView alloc]init];
                        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
                            imgView.frame=CGRectMake(10+(i*100), 5, 80, 80);
                            imgView.image=[UIImage imageNamed:awards];

                        }
                        else{
                            imgView.frame=CGRectMake(10+(i*50), 2, 50, 40);
                            imgView.image=[UIImage imageNamed:awards];
                        }
                        imgView.layer.cornerRadius=12;
                        imgView.clipsToBounds=YES;
                        [cell.contentView addSubview:imgView];
                    }
                    UIImageView * image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:side_arrow]];
                    cell.accessoryView=image;
                }
            }

            
            
            if (indexPath.section==3) {
                if (indexPath.row!=0) {
                    
                    //cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                    UIImageView * image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:side_arrow]];
                    cell.accessoryView=image;
                }
                cell.textLabel.text=[self.sectionTwoData  objectAtIndex:indexPath.row];
                cell.imageView.image=[UIImage imageNamed:[NSString stringWithString:[self.sectionTwoImages objectAtIndex:indexPath.row]]];
                
                if (indexPath.row==0) {
                    cell.detailTextLabel.text=[SingletonClass shareSingleton].location;
                }
                if (indexPath.row==1) {
                    if(![SingletonClass shareSingleton].aboutMe)
                    {
                        cell.detailTextLabel.text=@"No answer";
                    }
                    else{
                        cell.detailTextLabel.numberOfLines=0;
                        cell.detailTextLabel.lineBreakMode=NSLineBreakByCharWrapping;
                        cell.detailTextLabel.text=[SingletonClass shareSingleton].aboutMe;
                    }
                }
                if (indexPath.row==5) {
                    if(![SingletonClass shareSingleton].appearance)
                    {
                        cell.detailTextLabel.text=@"No answer";
                    }
                    else{
                        cell.detailTextLabel.numberOfLines=0;
                        cell.detailTextLabel.lineBreakMode=NSLineBreakByCharWrapping;
                        cell.detailTextLabel.text=[SingletonClass shareSingleton].appearance;
                    }
                }
                if (indexPath.row==2) {
                    cell.detailTextLabel.numberOfLines=0;
                    cell.detailTextLabel.lineBreakMode=NSLineBreakByCharWrapping;
                    if(![SingletonClass shareSingleton].interestedIn)
                    {
                        cell.detailTextLabel.text=@"No answer";
                    }
                    else{
                        cell.detailTextLabel.text=[SingletonClass shareSingleton].interestedIn;
                    }
                }
                if (indexPath.row==3) {
                    if(![SingletonClass shareSingleton].relation)
                    {
                        cell.detailTextLabel.text=@"No answer";
                    }
                    else{
                        cell.detailTextLabel.text=[SingletonClass shareSingleton].relation;
                    }
                }
                if (indexPath.row==4) {
                    if(![SingletonClass shareSingleton].sexuality)
                    {
                        cell.detailTextLabel.text=@"No answer";
                    }
                    else{
                            cell.detailTextLabel.text=[SingletonClass shareSingleton].sexuality;
                    }
                }
                if (indexPath.row==6) {
                    if(![SingletonClass shareSingleton].Living)
                    {
                        cell.detailTextLabel.text=@"No answer";
                    }
                    else{
                            cell.detailTextLabel.text=[SingletonClass shareSingleton].Living;
                    }
                }
                if (indexPath.row==7) {
                    if(![SingletonClass shareSingleton].children)
                    {
                        cell.detailTextLabel.text=@"No answer";
                    }
                    else{
                            cell.detailTextLabel.text=[SingletonClass shareSingleton].children;
                    }
                }
                if (indexPath.row==8) {
                    if(![SingletonClass shareSingleton].smoking)
                    {
                        cell.detailTextLabel.text=@"No answer";
                    }
                    else{
                            cell.detailTextLabel.text=[SingletonClass shareSingleton].smoking;
                    }
                }
                if (indexPath.row==9) {
                    if(![SingletonClass shareSingleton].dirinking)
                    {
                        cell.detailTextLabel.text=@"No answer";
                    }
                    else{
                            cell.detailTextLabel.text=[SingletonClass shareSingleton].dirinking;
                    }
                }
                if (indexPath.row==10) {
                    if(![SingletonClass shareSingleton].education )
                    {
                        cell.detailTextLabel.text=@"No answer";
                    }
                    else{
                            cell.detailTextLabel.text=[SingletonClass shareSingleton].education;
                    }
                }
                if (indexPath.row==11) {
                    cell.detailTextLabel.numberOfLines=0;
                    cell.detailTextLabel.lineBreakMode=NSLineBreakByCharWrapping;
                    if(![SingletonClass shareSingleton].languages )
                    {
                        cell.detailTextLabel.text=@"No answer";
                    }
                    else{
                        cell.detailTextLabel.text=[SingletonClass shareSingleton].languages;
                    }

                    
                }
                if (indexPath.row==12) {
                    cell.detailTextLabel.numberOfLines=0;
                    cell.detailTextLabel.lineBreakMode=NSLineBreakByCharWrapping;
                    if ([SingletonClass shareSingleton].profession!=NULL) {
                           NSString *  work=[NSString stringWithFormat:@"%@ %@",[SingletonClass shareSingleton].profession,[SingletonClass shareSingleton].income];
                        cell.detailTextLabel.text=work;
                    }
                    else{
                    NSString *  work=[NSString stringWithFormat:@"%@ %@",[SingletonClass shareSingleton].profession,[SingletonClass shareSingleton].income];
                    cell.detailTextLabel.text=work;
                    }
                }

            }
            if (indexPath.section==2)
            {
                
                if (indexPath.row==0) {
                    
                    if ([SingletonClass shareSingleton].selectedIntId.count>0) {
                        //int y=0;
                        //int x=0;
                        UIView * backView=[[UIView alloc]init];
                        backView.frame=CGRectMake(0, 0,cell.frame.size.width, cell.contentView.frame.size.height);
                        
                        [cell.contentView addSubview:backView];
                                                
                        if ([SingletonClass shareSingleton].selectedIntId.count>6) {
                            //[self createInterestUI:5 indexpath:indexPath];
                            
                            for (int i=0;i<5;i++) {
                                
                                UIButton * btn1=[[UIButton alloc]init];
                                 btn1.frame=CGRectMake(20, 0+i*50, cell.contentView.frame.size.width/2-40, 40);
                                [btn1 setTitle:[[SingletonClass shareSingleton].selectedIntName objectAtIndex:i+i] forState:UIControlStateNormal];
                                [btn1 setBackgroundColor:[UIColor clearColor]];
                                btn1.layer.borderColor=[UIColor lightGrayColor].CGColor;
                                btn1.layer.borderWidth=0.7;
                                btn1.layer.cornerRadius=7;
                                btn1.clipsToBounds=YES;
                                [btn1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                                [btn1 addTarget:self action:@selector(moveToInterestView) forControlEvents:UIControlEventTouchUpInside];
                                [backView addSubview:btn1];
                                
                                UIButton * btn2=[[UIButton alloc]init];
                                btn2.frame=CGRectMake(cell.contentView.frame.size.width/2+20, 0+i*50, cell.contentView.frame.size.width/2-40, 40);
                                [btn2 setTitle:[[SingletonClass shareSingleton].selectedIntName objectAtIndex:i+1] forState:UIControlStateNormal];
                                [btn2 setBackgroundColor:[UIColor clearColor]];
                                btn2.layer.borderColor=[UIColor lightGrayColor].CGColor;
                                [btn2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                                btn2.layer.borderWidth=0.7;
                                btn2.layer.cornerRadius=7;
                                btn2.clipsToBounds=YES;
                                [btn2 addTarget:self action:@selector(moveToInterestView) forControlEvents:UIControlEventTouchUpInside];
                                [backView addSubview:btn2];
                                
                            }
                            
                        }
                        else{
                            
                            int y=0;
                            int x=0;
                            
                            
                            for (int i=0;i<[SingletonClass shareSingleton].selectedIntId.count;i++) {
                                UIButton * btn1=[[UIButton alloc]init];
                                 btn1.frame=CGRectMake(20, 0+i*50, cell.contentView.frame.size.width/2-40, 40);
                                [btn1 setTitle:[[SingletonClass shareSingleton].selectedIntName objectAtIndex:i] forState:UIControlStateNormal];
                                [btn1 setBackgroundColor:[UIColor clearColor]];
                                btn1.layer.borderColor=[UIColor lightGrayColor].CGColor;
                                btn1.layer.borderWidth=0.7;
                                btn1.layer.cornerRadius=7;
                                btn1.clipsToBounds=YES;
                                [btn1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                                [btn1 addTarget:self action:@selector(moveToInterestView) forControlEvents:UIControlEventTouchUpInside];
                                [backView addSubview:btn1];
                                
                                UIButton * btn2=[[UIButton alloc]init];
                                btn2.frame=CGRectMake(cell.contentView.frame.size.width/2+20, 0+i*50, cell.contentView.frame.size.width/2-40, 40);
                                [btn2 setTitle:[[SingletonClass shareSingleton].selectedIntName objectAtIndex:i] forState:UIControlStateNormal];
                                [btn2 setBackgroundColor:[UIColor clearColor]];
                                btn2.layer.borderColor=[UIColor lightGrayColor].CGColor;
                                [btn2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                                btn2.layer.borderWidth=0.7;
                                btn2.layer.cornerRadius=7;
                                btn2.clipsToBounds=YES;
                                [btn2 addTarget:self action:@selector(moveToInterestView) forControlEvents:UIControlEventTouchUpInside];
                                [backView addSubview:btn2];

                                
                                y=40;
                                x=cell.contentView.frame.size.width/2+20;
                            }
                            
                            // [self createInterestUI:interests.count indexpath:indexPath];
                        }
                    }
                    else{
                        cell.textLabel.text=@"Inetrests";
                        cell.imageView.image=[UIImage imageNamed:@"interest_icon.png"];
                    }
                }
            
            
            return  cell;
        }
       
        }
    
    
   
    if (tableView==self.creditsTableView) {
        
        if(indexPath.row==0)
        {
            UILabel * topLabel=[[UILabel alloc]init];
            topLabel.frame=CGRectMake(cell.frame.size.width/2-135, 10, cell.frame.size.width-50, 60);
            topLabel.text=@"Boosting your popularity just got really easy! Refill your Taka credits and meet new people faster than ever.";
            topLabel.font=[UIFont systemFontOfSize:font_size];
            topLabel.textColor=[UIColor blackColor];
            topLabel.lineBreakMode=NSLineBreakByCharWrapping;
            topLabel.numberOfLines=0;
            topLabel.textAlignment=NSTextAlignmentCenter;
                //[topLabel sizeToFit];
            [cell.contentView addSubview:topLabel];
            
           NSString * credits=[[NSUserDefaults standardUserDefaults]objectForKey:@"credit"];
            
            UILabel * bottomLabel=[[UILabel alloc]init];
            bottomLabel.frame=CGRectMake(cell.frame.size.width/2-70, 70, 160, 60);
            
            bottomLabel.text=@"Your credit balance";
            bottomLabel.font=[UIFont boldSystemFontOfSize:font_size];
            bottomLabel.textColor=[UIColor blackColor];
            bottomLabel.lineBreakMode=NSLineBreakByCharWrapping;
            bottomLabel.numberOfLines=0;
             bottomLabel.textAlignment=NSTextAlignmentCenter;
            [bottomLabel sizeToFit];
            [cell.contentView addSubview:bottomLabel];
            
            
            
            UIImageView * imgView=[[UIImageView alloc]init];
            imgView.frame=CGRectMake(cell.frame.size.width/2-60, 120, 40, 40);
            imgView.image=[UIImage imageNamed:@"pay_icon.png"];
            [cell.contentView addSubview:imgView];
            
            UILabel * creditLabel=[[UILabel alloc]init];
            
            creditLabel.frame=CGRectMake(cell.frame.size.width/2, 115, 150, 50);
            if (!credits) {
                creditLabel.text=@"0";
            }
            else{
                creditLabel.text=[NSString stringWithFormat:@"%@",credits];
            }
            creditLabel.font=[UIFont boldSystemFontOfSize:20];
            [cell.contentView addSubview:creditLabel];
            
            
            UIButton * refillCredits=[UIButton buttonWithType:UIButtonTypeCustom];
            refillCredits.frame=CGRectMake(cell.frame.size.width/2-80, 200, 168, 30);
            [refillCredits setTitle:@"Top Up" forState:UIControlStateNormal];
            refillCredits.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"setting_btn_bg.png"]];
            refillCredits.titleLabel.font=[UIFont systemFontOfSize:font_size];
            refillCredits.layer.cornerRadius=4;
            refillCredits.clipsToBounds=YES;
            refillCredits.titleLabel.textColor=[UIColor whiteColor];
           // [refillCredits addTarget:self action:@selector(refillButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:refillCredits];
            
            if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
                 topLabel.frame=CGRectMake(cell.frame.size.width/2-50, 10, windowSize.width-250, 60);
                bottomLabel.frame=CGRectMake(cell.frame.size.width/2+80, 90, 250, 60);
                imgView.frame=CGRectMake(cell.frame.size.width/2+150, 180, 50, 50);
                refillCredits.frame=CGRectMake(cell.frame.size.width/2+50, 260, 328, 62);
                
                imgView.image=[UIImage imageNamed:@"pay_icon_ipad.png"];
                refillCredits.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"setting_btn_bg_ipad.png"]];
            }
            
            
           // return cell;
        }
        
        
        return cell;
    }
   /* if(tableView==self.superPowerTableView)
    {
        return  cell;
    }*/

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView==self.creditsTableView)
    {
        return credts_hh;
    }
    
    if(tableView==self.profileTableView)
    {
        if (indexPath.section==2)
        {
            
           
        
        if ([SingletonClass shareSingleton].selectedIntId.count>0) {
            return  200;
           /*
            for (int s=0; s<[SingletonClass shareSingleton].intr_name.count; s++) {
                
                CGFloat width = [self findLength:[SingletonClass shareSingleton].intr_name[s] andHeight:80];
                cellWdth+=width;
                if (cellWdth>=300) {
                    height+=80;
                    return height;
                }
            }*/
        }
            else
            {
                return row_hh;
            }
        //}
        }
        if (indexPath.section==3) {
            if (indexPath.row==5) {
                CGFloat width=[self findLength:[SingletonClass shareSingleton].appearance andHeight:50];
                if (width>320) {
                    return 80;
                }
                
            }
           
        }
        return row_hh;
    }
    
        
    return 45;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    int sections;
    if (tableView==self.profileTableView) {
        sections=5;
        return sections;
    }
    if(tableView==self.creditsTableView)
    {
        sections =1;
        return sections;
    }/*
    if(tableView==self.superPowerTableView)
    {
        sections=3;
    }*/
    return sections;
}



-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString * str;
    if (tableView==self.profileTableView) {
        if (section==0) {
            str=@"";
        }
        else if (section==1) {
            str=@"Awards";
        }
        else if(section==3)
        {
            str=@"Profile";
        }
        else if(section==2 ){
            str=@"Interests";
        }
        
    }
    if (tableView==self.creditsTableView) {
        
        str=@"";
        return str;
    }/*
    if (tableView==self.superPowerTableView) {
        if (section==0) {
            str=@"Awards";
        }
        else if(section==2)
        {
            str=@"Profile";
        }
        else{
            str=@" ";
        }
    }*/
    return str;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.section==0) {
      /*  if (indexPath.row==1) {
            if (superPowerProfile) {
                superPowerProfile=nil;
            }
            superPowerProfile = [[SuperPowerProfileViewController alloc] initWithNibName:@"SuperPowerProfileViewController" bundle:nil];
           // [self.navigationController popViewControllerAnimated:YES];
            [appdelegate.window addSubview:superPowerProfile.view];
        }*/
       
    }

    if (indexPath.section==2) {
        //-----Webservice for interest
       // [self getAllInterests];
        if (self.interestVC) {
            self.interestVC=nil;
        }
        self.interestVC=[[InterestViewController alloc]initWithNibName:@"InterestViewController" bundle:nil];
        [self.navigationController pushViewController:self.interestVC animated:YES];
       // [appdelegate.window addSubview:self.interestVC.view];
    }
    if (indexPath.section==3) {
        if (indexPath.row==5) {
            if(self.apperenceVC)
            {
                self.apperenceVC=nil;
            }
            self.apperenceVC=[[ApperrenceViewController alloc]initWithNibName:@"ApperrenceViewController" bundle:nil];
            [self.navigationController pushViewController:self.apperenceVC animated:YES];
            //   [appdelegate.window addSubview:self.apperenceVC.view];
           
        }
        else if (indexPath.row==1) {
            if (self.aboutMeVC) {
                self.aboutMeVC=nil;
            }
            self.aboutMeVC=[[AboutMeViewController alloc]initWithNibName:@"AboutMeViewController" bundle:nil];
            [self.navigationController pushViewController:self.aboutMeVC animated:YES];
            // [appdelegate.window addSubview:self.aboutMeVC.view];
        }
        else if(indexPath.row==2){
            if (self.interestedIn) {
                self.interestedIn=nil;
            }
            self.interestedIn=[[InetrestedINViewController alloc]initWithNibName:@"InetrestedINViewController" bundle:nil];
            [self.navigationController pushViewController:self.interestedIn animated:YES];
            // [appdelegate.window addSubview:self.interestedIn.view];
        }
        
        else
        {
            if (indexPath.row!=0&& indexPath.row!=12&& indexPath.row!=2 && indexPath.row!=1 && indexPath.row!=11 && indexPath.row!=5)
            {
                if(self.relationVC)
                {
                    self.relationVC=nil;
                
                }
        self.relationVC=[[RelationshipViewController alloc]initWithNibName:@"RelationshipViewController" bundle:nil];
            self.relationVC.titleStr=[self.sectionTwoData objectAtIndex:indexPath.row];
            self.relationVC.index=(int)indexPath.row;
           // [appdelegate.window addSubview:self.relationVC.view];
                [self.navigationController pushViewController:self.relationVC animated:YES];
            }
            
        }
        if (indexPath.row==12) {
            if(self.workasVC)
            {
                self.workasVC=nil;
                
            }
            self.workasVC=[[WorkAsViewController alloc]initWithNibName:@"WorkAsViewController" bundle:nil];
            [self.navigationController pushViewController:self.workasVC animated:YES];
            
            //[appdelegate.window addSubview:self.workasVC.view];
        }
        if (indexPath.row==11) {
            if(labguages)
            {
                labguages=nil;
                
            }
            labguages=[[ISpeakLanguageViewController alloc]initWithNibName:@"ISpeakLanguageViewController" bundle:nil];
            [self.navigationController pushViewController:labguages animated:YES];
            
            //[appdelegate.window addSubview:labguages.view];
        }
        
    }
    if (indexPath.section==1) {
        if (awardVC) {
            awardVC=nil;
        }
       awardVC =[[AwardSectionViewController alloc]initWithNibName:@"AwardSectionViewController" bundle:nil];
        [self.navigationController pushViewController:awardVC animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
   
    return 0;
   
}

#pragma mark- refillButtonClicked
-(void)refillButtonClicked:(id)sender{
    if (creditsVC) {
        creditsVC=nil;
    }
    creditsVC=[[RefillCreditsViewController alloc]initWithNibName:@"RefillCreditsViewController" bundle:nil];
    [self.navigationController pushViewController:creditsVC animated:YES];
}

#pragma mark-findLength of string interests

-(CGFloat)findLength:(NSString *)text andHeight:(CGFloat)height
{
           UILabel *label = [[UILabel alloc] init];
        label.text = text;
        label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
        label.numberOfLines = 0;
        label.textAlignment=NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        
       // label.frame = CGRectMake(0, 0, 280, 100);
      CGSize size=[label sizeThatFits:CGSizeMake(FLT_MAX, height)];
        [label sizeToFit];
        NSLog(@"width %f",size.width);
        return size.width;
}

#pragma mark- move to interest class
-(void)moveToInterestView{
    
    if (self.interestVC) {
        self.interestVC=nil;
    }
    self.interestVC=[[InterestViewController alloc]initWithNibName:@"InterestViewController" bundle:nil];
    [self.navigationController pushViewController:self.interestVC animated:YES];
}


#pragma mark- getUserinterests
-(NSMutableArray *)getUserinterests{
    NSError * error=nil;
    NSURLResponse * urlResponse=nil;
    
    NSString * urlStr=[NSString stringWithFormat:@"http://23.238.24.26/user/get-all-interests"];
    //urlStr=[urlStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * url=[NSURL URLWithString:urlStr];
    
    NSMutableURLRequest * request =[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"POST"];
     [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSString * body=[NSString stringWithFormat:@"userId=%@",[SingletonClass shareSingleton].userID];
    [request setHTTPBody:[body dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (data==nil) {
        return 0;
    }
    
    id parse =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@" parse user selected interests-==-%@",parse);
    
    if ([[parse objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
        [SingletonClass shareSingleton].intr_cat_id=[[NSMutableArray alloc]init];
        [SingletonClass shareSingleton].intr_id=[[NSMutableArray alloc]init];
        [SingletonClass shareSingleton].intr_name=[[NSMutableArray alloc]init];
        NSMutableArray * userInterest=[parse objectForKey:@"data"];
        for (int i=0; i<userInterest.count; i++) {
            NSMutableDictionary * dict=[userInterest objectAtIndex:i];
                    [[SingletonClass shareSingleton].intr_cat_id addObject:[dict objectForKey:@"intr_cat_id"]];
                    [[SingletonClass shareSingleton].intr_id addObject:[dict objectForKey:@"intr_id"]];
                    [[SingletonClass shareSingleton].intr_name addObject:[dict objectForKey:@"intr_name"]];
        }
        NSLog(@"user interests name %@",[SingletonClass shareSingleton].intr_name);
       
    }
    [self.profileTableView reloadData];
     return [SingletonClass shareSingleton].intr_name;
    
}


/*-(void)getAllInterests{
    
    NSError * error;
    NSURLResponse * urlResponse;
    
    NSString * urlStr=[NSString stringWithFormat:@"http://taka.dating/user/getAllInterests/%@",[SingletonClass shareSingleton].userID];
    urlStr=[urlStr  stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * url=[NSURL URLWithString:urlStr];
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    if (!data) {
        NSLog(@"No data available");
        return;
    }
    id parse=[NSJSONSerialization JSONObjectWithData:data
                                             options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"parse interest %@ ",parse);
    if ([[parse objectForKey:@"intr_cat_id"]isEqualToNumber:[NSNumber numberWithInt:1]]) {
        
    }
}*/


#pragma mark- All Button actions here


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
