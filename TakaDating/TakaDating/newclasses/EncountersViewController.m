//
//  EncountersViewController.m
//  TakaDating
//
//  Created by GBS-ios on 11/10/14.
//  Copyright (c) 2014 Globussoft. All rights reserved.
//

#import "EncountersViewController.h"
#import "ViewController.h"
#import "UIImageView+WebCache.h"
#import "EncounterFilterViewController.h"

@interface EncountersViewController ()
{
    AppDelegate *appdelegate ;
    UIImageView * profileImg;
    EncounterFilterViewController  * encounterFilterVC;
}
@property(nonatomic,strong)ViewController * VC;
@end

@implementation EncountersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [imageScroll removeFromSuperview];
    [view removeFromSuperview];
    [tagLine removeFromSuperview];
    [imageCount removeFromSuperview];
    [ProfileName removeFromSuperview];
    
    [self createScrollUI];
}
- (void)viewDidLoad

{
    
    windowSize=[UIScreen mainScreen].bounds.size;
    [super viewDidLoad];
    self.selectedIndex=1;
   
    self.sectionTwoImages=[NSArray arrayWithObjects:@"location.png",@"about_me.png",@"relationship.png",@"sexuality.png",@"apperance.png",@"living.png",@"kids.png",@"smoking.png",@"drinking.png",@"education.png",@"language.png",@"work.png", nil];
    CGRect frame;
    self.screen_width=[UIScreen mainScreen].bounds.size.width;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        row_hh=80;
         self.sectionTwoData=[NSArray arrayWithObjects:@"Location",@"About Me",@"Relationship",@"Sexuality",@"Appearence",@"Living",@"Children",@"Smoking",@"Drinking",@"Education",@"I Speak",@"I Work as", nil];
       self.sectionTwoImages=[NSArray arrayWithObjects:@"location_ipad.png",@"about_me_ipad.png",@"interested_in_ipad.png",@"relationship_ipad.png",@"sexuality_ipad.png",@"apperance_ipad.png",@"living_ipad.png",@"kids_ipad.png",@"smoking_ipad.png",@"drinking_ipad.png",@"education_ipad.png",@"language_ipad.png",@"work_ipad.png", nil];
        frame=CGRectMake(windowSize.width/2-40, 150, 80, 80);
        
    }
    else{
        row_hh=40;
         self.sectionTwoData=[NSArray arrayWithObjects:@"Location",@"About Me",@"Relationship",@"Sexuality",@"Appearence",@"Living",@"Children",@"Smoking",@"Drinking",@"Education",@"I Speak",@"I Work as", nil];
        self.sectionTwoImages=[NSArray arrayWithObjects:@"location.png",@"about_me.png",@"add_interest.png",@"relationship.png",@"sexuality.png",@"apperance.png",@"living.png",@"kids.png",@"smoking.png",@"drinking.png",@"education.png",@"language.png",@"work.png", nil];
        frame=CGRectMake(140, 150, 40, 40);
    }
  
    
    [self createUI];
    
    self.refreshActivityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:frame];
    
    self.refreshActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    
    self.refreshActivityIndicator.color = [UIColor blackColor];
    
    [self.parentView addSubview:self.refreshActivityIndicator];
    self.refreshActivityIndicator.alpha = 1.0;
     [self.refreshActivityIndicator startAnimating];
   
   
     dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
         [self callWebServiceForEncounter];
         
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.refreshActivityIndicator stopAnimating];

             [self createScrollUI];
        });
    });
    
    
   
    // Do any additional setup after loading the view from its nib.
}


   
    
