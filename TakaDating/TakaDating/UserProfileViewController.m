//
//  UserProfileViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 29/01/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import "UserProfileViewController.h"

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
    self.titleLabel.text = @"Name";
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
    
    self.screen_width=[UIScreen mainScreen].bounds.size.width;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        row_hh=80;
        height=75;
        self.sectionTwoData=[NSArray arrayWithObjects:@"Location",@"About Me",@"Relationship",@"Sexuality",@"Appearence",@"Living",@"Children",@"Smoking",@"Drinking",@"Education",@"I Speak",@"I Work as", nil];
        self.sectionTwoImages=[NSArray arrayWithObjects:@"location.png",@"about_me_ipad.png",@"interested_in_ipad.png",@"relationship_ipad.png",@"sexuality_ipad.png",@"apperance_ipad.png",@"living_ipad.png",@"kids_ipad.png",@"smoking_ipad.png",@"drinking_ipad.png",@"education_ipad.png",@"language_ipad.png",@"work_ipad.png", nil];
    }
    else{
        height=55;
        row_hh=40;
        self.sectionTwoData=[NSArray arrayWithObjects:@"Location",@"About Me",@"Relationship",@"Sexuality",@"Appearence",@"Living",@"Children",@"Smoking",@"Drinking",@"Education",@"I Speak",@"I Work as", nil];
        self.sectionTwoImages=[NSArray arrayWithObjects:@"location.png",@"about_me.png",@"add_interest.png",@"relationship.png",@"sexuality.png",@"apperance.png",@"living.png",@"kids.png",@"smoking.png",@"drinking.png",@"education.png",@"language.png",@"work.png", nil];
    }
    [self createUI];
    [self createScrollUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-creatUI
-(void)createUI{
    
    self.screen_width=[UIScreen mainScreen].bounds.size.width;
    if(!self.parentView)
    {
        self.parentView=[[UIView alloc]init];
        self.parentView.frame=[UIScreen mainScreen].bounds;
        
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            self.parentView.frame=CGRectMake(0, 75, windowSize.width, windowSize.height-80);
            self.parentView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"profile_screen_bg_ipad.png"]];
        }
        else{
            if ([UIScreen mainScreen].bounds.size.height>500) {
                self.parentView.frame=CGRectMake(0, 55, windowSize.width, self.view.frame.size.height-80);
            }
            else{
                self.parentView.frame=CGRectMake(0, 55, windowSize.width, self.view.frame.size.height-175);
            }
            self.parentView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"profile_screen_bg.png"]];
           // self.parentView.backgroundColor=[UIColor yellowColor];
        }
        
        
        [self.view addSubview:self.parentView];
    }
    self.parentView.hidden=NO;
    
    
    
    
    if(!self.tabView)
    {
        self.tabView=[[UIView alloc]init];
        self.tabView.backgroundColor=[UIColor clearColor];
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            self.tabView.frame=CGRectMake(0, self.parentView.frame.size.height-80, windowSize.width, 80);
        }
        else{
            if([UIScreen mainScreen].bounds.size.height>500)
            {
                self.tabView.frame=CGRectMake(0, 465, 320, 50);
            }
            else{
                self.tabView.frame=CGRectMake(0, self.parentView.frame.size.height-50, 320, 50);
            }
        }
        CAGradientLayer * tabLayer=[CAGradientLayer layer];
       tabLayer.frame=CGRectMake(0, 0, self.tabView.frame.size.width, self.tabView.frame.size.height);
        UIColor * firstColor=[UIColor colorWithRed:(CGFloat)38/255 green:(CGFloat)38/255 blue:(CGFloat)38/255 alpha:1.0];
        UIColor  * secondColor=[UIColor colorWithRed:(CGFloat)0/255 green:(CGFloat)0/255 blue:(CGFloat)0/255 alpha:1.0];
        tabLayer.colors=[NSArray arrayWithObjects:(id)[firstColor CGColor],(id)[secondColor CGColor], nil];
        [self.tabView.layer insertSublayer:tabLayer atIndex:0];

        
       // self.tabView.backgroundColor=[UIColor blackColor];
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
    [photosBtn setImage:[UIImage imageNamed:@"yes.png"] forState:UIControlStateNormal];
    //[photosBtn addTarget:self action:@selector(photoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    photosBtn.tag=2;
    [self.tabView addSubview:photosBtn];
    
    UIButton * CreditsBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    // [CreditsBtn setTitle:@"Credits" forState:UIControlStateNormal];
    
    CreditsBtn.titleLabel.font=[UIFont boldSystemFontOfSize:9];
    [CreditsBtn setImage:[UIImage imageNamed:@"chat_blue_bg.png"] forState:UIControlStateNormal];
    CreditsBtn.tag=3;
    //  [CreditsBtn addTarget:self action:@selector(superPowerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
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
        
        [photosBtn setImage:[UIImage imageNamed:@"yes_ipad.png"] forState:UIControlStateNormal];
        [CreditsBtn setImage:[UIImage imageNamed:@"chat_blue_bg_ipad.png"] forState:UIControlStateNormal];
        // [OffBtn setImage:[UIImage imageNamed:@"off_icon_grey_ipad.png"] forState:UIControlStateNormal];
        
        
        profile.frame=CGRectMake(windowSize.width/2-300, 10, 60, 50);
        photosBtn.frame=CGRectMake(windowSize.width/2-30, 10, 50, 50);
        CreditsBtn.frame=CGRectMake(windowSize.width/2+220, 10, 50, 50);
        //OffBtn.frame=CGRectMake(windowSize.width-100, 10, 50, 50);
    }
    else{
        profile.frame=CGRectMake(windowSize.width-280, 10, 60, 30);
        photosBtn.frame=CGRectMake(windowSize.width-180, 10, 50, 30);
        CreditsBtn.frame=CGRectMake(windowSize.width-100, 10, 50, 30);
        // OffBtn.frame=CGRectMake(windowSize.width-55, 10, 50, 30);
        
    }
    
    
}

#pragma mark-scrollImageView

-(void)createScrollUI{
    
    NSArray * images1=[NSArray arrayWithObjects:@"imag1.jpg",@"imag2.jpg",nil];
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
        
        profileImg.image=[UIImage imageNamed:[NSString stringWithString:[images1 objectAtIndex:i]]];
        // profileImg.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",]];
        [imageScroll addSubview:profileImg];
    }
    imageScroll.contentSize=CGSizeMake(imageScroll.frame.size.width*2, imageScroll.frame.size.height);
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
    imageCount.text=[NSString stringWithFormat:@"1/2"];
    [self.parentView addSubview:imageCount];
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

-(void)handleSwipeGesture:(UISwipeGestureRecognizer *)swipe{
    
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
    //UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    UITableViewCell * cell=[tableView cellForRowAtIndexPath:indexPath];
    if(!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    //cell.imageView.image=[UIImage imageNamed:@"crm.png"];
    cell.textLabel.font=[UIFont boldSystemFontOfSize:12];
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
        }
        if (indexPath.section==1) {
            if (indexPath.row==0) {
                cell.textLabel.text=@"Inetrests";
                cell.imageView.image=[UIImage imageNamed:@"interest_icon.png"];
            }
        }
        
        return  cell;
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







-(void)profileCancelButtonAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
