//
//  UserProfileViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 29/01/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import "UserProfileViewController.h"
#import "SingletonClass.h"
#import "UIImageView+WebCache.h"
#import "MessageDetailViewController.h"
#import "XMPPFramework.h"
#import "AppDelegate.h"
#import "XMPPJID.h"
#import "XMPPRoster.h"


@interface UserProfileViewController ()
{
    UIImageView * profileImg;
}
@end



@implementation UserProfileViewController

- (void)viewDidLoad {
    windowSize=[UIScreen mainScreen].bounds.size;
    
    [super viewDidLoad];
    
    UIView * headerview=[[UIView alloc]init];
    headerview.frame=CGRectMake(0, 0, windowSize.width, 55);
    [self.view addSubview:headerview];
   
    
    self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, windowSize.width, headerview.frame.size.height);
    UIColor *firstColor = [UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
    UIColor *secColor = [UIColor colorWithRed:(CGFloat)121/255 green:(CGFloat)2/255 blue:(CGFloat)0/255 alpha:1.0];
    layer.colors = [NSArray arrayWithObjects:(id)[firstColor CGColor],(id)[secColor CGColor], nil];
    [headerview.layer insertSublayer:layer atIndex:0];
  
    headerview.layer.shadowRadius = 5.0;
    headerview.layer.shadowColor = [UIColor blackColor].CGColor;
    headerview.layer.shadowOpacity = 0.6;
    headerview.layer.shadowOffset = CGSizeMake(0.0f,5.0f);
    headerview.layer.shadowPath = [UIBezierPath bezierPathWithRect:headerview.bounds].CGPath;
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, windowSize.width-200, 35)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.text = @"";
    [headerview addSubview:self.titleLabel];
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
    [self.cancelButton addTarget:self action:@selector(profileCancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerview addSubview:self.cancelButton];
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        layer.frame=CGRectMake(0, 0, windowSize.width, 75);
        self.titleLabel.frame=CGRectMake(windowSize.width/2-100, 25, windowSize.width/2-200, 40);
        self.cancelButton.frame = CGRectMake(windowSize.width/2-350, 25, 120, 35);
        self.cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:30];
    }
    
    self.sectionTwoImages=[NSArray arrayWithObjects:@"location.png",@"about_me.png",@"relationship.png",@"sexuality.png",@"apperance.png",@"living.png",@"kids.png",@"smoking.png",@"drinking.png",@"education.png",@"language.png",@"work.png", nil];
    
    CGRect ff;
    self.screen_width=[UIScreen mainScreen].bounds.size.width;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        row_hh=80;
        height=75;
        self.sectionTwoData=[NSArray arrayWithObjects:@"Location",@"About Me",@"Relationship",@"Sexuality",@"Appearence",@"Living",@"Children",@"Smoking",@"Drinking",@"Education",@"I Speak",@"I Work as", nil];
        self.sectionTwoImages=[NSArray arrayWithObjects:@"location_ipad.png",@"about_me_ipad.png",@"interested_in_ipad.png",@"relationship_ipad.png",@"sexuality_ipad.png",@"apperance_ipad.png",@"living_ipad.png",@"kids_ipad.png",@"smoking_ipad.png",@"drinking_ipad.png",@"education_ipad.png",@"language_ipad.png",@"work_ipad.png", nil];
        ff=CGRectMake(windowSize.width/2-30, 180, 40, 40);
    }
    else{
        height=55;
        row_hh=40;
        self.sectionTwoData=[NSArray arrayWithObjects:@"Location",@"About Me",@"Relationship",@"Sexuality",@"Appearence",@"Living",@"Children",@"Smoking",@"Drinking",@"Education",@"I Speak",@"I Work as", nil];
        self.sectionTwoImages=[NSArray arrayWithObjects:@"location.png",@"about_me.png",@"add_interest.png",@"relationship.png",@"sexuality.png",@"apperance.png",@"living.png",@"kids.png",@"smoking.png",@"drinking.png",@"education.png",@"language.png",@"work.png", nil];
      ff=CGRectMake(140, 180, 40, 40);
    }
    
    self.refreshActivityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:ff];
    
    self.refreshActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    
    self.refreshActivityIndicator.color = [UIColor blackColor];
    
    [self.view addSubview:self.refreshActivityIndicator];
    [self.view bringSubviewToFront:self.refreshActivityIndicator];
    self.refreshActivityIndicator.alpha = 1.0;
 [self.refreshActivityIndicator startAnimating];
        [self callRefreshControl];
    
    
   
    // Do any additional setup after loading the view from its nib.
}
-(void)callRefreshControl{
    dispatch_async(dispatch_get_global_queue(0, 0),^{
       
        [self callWebService];
        dispatch_async(dispatch_get_main_queue(),^{
            [self.refreshActivityIndicator stopAnimating];
            [self createUI];
            [self createScrollUI];
        });
    });

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-creatUI
-(void)createUI{
    self.titleLabel.text=_displayName;
    self.screen_width=[UIScreen mainScreen].bounds.size.width;
    if(!self.parentView)
    {
        self.parentView=[[UIView alloc]init];
        self.parentView.frame=[UIScreen mainScreen].bounds;
        
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            self.parentView.frame=CGRectMake(0, 75, windowSize.width, windowSize.height-25);
            self.parentView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"profile_screen_bg_ipad.png"]];
        }
        else{
            if ([UIScreen mainScreen].bounds.size.height>500) {
                self.parentView.frame=CGRectMake(0, 55, windowSize.width, self.view.frame.size.height);
            }
            else{
                 self.parentView.frame=CGRectMake(0,height ,self.screen_width, self.view.frame.size.height);
                //self.parentView.frame=CGRectMake(0, 55, windowSize.width, self.view.frame.size.height-80);
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
  //  [photosBtn addTarget:self action:@selector(yesButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    photosBtn.tag=2;
    [self.tabView addSubview:photosBtn];
    
    UIButton * CreditsBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    // [CreditsBtn setTitle:@"Credits" forState:UIControlStateNormal];
    
    CreditsBtn.titleLabel.font=[UIFont boldSystemFontOfSize:9];
    [CreditsBtn setImage:[UIImage imageNamed:@"chat_blue_bg.png"] forState:UIControlStateNormal];
    CreditsBtn.tag=3;
    [CreditsBtn addTarget:self action:@selector(chatButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
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
        [CreditsBtn setImage:[UIImage imageNamed:@"chat_blue_bg_ipad.png"] forState:UIControlStateNormal];
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
    
    //NSArray * images1=[NSArray arrayWithObjects:@"imag1.jpg",@"imag2.jpg",nil];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        imageScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.parentView.frame.size.width, self.parentView.frame.size.height-150)];
    }
    else{
        if ([UIScreen mainScreen].bounds.size.height>500) {
            
            imageScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.parentView.frame.size.width, self.parentView.frame.size.height-100)];
        }
        else{
            imageScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.parentView.frame.size.width, self.parentView.frame.size.height-100)];
            
        }
    }
    imageScroll.pagingEnabled=YES;
    imageScroll.delegate=self;
    [imageScroll setShowsHorizontalScrollIndicator:NO];
    [self.parentView addSubview:imageScroll];
    for (int i=0; i<2; i++) {
        
        
        CGFloat x = i * self.view.frame.size.width;
        profileImg=[[UIImageView alloc]init];
        if ([UIScreen mainScreen].bounds.size.height<500) {
            profileImg.frame=CGRectMake(x, 0, imageScroll.frame.size.width, imageScroll.frame.size.height);
        }
        else{
            profileImg.frame=CGRectMake(x, 0, imageScroll.frame.size.width, imageScroll.frame.size.height);
        }
        profileImg.userInteractionEnabled=YES;
        [profileImg setImageWithURL:[NSURL URLWithString:self.imageUrl]];
        //profileImg.image=[UIImage imageNamed:[NSString stringWithString:[images1 objectAtIndex:i]]];
        // profileImg.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",]];
        [imageScroll addSubview:profileImg];
    }
    imageScroll.contentSize=CGSizeMake(imageScroll.frame.size.width*1, imageScroll.frame.size.height);
    [self.parentView addSubview:imageScroll];
    
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(10, 20, 50, 25)];
    view.backgroundColor=[UIColor grayColor];
    view.layer.cornerRadius=5;
    view.clipsToBounds=YES;
    [self.parentView addSubview:view];
    
    UIImageView * imgVw=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 15)];
    imgVw.image=[UIImage imageNamed:@"photo_icon.png"];
    [view addSubview:imgVw];
    
    imageCount=[[UILabel alloc]initWithFrame:CGRectMake(40, 20, 25, 25)];
    imageCount.textColor=[UIColor whiteColor];
    imageCount.font=[UIFont systemFontOfSize:12];
    imageCount.text=[NSString stringWithFormat:@"1/1"];
    [self.parentView addSubview:imageCount];
}