/*#pragma mark-creatUI
-(void)createUI{
        
        self.screen_width=[UIScreen mainScreen].bounds.size.width;
        if(!self.parentView)
        {
            self.parentView=[[UIView alloc]init];
            self.parentView.frame=[UIScreen mainScreen].bounds;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
                self.parentView.frame=CGRectMake(0, 0, windowSize.width, windowSize.height-100);
                self.parentView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"profile_screen_bg_ipad.png"]];
            }
            else{
                if ([UIScreen mainScreen].bounds.size.height>500) {
                self.parentView.frame=CGRectMake(0, 0, windowSize.width, self.view.frame.size.height);
                }
                else{
                    self.parentView.frame=CGRectMake(0, 0, windowSize.width, self.view.frame.size.height-80);
                    self.parentView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"profile_screen_bg.png"]];
                    }
            }
            
            
            [self.view addSubview:self.parentView];
        }
        self.parentView.hidden=NO;
        
        
        
        
        if(!self.tabView)
        {
            self.tabView=[[UIView alloc]init];
            self.tabView.backgroundColor=[UIColor clearColor];
            if([UIScreen mainScreen].bounds.size.height>500)
            {
                self.tabView.frame=CGRectMake(0, 465, 320, 50);
            }
            else{
                self.tabView.frame=CGRectMake(0, 375, 320, 50);
            }
            self.tabView.backgroundColor=[UIColor blackColor];
            [self.parentView addSubview:self.tabView];
        }
        self.tabView.hidden=YES;
        
        self.swipe=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeGesture:)];
        self.swipe.direction=UISwipeGestureRecognizerDirectionUp;
        [self.parentView addGestureRecognizer:self.swipe];
        
        
        
        UIButton * profile=[[UIButton alloc]init];
        profile.frame=CGRectMake(10, 10, 60, 30);
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
        photosBtn.frame=CGRectMake(95, 10, 50, 30);
        photosBtn.titleLabel.font=[UIFont boldSystemFontOfSize:9];
        [photosBtn setImage:[UIImage imageNamed:@"yes.png"] forState:UIControlStateNormal];
        //[photosBtn addTarget:self action:@selector(photoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        photosBtn.tag=2;
        [self.tabView addSubview:photosBtn];
        
        UIButton * CreditsBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        // [CreditsBtn setTitle:@"Credits" forState:UIControlStateNormal];
        CreditsBtn.frame=CGRectMake(185, 10, 50, 30);
        CreditsBtn.titleLabel.font=[UIFont boldSystemFontOfSize:9];
        [CreditsBtn setImage:[UIImage imageNamed:@"maybe.png"] forState:UIControlStateNormal];
        CreditsBtn.tag=3;
        //[CreditsBtn addTarget:self action:@selector(creditsButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.tabView addSubview:CreditsBtn];
        
        UIButton * OffBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        //[OffBtn setTitle:@"Off" forState:UIControlStateNormal];
        OffBtn.frame=CGRectMake(265, 10, 50, 30);
        OffBtn.titleLabel.font=[UIFont boldSystemFontOfSize:9];
        [OffBtn setImage:[UIImage imageNamed:@"no.png"] forState:UIControlStateNormal];
        OffBtn.tag=4;
       // [OffBtn addTarget:self action:@selector(superPowerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabView addSubview:OffBtn];
        
        
        self.tabView.hidden=NO;
        
        
        
    }old encounter */

#pragma mark-creatUI
-(void)createUI{
    
   
    
    
    self.screen_width=[UIScreen mainScreen].bounds.size.width;
    if(!self.parentView)
    {
        self.parentView=[[UIView alloc]init];
        self.parentView.frame=[UIScreen mainScreen].bounds;
        
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            self.parentView.frame=CGRectMake(0, 0, windowSize.width, windowSize.height-25);
            self.parentView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"profile_screen_bg_ipad.png"]];
        }
        else{
            if ([UIScreen mainScreen].bounds.size.height>500) {
                self.parentView.frame=CGRectMake(0, 0, windowSize.width, self.view.frame.size.height);
            }
            else{
                self.parentView.frame=CGRectMake(0, 0, windowSize.width, self.view.frame.size.height-80);
            }
            self.parentView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"profile_screen_bg.png"]];
        }
        
        
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
        
        CAGradientLayer * tabLayer=[CAGradientLayer layer];
        tabLayer.frame=CGRectMake(0, 0, self.tabView.frame.size.width, self.tabView.frame.size.height);
        UIColor * firstColor=[UIColor colorWithRed:(CGFloat)38/255 green:(CGFloat)38/255 blue:(CGFloat)38/255 alpha:1.0];
        UIColor  * secondColor=[UIColor colorWithRed:(CGFloat)0/255 green:(CGFloat)0/255 blue:(CGFloat)0/255 alpha:1.0];
        tabLayer.colors=[NSArray arrayWithObjects:(id)[firstColor CGColor],(id)[secondColor CGColor], nil];
        [self.tabView.layer insertSublayer:tabLayer atIndex:0];
        //self.tabView.backgroundColor=[UIColor blackColor];
        [self.parentView addSubview:self.tabView];
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
    [photosBtn setImage:[UIImage imageNamed:@"accept.png"] forState:UIControlStateNormal];
    [photosBtn addTarget:self action:@selector(yesButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    photosBtn.tag=2;
    [self.tabView addSubview:photosBtn];
    
    UIButton * CreditsBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    // [CreditsBtn setTitle:@"Credits" forState:UIControlStateNormal];
    
    CreditsBtn.titleLabel.font=[UIFont boldSystemFontOfSize:9];
    [CreditsBtn setImage:[UIImage imageNamed:@"decline.png"] forState:UIControlStateNormal];
    CreditsBtn.tag=3;
    [CreditsBtn addTarget:self action:@selector(crossButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tabView addSubview:CreditsBtn];
    
//    UIButton * OffBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    //[OffBtn setTitle:@"Off" forState:UIControlStateNormal];
//    
//    OffBtn.titleLabel.font=[UIFont boldSystemFontOfSize:9];
//    [OffBtn setImage:[UIImage imageNamed:@"off_icon_grey.png"] forState:UIControlStateNormal];
//    OffBtn.tag=4;
//    [OffBtn addTarget:self action:@selector(superPowerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.tabView addSubview:OffBtn];
    
    
    self.tabView.hidden=NO;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        
        [profile setImage:[UIImage imageNamed:@"profile_male_grey_ipad.png"] forState:UIControlStateNormal];
        
        [photosBtn setImage:[UIImage imageNamed:@"accept_ipad.png"] forState:UIControlStateNormal];
        [CreditsBtn setImage:[UIImage imageNamed:@"decline_ipad.png"] forState:UIControlStateNormal];
       // [OffBtn setImage:[UIImage imageNamed:@"off_icon_grey_ipad.png"] forState:UIControlStateNormal];
        
        
        profile.frame=CGRectMake(windowSize.width/2-300, 10, 60, 50);
        photosBtn.frame=CGRectMake(windowSize.width/2-30, 10, 50, 50);
        CreditsBtn.frame=CGRectMake(windowSize.width/2+220, 10, 50, 50);
        //OffBtn.frame=CGRectMake(windowSize.width-100, 10, 50, 50);
    }
    else{
        profile.frame=CGRectMake(windowSize.width-280, 10, 60, 30);
        photosBtn.frame=CGRectMake(windowSize.width-180, 10, 30, 30);
        CreditsBtn.frame=CGRectMake(windowSize.width-100, 10, 30, 30);
       // OffBtn.frame=CGRectMake(windowSize.width-55, 10, 50, 30);
        
    }
    
    
}

#pragma mark-scrollImageView

-(void)createScrollUI{
    
    
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            imageScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.parentView.frame.size.width, self.parentView.frame.size.height-200)];
           
        }
        else{
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
        int userImages;
        userImages =(int)[SingletonClass shareSingleton].encounterUsrImages.count;

      //  if ([SingletonClass shareSingleton].encounterUsrImages.count>0) {
      //             }
        if (userImages<1) {
            return;
        }
        else{
        for (int i=0; i<userImages; i++) {
            CGFloat x = i * self.view.frame.size.width;
            profileImg=[[UIImageView alloc]init];
            if ([UIScreen mainScreen].bounds.size.height<500) {
                profileImg.frame=CGRectMake(x, 0, imageScroll.frame.size.width, imageScroll.frame.size.height);
            }
            else{
                profileImg.frame=CGRectMake(x, 0, imageScroll.frame.size.width, imageScroll.frame.size.height);
            }
            profileImg.userInteractionEnabled=YES;
            
            NSLog(@"Encounter images %d",userImages);
            NSString * urlStr=[[SingletonClass shareSingleton].encounterUsrImages objectAtIndex:i];
            NSURL * url=[NSURL URLWithString:urlStr];
            [profileImg setImageWithURL:url];
            //profileImg.image=[UIImage imageNamed:[images1 objectAtIndex:i]];
           
            [imageScroll addSubview:profileImg];
        }
        }
        imageScroll.contentSize=CGSizeMake(imageScroll.frame.size.width*2, imageScroll.frame.size.height);
        [self.parentView addSubview:imageScroll];
        
        view=[[UIView alloc]initWithFrame:CGRectMake(10, 20, 50, 25)];
        view.backgroundColor=[UIColor grayColor];
        view.layer.cornerRadius=5;
        view.clipsToBounds=YES;
        [self.parentView addSubview:view];
        
         imgVw=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 15)];
        imgVw.image=[UIImage imageNamed:@"photo_icon.png"];
        [view addSubview:imgVw];
        
        imageCount=[[UILabel alloc]initWithFrame:CGRectMake(40, 20, 25, 25)];
        imageCount.textColor=[UIColor whiteColor];
        imageCount.font=[UIFont systemFontOfSize:12];
        imageCount.text=[NSString stringWithFormat:@"1/%d",(int)[SingletonClass shareSingleton].encounterUsrImages.count];
        [self.parentView addSubview:imageCount];
        
         ProfileName=[[UILabel alloc]init];
        if ([UIScreen mainScreen].bounds.size.height<500) {
            ProfileName.frame=CGRectMake(40, self.parentView.frame.size.height-220, self.parentView.frame.size.width-150, 30);
        }
        else{
            ProfileName.frame=CGRectMake(40, self.parentView.frame.size.height-180, 200, 30);
        }
        ProfileName.textColor=[UIColor blackColor];
        ProfileName.text=_displayName;
        [self.parentView addSubview:ProfileName];
        
        NSString * str;
          tagLine=[[UILabel alloc]init];
        if ([UIScreen mainScreen].bounds.size.height<500) {
            tagLine.frame=CGRectMake(40, self.parentView.frame.size.height-200, self.parentView.frame.size.width, 30);
        }
        else{
            tagLine.frame=CGRectMake(40, self.parentView.frame.size.height-160, 230, 30);
        }
        tagLine.textColor=[UIColor blackColor];
        
        if ([_userHereFor isEqualToString:@"0"] ) {
            
            str=@"I'am here to make new friends";
        }
        else if([_userHereFor isEqualToString:@"1"]){
            
            if ([_sex isEqualToString:@"0"]) {
                str=@"I'am here to chat with guys";
            }
            else if ([_sex isEqualToString:@"1"])
            {
                str=@"I'am here to chat with girls";
            }
            else{
                str=@"I'am here to chat with both";
            }
        }
        else{
            if ([_sex isEqualToString:@"0"]) {
                str=@"I'am here to date with girl";
            }
            else if ([_sex isEqualToString:@"1"])
            {
                str=@"I'am here to date with boys";
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
        imageCount.text=[NSString stringWithFormat:@"%d/2",page];
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
   /*
    -(void)handleSwipeGesture:(UISwipeGestureRecognizer *)swipe{
        
        NSLog(@"%f",self.parentView.frame.origin.y);
        if(self.parentView.frame.origin.y==0)
        {
            
            [UIView animateWithDuration:0.5 animations:^{
                if ([UIScreen mainScreen].bounds.size.height>500) {
                    
                    self.parentView.frame=CGRectMake(0, -300, self.screen_width, self.view.frame.size.height);
                }
                else{
                    self.parentView.frame=CGRectMake(0, -300, self.screen_width, self.view.frame.size.height);
                }
            } completion:^(BOOL finished) {
                CGRect ff;
                if ([UIScreen mainScreen].bounds.size.height>500) {
                    ff=CGRectMake(0, 220, self.view.frame.size.width, 300);
                }
                else{
                    ff=CGRectMake(0, 125, self.view.frame.size.width, 450);}
                int tagValue=1;
                [self createTableView:ff tagvalue: tagValue];
                self.swipe.direction = UISwipeGestureRecognizerDirectionDown;
            }];
        }
        else{
            
            [UIView animateWithDuration:0.5 animations:^{
                self.parentView.frame=CGRectMake(0,0 , self.screen_width, self.view.frame.size.height);
                self.secondView.hidden=YES;
            } completion:^(BOOL finished) {
                self.swipe.direction=UISwipeGestureRecognizerDirectionUp;
                
            }];
        }
    }
    */

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
            [self createTableView:ff tagvalue: tagValue];
            self.swipe.direction = UISwipeGestureRecognizerDirectionDown;
        }];
    }
    else{
        
        [UIView animateWithDuration:1 animations:^{
            self.parentView.frame=CGRectMake(0,0 ,self.screen_width, self.view.frame.size.height);
            self.secondView.hidden=YES;
        } completion:^(BOOL finished) {
            self.swipe.direction=UISwipeGestureRecognizerDirectionUp;
            
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
            if ([UIScreen mainScreen].bounds.size.height<500) {
                self.profileTableView.frame=CGRectMake(0, 0, self.secondView.frame.size.width, self.secondView.frame.size.height-150);
            }
            else{
                self.profileTableView.frame=CGRectMake(0, 0, self.secondView.frame.size.width, self.secondView.frame.size.height);
            }
            self.profileTableView.delegate=self;
            self.profileTableView.dataSource=self;
            self.profileTableView.backgroundColor=[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)176/255 blue:(CGFloat)176/255 alpha:1.0];
            
            [self.profileTableView setShowsVerticalScrollIndicator:NO];
            [self.secondView addSubview:self.profileTableView];
            
        }
    }