#pragma mark- scroll delegate methods

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    page=page+1;
    imageCount.text=[NSString stringWithFormat:@"%d/1",page];
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

#pragma mark- gesutre recognizer

-(void)handleSwipeGesture:(UISwipeGestureRecognizer *)swipe{
    
    NSLog(@"%f",self.parentView.frame.origin.y);
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        CGRect frame=CGRectMake(0, -windowSize.width/2, windowSize.width, windowSize.height);
        [self swipeGesture:frame];
    }
    else{
        CGRect frame;
        if (windowSize.height<500) {
              frame=CGRectMake(0, -250, windowSize.width, windowSize.height);
        }
        else{
              frame=CGRectMake(0, -300, windowSize.width, windowSize.height);
        }
       
        [self swipeGesture:frame];
    }
    
}

-(void)swipeGesture:(CGRect)frame{
    if(self.parentView.frame.origin.y==height)
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
                    ff=CGRectMake(0, 220, windowSize.width, 350);
                }
                else{
                    ff=CGRectMake(0, 180, windowSize.width, 450);
                }
            }
            int tagValue=1;
            [self createTableView:ff tagvalue: tagValue];
            self.swipe.direction = UISwipeGestureRecognizerDirectionDown;
        }];
    }
    else{
        
        [UIView animateWithDuration:0.5 animations:^{
            self.parentView.frame=CGRectMake(0,height ,self.screen_width, self.view.frame.size.height);
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
        if (UIUserInterfaceIdiomPad==UI_USER_INTERFACE_IDIOM()) {
            self.profileTableView.frame=CGRectMake(0, 0, self.secondView.frame.size.width, self.secondView.frame.size.height+50);
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
        if (windowSize.height<500) {
            frame=CGRectMake(0, -250, windowSize.width, windowSize.height);
        }
        else{
            frame=CGRectMake(0, -300, windowSize.width, windowSize.height);
        }
    }
    
    
    [self animationMethod:tagValue frame:(CGRect)frame];
}


#pragma  mark- animation

-(void)animationMethod:(int)tagValue frame:(CGRect)frame{
    
    
    if((self.parentView.frame.origin.y==height)//|| self.state==YES)
       )//&& self.selectedIndex!=tagValue)
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
            CGRect  ff;
            if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
                ff=CGRectMake(0, windowSize.height/2+55, windowSize.width,(windowSize.height-windowSize.height/2-80));
            }
            else{
                
                if ([UIScreen mainScreen].bounds.size.height>500) {
                    ff=CGRectMake(0, 220, windowSize.width, 350);
                }
                else{
                    ff=CGRectMake(0, 180, windowSize.width, 450);
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
        [UIView animateWithDuration:0.5 animations:^{
            self.parentView.frame=CGRectMake(0,height , self.screen_width, self.view.frame.size.height);
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





/*-(void)handleSwipeGesture:(UISwipeGestureRecognizer *)swipe{
 
    NSLog(@"%f",self.parentView.frame.origin.y);
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        CGRect frame=CGRectMake(0, -windowSize.width/2, windowSize.width, windowSize.height);
        [self swipeGesture:frame];
    }
    else{
        CGRect frame=CGRectMake(0, -200, windowSize.width, windowSize.height);
        
        [self swipeGesture:frame];
    }
}

-(void)swipeGesture:(CGRect)frame{
    if(self.parentView.frame.origin.y==height)
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
                ff=CGRectMake(0, windowSize.height/2+80, windowSize.width,(windowSize.height-windowSize.height/2+100));
            }
            else{
                
                if ([UIScreen mainScreen].bounds.size.height>500) {
                    ff=CGRectMake(0, 220, windowSize.width, 300);
                }
                else{
                   ff=CGRectMake(0, 220, self.view.frame.size.width, 450);
                }
            }
            int tagValue=1;
            [self createTableView:ff tagvalue: tagValue];
            self.swipe.direction = UISwipeGestureRecognizerDirectionDown;
        }];
    }
    else{
        
        [UIView animateWithDuration:0.5 animations:^{
            self.parentView.frame=CGRectMake(0,height ,self.screen_width, self.view.frame.size.height);
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
            self.profileTableView.frame=CGRectMake(0, 100, self.secondView.frame.size.width, self.secondView.frame.size.height-20);
        }
        self.profileTableView.delegate=self;
        self.profileTableView.dataSource=self;
        self.profileTableView.backgroundColor=[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)176/255 blue:(CGFloat)176/255 alpha:1.0];
        
        [self.profileTableView setShowsVerticalScrollIndicator:NO];
        [self.secondView addSubview:self.profileTableView];
        
    }
}



#pragma mark- profile button action

-(void)profileButtonClick:(id)sender{
    int tagValue=(int)[sender tag];
    CGRect frame;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        frame=CGRectMake(0, -windowSize.width/2, windowSize.width, windowSize.height);
    }
    else{
        frame=CGRectMake(0, -200, windowSize.width, windowSize.height);
    }
      [self animationMethod:tagValue frame:(CGRect)frame];
}

#pragma  mark- animation

-(void)animationMethod:(int)tagValue frame:(CGRect)frame{
    
    
    if((self.parentView.frame.origin.y==height)//|| self.state==YES)
       )//&& self.selectedIndex!=tagValue)
    {
        
        [UIView animateWithDuration:0.5 animations:^{
            self.parentView.frame=frame;//CGRectMake(0, -300, self.screen_width, self.view.frame.size.height);
        } completion:^(BOOL finished) {
            CGRect  ff;
            if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
                ff=CGRectMake(0, windowSize.height/2+80, windowSize.width,(windowSize.height-windowSize.height/2+100));
            }
            else{
                
                if ([UIScreen mainScreen].bounds.size.height>500) {
                    ff=CGRectMake(0, 220, self.view.frame.size.width, 300);
                }
                else{
                    ff=CGRectMake(0, 220, self.view.frame.size.width, 450);
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
        [UIView animateWithDuration:0.5 animations:^{
            self.parentView.frame=CGRectMake(0,height , self.screen_width, self.view.frame.size.height);
            self.secondView.hidden=YES;
        } completion:^(BOOL finished) {
            self.swipe.direction=UISwipeGestureRecognizerDirectionUp;
            
        }];
        self.state=NO;
    }    self.selectedIndex=tagValue;
    
}*/

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
        UITableViewCell * cell=[tableView cellForRowAtIndexPath:indexPath];
    if(!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
   
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
         cell.textLabel.font=[UIFont boldSystemFontOfSize:22];
        cell.detailTextLabel.font=[UIFont systemFontOfSize:20];
    }
    else{
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
                    imgView.image=[UIImage imageNamed:@"award.png"];
                    imgView.layer.cornerRadius=12;
                    imgView.clipsToBounds=YES;
                    [cell.contentView addSubview:imgView];
                }
                UIImageView * image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"side_arrow.png"]];
                cell.accessoryView=image;
            }
        }
        
        
        
        if (indexPath.section==2) {
            if (indexPath.row!=0) {
                
                //cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                UIImageView * image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"side_arrow.png"]];
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
                cell.detailTextLabel.text=_appearance;
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
                if (interests.count>0) {
                    int y=0;
                    int x=0;
                    UIView * backView=[[UIView alloc]init];
                    backView.frame=CGRectMake(0, 0,cell.frame.size.width, cell.contentView.frame.size.height);
                    
                    [cell.contentView addSubview:backView];
                    
                    if (interests.count>6) {
                        //[self createInterestUI:5 indexpath:indexPath];
                        
                        for (int i=0;i<4;i++) {
                            
                            UIButton * btn1=[[UIButton alloc]init];
                            btn1.frame=CGRectMake(20, 0+i*50, cell.contentView.frame.size.width/2-40, 40);
                           [btn1 setTitle:[NSString stringWithFormat:@"%@",[interests objectAtIndex:i+i]] forState:UIControlStateNormal];
                            [btn1 setBackgroundColor:[UIColor clearColor]];
                            btn1.layer.borderColor=[UIColor lightGrayColor].CGColor;
                            btn1.layer.borderWidth=0.7;
                            btn1.layer.cornerRadius=7;
                            btn1.clipsToBounds=YES;
                            [btn1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                            [backView addSubview:btn1];
                            
                            UIButton * btn2=[[UIButton alloc]init];
                            btn2.frame=CGRectMake(cell.contentView.frame.size.width/2+20, 0+i*50, cell.contentView.frame.size.width/2-40, 40);
                            [btn2 setTitle:[NSString stringWithFormat:@"%@",[interests objectAtIndex:i+1]] forState:UIControlStateNormal];
                            [btn2 setBackgroundColor:[UIColor clearColor]];
                            btn2.layer.borderColor=[UIColor lightGrayColor].CGColor;
                            [btn2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                            btn2.layer.borderWidth=0.7;
                            btn2.layer.cornerRadius=7;
                            btn2.clipsToBounds=YES;
                            [backView addSubview:btn2];
                            
                        }
                        
                    }
                    else{
                        
                        int y=0;
                        int x=0;
                        
                        
                        for (int i=0;i<interests.count;i++) {
                            UIButton * btn1=[[UIButton alloc]init];
                            btn1.frame=CGRectMake(20, 0+i*50, cell.contentView.frame.size.width/2-40, 40);
                           [btn1 setTitle:[NSString stringWithFormat:@"%@",[interests objectAtIndex:i]] forState:UIControlStateNormal];
                            [btn1 setBackgroundColor:[UIColor clearColor]];
                            btn1.layer.borderColor=[UIColor lightGrayColor].CGColor;
                            btn1.layer.borderWidth=0.7;
                            btn1.layer.cornerRadius=7;
                            btn1.clipsToBounds=YES;
                            [btn1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                            [backView addSubview:btn1];
                            
                            UIButton * btn2=[[UIButton alloc]init];
                            btn2.frame=CGRectMake(cell.contentView.frame.size.width/2+20, 0+i*50, cell.contentView.frame.size.width/2-40, 40);
                             [btn2 setTitle:[NSString stringWithFormat:@"%@",[interests objectAtIndex:i]] forState:UIControlStateNormal];
                            [btn2 setBackgroundColor:[UIColor clearColor]];
                            btn2.layer.borderColor=[UIColor lightGrayColor].CGColor;
                            [btn2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                            btn2.layer.borderWidth=0.7;
                            btn2.layer.cornerRadius=7;
                            btn2.clipsToBounds=YES;
                            [backView addSubview:btn2];
                            
                            
                            y=40;
                            x=cell.contentView.frame.size.width/2+20;
                        }
                    }
                }
                else{
                    cell.textLabel.text=@"Inetrests";
                    cell.imageView.image=[UIImage imageNamed:@"interest_icon.png"];
                }

            }
        }
        
        return  cell;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        if (!interests.count) {
            return  row_hh;
        }
        return  200;
    }
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


#pragma  mark- Web service
-(void)callWebService{
    NSError * error;
    NSURLResponse * urlResponse;
    
    NSURL * url=[NSURL URLWithString:@"http://23.238.24.26/mobi/profile-details"];
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSString * body=[NSString stringWithFormat:@"userId=%@&loggedId=%@",self.index,[SingletonClass shareSingleton].userID];
    
    [request setHTTPBody:[body dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (data==nil) {
        return;
    }
    id parse=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"json response of user details %@",parse);
    if ([[parse objectForKey:@"code"]isEqualToNumber:[NSNumber numberWithInt:200]]) {
        
    
    NSMutableDictionary * json=[NSMutableDictionary dictionary];
        json=[parse objectForKey:@"userprofile"];
    self.imageUrl=[NSString stringWithFormat:@"http://taka.dating/%@",[json objectForKey:@"thumbanailUrl"]];
    
    _sex=[json objectForKey:@"sex"];
   // _userHereFor=[json objectForKey:@"hereFor"];
    _useriId=[json objectForKey:@"userId"];
    _displayName=[json objectForKey:@"displayName"];
    _about=[json objectForKey:@"about"];
    _location=[json objectForKey:@"location"];
    _interestedIn=[json objectForKey:@"interestedIn"];
    _bodyType=[self getbodyType:[json objectForKey:@"bodyType"]];
    _hairColor=[self getHairColor:[json objectForKey:@"hairColor"]];
    _eyeColor=[self getEyeColor:[json objectForKey:@"eyeColor"]];
    _height=[json objectForKey:@"height"];
    _weight=[json objectForKey:@"weight"];
    _living=[self getLiving:[json objectForKey:@"living"]];
    _kids=[self getKids:[json objectForKey:@"kids"]];
    _smoking=[self getSmoking:[json objectForKey:@"smoking"]];
    _drinking=[self getDrinking:[json objectForKey:@"drinking"]];
    _eduaction=[self getEducation:[json objectForKey:@"education"]];
    _income=[self getIncome:[json objectForKey:@"income"]];
    _relationship=[self getRelationship:[json objectForKey:@"relationshipStatus"]];
    _sexuality=[self getSexuality:[json objectForKey:@"sexuality"]];
    _languages=[json objectForKey:@"languagesKnown"];
    if ([[json objectForKey:@"profession"]isEqualToString:@"0"]) {
        _profession=@"";
    }
    else{
        _profession=[json objectForKey:@"profession"];
    }
         _appearance=[NSString stringWithFormat:@"Heighr:%@ Weight%@ Bodytype:%@ Eyecolor:%@ Haircolor:%@",_height,_weight,_bodyType,_eyeColor,_hairColor ];
        interests=[parse objectForKey:@"interestList"];

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




#pragma mark- cancel button
-(void)profileCancelButtonAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark- Chat 
-(void)chatButtonAction:(UIButton*)sender{
    
    MessageDetailViewController * mdVC=[[MessageDetailViewController alloc]initWithNibName:@"MessageDetailViewController" bundle:nil];
    if ([SingletonClass shareSingleton].fromChat==YES) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        [self addBuddy];
        [self.navigationController pushViewController:mdVC animated:YES];
    }
}

-(AppDelegate*)appdelegate{
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}

-(XMPPRoster*)xmppRoster{
    return [[self appdelegate]xmppRoster];
}


-(void)addBuddy{
    
  /*  NSString * jid=[NSString stringWithFormat:@"%@@takadating.com",_useriId];
    XMPPJID *newBuddy = [XMPPJID jidWithString:jid];
    [self.xmppRoster addUser:newBuddy withNickname:@""];*/
    
    NSError * error=nil;
    NSURLResponse * urlResponse=nil;
    
    NSURL * postUrl=[NSURL URLWithString:@"http://takadating.com:9090/plugins/userService/userservice"];
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:postUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSString * body=[NSString stringWithFormat:@"type=add_roster&secret=3U3vCIjx&username=%@&item_jid=%@@takadating.com&name=%@&subscription=3",[SingletonClass shareSingleton].userID,_useriId,_displayName];
    [request setHTTPBody:[body dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (data==nil) {
        return;
    }
    id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"%@",json);
   

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