#pragma mark- profile button action

-(void)profileButtonClick:(UIButton*)sender{
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

-(void)yesButtonAction:(id)sender{
    [imageScroll removeFromSuperview];
    [view removeFromSuperview];
    [tagLine removeFromSuperview];
    [imageCount removeFromSuperview];
    [ProfileName removeFromSuperview];
    [[SingletonClass shareSingleton].encounterUsrImages removeAllObjects];
    [self.refreshActivityIndicator  startAnimating];
    dispatch_async(dispatch_get_global_queue(0, 0),^{
        [self likeEncounterUser];
        dispatch_async(dispatch_get_main_queue(),^{
            [self callWebServiceForEncounter];
            [self.refreshActivityIndicator stopAnimating];
            [self createScrollUI];
        });
    });
}

-(void)crossButtonAction:(id)sender{
    [imageScroll removeFromSuperview];
    [view removeFromSuperview];
    [tagLine removeFromSuperview];
    [imageCount removeFromSuperview];
    [ProfileName removeFromSuperview];
    [[SingletonClass shareSingleton].encounterUsrImages removeAllObjects];
    [self.refreshActivityIndicator startAnimating];
    dispatch_async(dispatch_get_global_queue(0, 0),^{
        [self disLikeEncounterUser];
        dispatch_async(dispatch_get_main_queue(),^{
            [self callWebServiceForEncounter];
            [self.refreshActivityIndicator stopAnimating];
            [self createScrollUI];
        });
    });
    
    
}


#pragma  mark- animation

-(void)animationMethod:(int)tagValue frame:(CGRect)frame{
    
    
    if((self.parentView.frame.origin.y==0)//|| self.state==YES)
       )//&& self.selectedIndex!=tagValue)
    {
        
        [UIView animateWithDuration:0.5 animations:^{
            self.parentView.frame=frame;//CGRectMake(0, -300, self.screen_width, self.view.frame.size.height);
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
                
                [self createTableView:ff tagvalue: tagValue];
            }
            self.swipe.direction = UISwipeGestureRecognizerDirectionDown;
        }];
        self.state=YES;
    }
    else{
        self.secondView.hidden=YES;
        [UIView animateWithDuration:1 animations:^{
            self.parentView.frame=CGRectMake(0,0 , self.screen_width, self.view.frame.size.height);
            self.secondView.hidden=YES;
            // self.profileTableView.hidden=YES;
            // photoVC.view.hidden=YES;
            // self.creditsTableView.hidden=YES;
            //  superPower.view.hidden=YES;
        } completion:^(BOOL finished) {
            self.swipe.direction=UISwipeGestureRecognizerDirectionUp;
            
        }];
        self.state=NO;
    }    self.selectedIndex=tagValue;
    
}


/*#pragma  mark- animation

-(void)animationMethod:(int)tagValue{
    
    
    if(self.parentView.frame.origin.y==0)
    {
        
        [UIView animateWithDuration:0.5 animations:^{
            self.parentView.frame=CGRectMake(0, -300, self.screen_width, self.view.frame.size.height);
        } completion:^(BOOL finished) {
            CGRect  ff;
            if ([UIScreen mainScreen].bounds.size.height>500) {
                ff=CGRectMake(0, 220, self.view.frame.size.width, 300);
            }
            else{
                ff=CGRectMake(0, 125, self.view.frame.size.width, 450);
            }
            
                [self createTableView:ff tagvalue: tagValue];
            
            
            
            self.swipe.direction = UISwipeGestureRecognizerDirectionDown;
        }];
    }
    else{
        self.secondView.hidden=YES;
        [UIView animateWithDuration:0.5 animations:^{
            self.parentView.frame=CGRectMake(0,0 , self.screen_width, self.view.frame.size.height);
            self.secondView.hidden=YES;
        } completion:^(BOOL finished) {
            self.swipe.direction=UISwipeGestureRecognizerDirectionUp;
            
        }];
        
    }    self.selectedIndex=tagValue;
    
}*/


#pragma mark- table view delegate methods

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   
    return 45;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int rows=0;
    if (tableView==self.profileTableView) {
        if (section==0|| section==1) {
            rows=1;
            return rows;
        }
        else if(section==2)
        {
            rows=(int)self.sectionTwoData.count;
            return rows;
        }
        
    }
    
    return rows;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier=@"cell";
    NSString * facebook_img,* side_arrow,* awards,*super_powers;
    
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
        if(indexPath.section==0)
        {
            if(indexPath.row==0)
            {
                for(int i=0;i<4;i++)
                {
                    UIImageView * imgView=[[UIImageView alloc]init];
                    imgView.frame=CGRectMake(10+(i*50), 5, 50, 40);
                    imgView.image=[UIImage imageNamed:awards];
                    imgView.layer.cornerRadius=12;
                    imgView.clipsToBounds=YES;
                    [cell.contentView addSubview:imgView];
                }
                UIImageView * image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:side_arrow]];
                cell.accessoryView=image;
            }
        }
        
        
        
        if (indexPath.section==2) {
            if (indexPath.row!=0) {
                
                //cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                UIImageView * image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:side_arrow]];
                cell.accessoryView=image;
            }
            cell.textLabel.text=[self.sectionTwoData  objectAtIndex:indexPath.row];
            cell.imageView.image=[UIImage imageNamed:[NSString stringWithString:[self.sectionTwoImages objectAtIndex:indexPath.row]]];
         
            if (indexPath.row==0) {
                cell.detailTextLabel.numberOfLines=0;
                cell.detailTextLabel.lineBreakMode=NSLineBreakByCharWrapping;
                cell.detailTextLabel.text=_location;
            }
            if (indexPath.row==1) {
                cell.detailTextLabel.numberOfLines=0;
                cell.detailTextLabel.lineBreakMode=NSLineBreakByCharWrapping;
                cell.detailTextLabel.text=_about;
            }
            if (indexPath.row==5) {
                cell.detailTextLabel.text=_living;
                
            }
            if (indexPath.row==2) {
                cell.detailTextLabel.text=_relationship;
            }
            if (indexPath.row==3) {
                cell.detailTextLabel.text=_sexuality;
            }
            if (indexPath.row==4) {
                cell.detailTextLabel.numberOfLines=0;
                cell.detailTextLabel.lineBreakMode=NSLineBreakByCharWrapping;
            }
            if (indexPath.row==6) {
                cell.detailTextLabel.text=_kids;
            }
            if (indexPath.row==7) {
                cell.detailTextLabel.text=_smoking;
            }
            if (indexPath.row==8) {
                cell.detailTextLabel.text=_drinking;
            }
            if (indexPath.row==9) {
                cell.detailTextLabel.text=_eduaction;
            }
            if (indexPath.row==10) {
                cell.detailTextLabel.numberOfLines=0;
                cell.detailTextLabel.lineBreakMode=NSLineBreakByCharWrapping;
                cell.detailTextLabel.text=_languages;
            }
            if (indexPath.row==11) {
                cell.detailTextLabel.numberOfLines=0;
                cell.detailTextLabel.lineBreakMode=NSLineBreakByCharWrapping;
                cell.detailTextLabel.text=_profession;
            }
            if (indexPath.row==12) {
                
            }
        }
        if (indexPath.section==1) {
            if (indexPath.row==0) {
                cell.textLabel.text=@"Inetrests";
                cell.imageView.image=[UIImage imageNamed:@"interest_icon.png"];
            }
        }
    
       // return  cell;
    }

       return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return row_hh;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    int sections;
    if (tableView==self.profileTableView) {
        sections=4;
        return sections;
    }
    
    return sections;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString * str;
    if (tableView==self.profileTableView) {
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
        
    }
    return  str;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0;
    
}

#pragma -mark callWebServiceForEncounter

-(void)callWebServiceForEncounter{
    NSError * error;
    NSURLResponse * urlResponse;
    int count;
    NSString * withWhom,*hereFor;
    
    NSString * urlStr,*body;
    NSString * fisrtRun=[[NSUserDefaults standardUserDefaults]objectForKey:@"firstRun"];
    if (!fisrtRun) {
    if ([SingletonClass shareSingleton].sex==0) {
        [SingletonClass shareSingleton].enwithWhom=@"1";
    }
    else{
        [SingletonClass shareSingleton].enwithWhom=@"0";
    }
    if ([SingletonClass shareSingleton].hereFor==0) {
        [SingletonClass shareSingleton].enhereFor =@"1";
    }
    else if ([SingletonClass shareSingleton].hereFor==1)
    {
        [SingletonClass shareSingleton].enhereFor=@"2";
    }
    else{
        [SingletonClass shareSingleton].enhereFor=@"3";
    }
   
        
         /*urlStr=[NSString stringWithFormat:@"http://taka.dating/mobile/encounters/%@/%@/%@/%@/%@/%@",[SingletonClass shareSingleton].userID,[SingletonClass shareSingleton].enhereFor,[SingletonClass shareSingleton].enwithWhom,@"18",@"80",@"0"];*/
        body=[NSString stringWithFormat:@"userId=%@&hereto=%@&withwho=%@&startage=%@&endage=%@&count=%@",[SingletonClass shareSingleton].userID,[SingletonClass shareSingleton].enhereFor,[SingletonClass shareSingleton].enwithWhom,@"18",@"80",@"0"];
        
        [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"firstRun"];
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"count"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [SingletonClass shareSingleton].enFromAge=@"18";
        [SingletonClass shareSingleton].enEndAge=@"80";
    }
    else{
        NSString * countStr=[[NSUserDefaults standardUserDefaults]objectForKey:@"count"];
        count=[countStr intValue];
        NSLog(@"count %d",count);
        count+=1;
        countStr =[NSString stringWithFormat:@"%d",count];
        [[NSUserDefaults standardUserDefaults]setObject:countStr forKey:@"count"];
        [[NSUserDefaults standardUserDefaults]synchronize];

    /* urlStr=[NSString stringWithFormat:@"http://taka.dating/mobile/encounters/%@/%@/%@/%@/%@/%d",[SingletonClass shareSingleton].userID,[SingletonClass shareSingleton].enhereFor,[SingletonClass shareSingleton].enwithWhom,[SingletonClass shareSingleton].enFromAge,[SingletonClass shareSingleton].enEndAge,count];*/
        
        body=[NSString stringWithFormat:@"userId=%@&hereto=%@&withwho=%@&startage=%@&endage=%@&count=%d",[SingletonClass shareSingleton].userID,[SingletonClass shareSingleton].enhereFor,[SingletonClass shareSingleton].enwithWhom,[SingletonClass shareSingleton].enFromAge,[SingletonClass shareSingleton].enEndAge,count];
        
    }
   // urlStr =[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url=[NSURL URLWithString:@"http://23.238.24.26/mobi/encounter"];
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
   
    [request setHTTPMethod:@"POST"];
    
    
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[body dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (data==nil) {
        NSLog(@"No data available");
        return;
    }
    
    id enParse=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"parse of encounter %@",enParse);
    
    [SingletonClass shareSingleton].encounterUsrImages=[[NSMutableArray alloc]init];
    if ([[enParse objectForKey:@"code"]isEqualToNumber:[NSNumber numberWithInt:200]] ) {
        NSArray * imageArr=[enParse objectForKey:@"userImages"];
        if (imageArr.count>1) {
            return;
        }
        else{
            NSMutableDictionary * imagesDict=[[NSMutableDictionary alloc]init];
            for (int i=0; i<imageArr.count; i++) {
                imagesDict=[imageArr objectAtIndex:i];
                _imageId=[imagesDict objectForKey:@"imageId"];
                [[SingletonClass shareSingleton].encounterUsrImages addObject:[NSString stringWithFormat:@"http://taka.dating/%@",[imagesDict objectForKey:@"imageLink"]]];
            }
        }
        
        NSArray * userProfile=[enParse objectForKey:@"userProfile"];
        if (userProfile.count<1||imageArr.count>1) {
            return;
        }
        else{
            NSMutableDictionary * userInfo=[[NSMutableDictionary alloc]init];
            for (int k=0;k<userProfile.count;k++) {
                userInfo=[userProfile objectAtIndex:k];
                [[SingletonClass shareSingleton].encounterUsrImages addObject:[NSString stringWithFormat:@"http://taka.dating/%@",[userInfo objectForKey:@"thumbanailUrl"]]];
               
                 _sex=[userInfo objectForKey:@"sex"];
                _userHereFor=[userInfo objectForKey:@"hereFor"];
                _useriId=[userInfo objectForKey:@"userId"];
                _displayName=[userInfo objectForKey:@"displayName"];
                _about=[userInfo objectForKey:@"about"];
                _location=[userInfo objectForKey:@"location"];
                _interestedIn=[userInfo objectForKey:@"interestedIn"];
                _bodyType=[self getbodyType:[userInfo objectForKey:@"bodyType"]];
                _hairColor=[self getHairColor:[userInfo objectForKey:@"hairColor"]];
                _eyeColor=[self getEyeColor:[userInfo objectForKey:@"eyeColor"]];
                _height=[userInfo objectForKey:@"height"];
                _weight=[userInfo objectForKey:@"weight"];
                _living=[self getLiving:[userInfo objectForKey:@"living"]];
                _kids=[self getKids:[userInfo objectForKey:@"kids"]];
                _smoking=[self getSmoking:[userInfo objectForKey:@"smoking"]];
                _drinking=[self getDrinking:[userInfo objectForKey:@"drinking"]];
                _eduaction=[self getEducation:[userInfo objectForKey:@"education"]];
                _income=[self getIncome:[userInfo objectForKey:@"income"]];
                _relationship=[self getRelationship:[userInfo objectForKey:@"relationshipStatus"]];
                _sexuality=[self getSexuality:[userInfo objectForKey:@"sexuality"]];
                _languages=[userInfo objectForKey:@"languagesKnown"];
                if ([[userInfo objectForKey:@"profession"]isEqualToString:@"0"]) {
                    _profession=@"";
                }
                else{
                    _profession=[userInfo objectForKey:@"profession"];
                }
                NSArray * intrestArr=[enParse objectForKey:@"userInterests"];
                
//                NSMutableDictionary * dictInt=[[NSMutableDictionary alloc]init];
//                for (int j=0; j<intrestArr.count; j++) {
//                  dictInt=[intrestArr objectAtIndex:j];
//                    _intrests=[dictInt objectForKey:@"userInterests"];
//                    
//                    
//                }
            }
        }
        
    }
}

-(NSString * )getSexuality:(NSString *)value
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



-(NSString *)getRelationship:(NSString *)value{
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



-(NSString *)getIncome:(NSString *)value{
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



-(NSString *)getEducation:(NSString *)value{
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


-(NSString *)getDrinking:(NSString *)value{
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



-(NSString *)getSmoking:(NSString *)value{
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



-(NSString *)getKids:(NSString *)value{
    int val= value.intValue;
    NSString * kid=@"";
    if (val==0) {
        kid=@"Unfilled yet";
    }
    else if(val==1)
    {
        kid=@"No, Never";
    }
    else if(val==2)
    {
        kid=@"Someday";
    }
    else if(val==3)
    {
        kid=@"Already Have";
    }
    else
    {
        kid=@"Empty nest";
    }
    return kid;
}




-(NSString *)getLiving:(NSString *)value{
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


-(NSString *)getEyeColor:(NSString *)value{
    NSString * str=@"";
    
    int val= value.intValue;
    if (val==0) {
        str=@"others";
    }
    else if(val==1)
    {
        str=@"Brown";
    }
    else if(val==2)
    {
        str=@"Grey";
    }
    else if(val==3)
    {
        str=@"Green";
    }
    else if(val==4)
    {
        str=@"Blue";
    }
    else if(val==5)
    {
        str=@"Hazel";
    }
    else
    {
        str=@"Other";
    }
    
    return str;
    
}



-(NSString *)getHairColor:(NSString *)value{
    NSString * str=@"";
    
    int val= value.intValue;
    if (val==0) {
        str=@"Unfilled yet";
    }
    else if(val==1)
    {
        str=@"Black";
    }
    else if(val==2)
    {
        str=@"Brown";
    }
    else if(val==3)
    {
        str=@"Red";
    }
    else if(val==4)
    {
        str=@"Grey";
    }
    else if(val==5)
    {
        str=@"White";
    }
    else if(val==6)
    {
        str=@"Shaved";
    }
    else if(val==7)
    {
        str=@"Dyed";
    }
    else
    {
        str=@"Bald";
    }
    
    
    return str;
    
}



-(NSString *)getbodyType:(NSString *)bodytyp{
    NSString * str=@"";
    if ([bodytyp isEqualToString:@"0"]) {
        str=@"Unfilled yet";
    }
    else if([bodytyp isEqualToString:@"1"])
    {
        str=@"Average";
    }
    else if([bodytyp isEqualToString:@"2"])
    {
        str=@"A few extra pounds";
    }
    else if([bodytyp isEqualToString:@"3"])
    {
        str=@"Slim";
    }
    else if([bodytyp isEqualToString:@"4"])
    {
        str=@"Athletic";
    }
    else if([bodytyp isEqualToString:@"5"])
    {
        str=@"Muscular";
    }
    else{
        str=@"Big and beautiful";

    }
    return  str;
}


#pragma mark- disLikeEncounterUser web service

-(void)disLikeEncounterUser{
    
    NSError * error=nil;
    NSURLResponse * urlResponse=nil;
    
    
   /* NSString * urlStr=[NSString stringWithFormat:@"http://taka.dating/mobile/dislike/%@/%@/%@",[SingletonClass shareSingleton].userID,_useriId,_imageId];
    urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url=[NSURL URLWithString:urlStr];*/
    
    NSString * urlStr=@"http://23.238.24.26/mobi/mobi-dislike";
    NSURL * url=[NSURL URLWithString:urlStr];
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSString * body=[NSString stringWithFormat:@"userIdDisLikedBy=%@&userIdDisLikedTo=%@&imageId=%@",[SingletonClass shareSingleton].userID,_useriId,_imageId];
    [request setHTTPBody:[body dataUsingEncoding:NSASCIIStringEncoding  allowLossyConversion:YES]];
    
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (data==nil) {
        return;
    }
    id parse=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"Parse of Dislike usrer %@",parse);
    
}

#pragma mark- Like user in encounter

-(void)likeEncounterUser{
    NSError * error=nil;
    NSURLResponse * urlResponse=nil;
    [[SingletonClass shareSingleton].encounterUsrImages removeAllObjects];
    
    /*NSString * urlStr=[NSString stringWithFormat:@"http://taka.dating/mobile/like/%@/%@/%@",[SingletonClass shareSingleton].userID,_useriId,_imageId];
    urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];*/
    NSString * urlStr=@"http://23.238.24.26/mobi/mobi-like";
    NSURL * url=[NSURL URLWithString:urlStr];
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSString * body=[NSString stringWithFormat:@"userIdLikesBy=%@&userIdLikesTo=%@&imageId=%@",[SingletonClass shareSingleton].userID,_useriId,_imageId];
    [request setHTTPBody:[body dataUsingEncoding:NSASCIIStringEncoding  allowLossyConversion:YES]];

    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (data==nil) {
        return;
    }
    id parse=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    NSLog(@"Parse of like usrer %@",parse);


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
