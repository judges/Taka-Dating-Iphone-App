//
//  SuperPowerProfileViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 06/12/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "SuperPowerProfileViewController.h"

@interface SuperPowerProfileViewController ()

@end

@implementation SuperPowerProfileViewController

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
    
    windowSize=[UIScreen mainScreen].bounds.size;
    self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, self.view.frame.size.width, 55);
    UIColor *firstColor = [UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
    UIColor *secColor = [UIColor colorWithRed:(CGFloat)121/255 green:(CGFloat)2/255 blue:(CGFloat)0/255 alpha:1.0];
    layer.colors = [NSArray arrayWithObjects:(id)[firstColor CGColor],(id)[secColor CGColor], nil];
    [self.view.layer insertSublayer:layer atIndex:0];
    
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.frame=CGRectMake(windowSize.width/2-60, 20, self.view.frame.size.width-200, 35);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.text = @"Super Power";
    [self.view addSubview:self.titleLabel];
    //Add Cancel BUTTON
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.frame = CGRectMake(windowSize.width/2-145, 25, 60, 25);
    [self.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    self.cancelButton.layer.borderColor = [UIColor redColor].CGColor;
    self.cancelButton.layer.borderWidth = 0.7;
    self.cancelButton.layer.cornerRadius = 4;
    self.cancelButton.clipsToBounds = YES;
    [self.cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cancelButton];
    
//    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
//        frame_Topview=CGRectMake(0, 120, scroll.frame.size.width, 480);
//        button_hight=63;
//        distance_bw_Btns=20;
//        fontSize=15;
//        sectionFont_size=20;
//        image=@"setting_btn_bg_ipad.png";
//        chatImage=@"chat_popular_user_ipad.png";
//        beFirtImage=@"be_the_first_ipad.png";
//        likeImage=@"people_who_like_ipad.png";
//        whoAdded=@"favorite_ipad.png";
//    }
//    else{
//        chatImage=@"chat_popular_user.png";
//        beFirtImage=@"be_the_first.png";
//        likeImage=@"people_who_like.png";
//        whoAdded=@"favorite.png";
//        fontSize=9;
//        sectionFont_size=13;
//        frame_Topview=CGRectMake(0, 120, scroll.frame.size.width, 340);
//        button_hight=30;
//        distance_bw_Btns=0;
//        image=@"setting_btn_bg.png";
//    }

    
    
    
    [self createUI];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)createUI{
    
    UIScrollView * scroll=[[UIScrollView alloc]init];
    scroll.frame=CGRectMake(0, 55, self.view.frame.size.width, self.view.frame.size.height);
    scroll.backgroundColor=[UIColor clearColor];
    [self.view addSubview:scroll];
    
    scroll.contentSize=CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*1.6);
    
//    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
//        frame_Topview=CGRectMake(0, 120, scroll.frame.size.width, 480);
//        button_hight=63;
//        distance_bw_Btns=20;
//        fontSize=15;
//        sectionFont_size=20;
//        image=@"setting_btn_bg_ipad.png";
//        chatImage=@"chat_popular_user_ipad.png";
//        beFirtImage=@"be_the_first_ipad.png";
//        likeImage=@"people_who_like_ipad.png";
//        whoAdded=@"favorite_ipad.png";
//    }
//    else{
//        chatImage=@"chat_popular_user.png";
//        beFirtImage=@"be_the_first.png";
//        likeImage=@"people_who_like.png";
//        whoAdded=@"favorite.png";
//        fontSize=9;
//        sectionFont_size=13;
//        frame_Topview=CGRectMake(0, 120, scroll.frame.size.width, 340);
//        button_hight=30;
//        distance_bw_Btns=0;
//        image=@"setting_btn_bg.png";
//    }

    
    
    
    
    UIView * topView=[[UIView alloc]init];
    topView.frame=CGRectMake(0, 120, self.view.frame.size.width, 340);
    topView.backgroundColor=[UIColor whiteColor];
    topView.layer.cornerRadius=5;
    topView.clipsToBounds=YES;
    [scroll addSubview:topView];
    
    //Free
    UIButton * tryFree=[UIButton buttonWithType:UIButtonTypeCustom];
    tryFree.frame=CGRectMake(windowSize.width/2-80, 5, 167, 32);
    tryFree.layer.cornerRadius=5;
    tryFree.clipsToBounds=YES;
    [tryFree setTitle:@"Try for free" forState:UIControlStateNormal];
    [tryFree setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tryFree setBackgroundColor:[UIColor orangeColor]];
    [tryFree addTarget:self action:@selector(tryFreeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:tryFree];
    
    UILabel * invite=[[UILabel alloc]init];
    invite.frame=CGRectMake(windowSize.width/2-100, 45, 200, 15);
    invite.font=[UIFont systemFontOfSize:12];
    invite.textAlignment=NSTextAlignmentCenter;
    invite.text=@"Invite your friends to Taka";
    [topView addSubview:invite];
    
    
    //Three months
    UIButton * threeMonths=[UIButton buttonWithType:UIButtonTypeCustom];
    threeMonths.frame=CGRectMake(windowSize.width/2-80, 70, 167, 32);
    threeMonths.layer.cornerRadius=5;
    threeMonths.clipsToBounds=YES;
    [threeMonths setTitle:@"3 months at 450.00 INR/month" forState:UIControlStateNormal];
    [threeMonths setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
   // [threeMonths setBackgroundColor:[UIColor blueColor]];
    [threeMonths setBackgroundImage:[UIImage imageNamed:@"setting_btn_bg.png"] forState:UIControlStateNormal];
    [topView addSubview:threeMonths];
    
    UIButton * threeMonthBtn=[[UIButton alloc]init];
    threeMonthBtn.frame=CGRectMake(windowSize.width/2-80, 110, 70, 10);
    [threeMonthBtn setTitle:@"Save 18%" forState:UIControlStateNormal];
    threeMonthBtn.layer.borderColor=[UIColor blackColor].CGColor;
    threeMonthBtn.layer.borderWidth=0.3;
    threeMonthBtn.titleLabel.font=[UIFont systemFontOfSize:10];
    [threeMonthBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    threeMonthBtn.clipsToBounds=YES;
    threeMonthBtn.layer.cornerRadius=4;
    threeMonthBtn.backgroundColor=[UIColor lightGrayColor];
    [topView addSubview:threeMonthBtn];
    
    UILabel * threeMonthsLbl=[[UILabel alloc]init];
    threeMonthsLbl.frame=CGRectMake(windowSize.width/2, 110, 200, 10);
    threeMonthsLbl.font=[UIFont systemFontOfSize:10];
    threeMonthsLbl.text=@"1,350.00 INR in total";
    [topView addSubview:threeMonthsLbl];
    
    //One month
    UIButton * oneMonths=[UIButton buttonWithType:UIButtonTypeCustom];
    oneMonths.frame=CGRectMake(windowSize.width/2-80, 140, 167, 32);
    oneMonths.layer.cornerRadius=5;
    oneMonths.clipsToBounds=YES;
    [oneMonths setTitle:@"1 months at 550.00 INR/month" forState:UIControlStateNormal];
    [oneMonths setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [oneMonths setBackgroundImage:[UIImage imageNamed:@"setting_btn_bg.png"] forState:UIControlStateNormal];
    [topView addSubview:oneMonths];
    
    UILabel * oneMonthLbl=[[UILabel alloc]init];
    oneMonthLbl.frame=CGRectMake(windowSize.width/2, 180, 200, 10);
    oneMonthLbl.font=[UIFont systemFontOfSize:10];
    oneMonthLbl.text=@"550.00 INR in total";
    [topView addSubview:oneMonthLbl];
    
    
    //Six month
    
    UIButton * sixMonths=[UIButton buttonWithType:UIButtonTypeCustom];
    sixMonths.frame=CGRectMake(windowSize.width/2-80, 205, 167, 32);
    sixMonths.layer.cornerRadius=5;
    sixMonths.clipsToBounds=YES;
    [sixMonths setTitle:@"6 months at 341.67 INR/month" forState:UIControlStateNormal];
    [sixMonths setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sixMonths setBackgroundImage:[UIImage imageNamed:@"setting_btn_bg.png"] forState:UIControlStateNormal];
    [topView addSubview:sixMonths];
    
    UIButton * sixMonthBtn=[[UIButton alloc]init];
    sixMonthBtn.frame=CGRectMake(windowSize.width/2-80, 250, 70, 10);
    [sixMonthBtn setTitle:@"Save 38%" forState:UIControlStateNormal];
    sixMonthBtn.layer.borderColor=[UIColor blackColor].CGColor;
    sixMonthBtn.layer.borderWidth=0.3;
    sixMonthBtn.titleLabel.font=[UIFont systemFontOfSize:10];
    [sixMonthBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    sixMonthBtn.clipsToBounds=YES;
    sixMonthBtn.layer.cornerRadius=4;
    sixMonthBtn.backgroundColor=[UIColor lightGrayColor];
    [topView addSubview:sixMonthBtn];
    
    UILabel * sixMonthLbl=[[UILabel alloc]init];
    sixMonthLbl.frame=CGRectMake(windowSize.width/2, 250, 200, 10);
    sixMonthLbl.font=[UIFont systemFontOfSize:10];
    sixMonthLbl.text=@"2050.00 INR in total";
    [topView addSubview:sixMonthLbl];
    
    
    //One Year
    UIButton * oneYear=[UIButton buttonWithType:UIButtonTypeCustom];
    oneYear.frame=CGRectMake(windowSize.width/2-80, 270, 167, 32);
    oneYear.layer.cornerRadius=5;
    oneYear.clipsToBounds=YES;
    [oneYear setTitle:@"12 months at 283.33 INR/month" forState:UIControlStateNormal];
    [oneYear setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [oneYear setBackgroundImage:[UIImage imageNamed:@"setting_btn_bg.png"] forState:UIControlStateNormal];
    [topView addSubview:oneYear];
    
    
    UIButton * oneYearBtn=[[UIButton alloc]init];
    oneYearBtn.frame=CGRectMake(windowSize.width/2-80, 310, 70, 10);
    [oneYearBtn setTitle:@"Save 48%" forState:UIControlStateNormal];
    oneYearBtn.layer.borderColor=[UIColor blackColor].CGColor;
    oneYearBtn.layer.borderWidth=0.3;
    oneYearBtn.titleLabel.font=[UIFont systemFontOfSize:10];
    [oneYearBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    oneYearBtn.clipsToBounds=YES;
    oneYearBtn.layer.cornerRadius=4;
    oneYearBtn.backgroundColor=[UIColor lightGrayColor];
    [topView addSubview:oneYearBtn];
    
    
    UILabel * oneYearLbl=[[UILabel alloc]init];
    oneYearLbl.frame=CGRectMake(windowSize.width/2, 310, 200, 10);
    oneYearLbl.font=[UIFont systemFontOfSize:10];
    oneYearLbl.text=@"3400.00 INR in total";
    [topView addSubview:oneYearLbl];
    
    
    UILabel * sectionTwo=[[UILabel alloc]init];
    sectionTwo.frame=CGRectMake(10, 470, 200, 30);
    sectionTwo.text=@"What you get:";
    sectionTwo.font=[UIFont boldSystemFontOfSize:13];
    [scroll addSubview:sectionTwo];
    
    
    UIView * bottomView=[[UIView alloc]init];
    bottomView.frame=CGRectMake(0, 500, self.view.frame.size.width, 225);
    bottomView.backgroundColor=[UIColor whiteColor];
    bottomView.layer.cornerRadius=5;
    bottomView.clipsToBounds=YES;
    [scroll addSubview:bottomView];
    
    UIImageView * imgView1=[[UIImageView alloc]init];
    imgView1.image=[UIImage imageNamed:@"chat_popular_user.png"];
    imgView1.frame=CGRectMake(0, 5, bottomView.frame.size.width, 50);
    [bottomView addSubview:imgView1];
    
    UIImageView * imgView2=[[UIImageView alloc]init];
    imgView2.image=[UIImage imageNamed:@"be_the_first.png"];
    imgView2.frame=CGRectMake(0, 60, bottomView.frame.size.width, 50);
    [bottomView addSubview:imgView2];
    
    UIImageView * imgView3=[[UIImageView alloc]init];
    imgView3.image=[UIImage imageNamed:@"people_who_like.png"];
    imgView3.frame=CGRectMake(0, 115, bottomView.frame.size.width, 50);
    [bottomView addSubview:imgView3];
    
    UIImageView * imgView4=[[UIImageView alloc]init];
    imgView4.image=[UIImage imageNamed:@"favorite.png"];
    imgView4.frame=CGRectMake(0, 170, bottomView.frame.size.width, 50);
    [bottomView addSubview:imgView4];
    
    UILabel * chatLabel=[[UILabel alloc]init];
    chatLabel.frame=CGRectMake(90, 5, 160, 15);
    chatLabel.text=@"Chat with popular user";
    chatLabel.font=[UIFont boldSystemFontOfSize:10];
    [imgView1 addSubview:chatLabel];
    
    UILabel * chatLabel2=[[UILabel alloc]init];
    chatLabel2.frame=CGRectMake(90, 17, 160, 30);
    chatLabel2.lineBreakMode=NSLineBreakByCharWrapping;
    chatLabel2.numberOfLines=0;
    chatLabel2.font=[UIFont systemFontOfSize:10];
    chatLabel2.text=@"Get exclusive access to the most popular on Taka.";
    [imgView1 addSubview:chatLabel2];
    
    UILabel * beTheFirst=[[UILabel alloc]init];
    beTheFirst.frame=CGRectMake(90, 5, 160, 15);
    beTheFirst.text=@"Be the first";
    beTheFirst.font=[UIFont boldSystemFontOfSize:10];
    [imgView2 addSubview:beTheFirst];
    
    UILabel * beTheFirst2=[[UILabel alloc]init];
    beTheFirst2.frame=CGRectMake(90, 17, 160, 30);
    beTheFirst2.lineBreakMode=NSLineBreakByCharWrapping;
    beTheFirst2.numberOfLines=0;
    beTheFirst2.font=[UIFont systemFontOfSize:10];
    beTheFirst2.text=@"Start chatting with people from the moment they start.";
    [imgView2 addSubview:beTheFirst2];
    
    UILabel * like=[[UILabel alloc]init];
    like.frame=CGRectMake(90, 5, 160, 15);
    like.text=@"People who like you";
    like.font=[UIFont boldSystemFontOfSize:10];
    [imgView3 addSubview:like];
    
    UILabel * like2=[[UILabel alloc]init];
    like2.frame=CGRectMake(90, 17, 160, 30);
    like2.lineBreakMode=NSLineBreakByCharWrapping;
    like2.numberOfLines=0;
    like2.font=[UIFont systemFontOfSize:10];
    like2.text=@"See everyone who voted 'Yes' for you in Encounters.";
    [imgView3 addSubview:like2];
    
    
    UILabel * favorite=[[UILabel alloc]init];
    favorite.frame=CGRectMake(90, 5, 160, 15);
    favorite.text=@"Who added  you as a Favorite.";
    favorite.font=[UIFont boldSystemFontOfSize:10];
    [imgView4 addSubview:favorite];
    
    UILabel * favorite2=[[UILabel alloc]init];
    favorite2.frame=CGRectMake(90, 17, 160, 30);
    favorite2.lineBreakMode=NSLineBreakByCharWrapping;
    favorite2.numberOfLines=0;
    favorite2.font=[UIFont systemFontOfSize:10];
    favorite2.text=@"See  everyone who added you as a Favorite.";
    [imgView4 addSubview:favorite2];
    
//    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
//        
//        
//        tryFree.frame=CGRectMake(topView.frame.size.width/2-150, 5, 328, button_hight);
//        invite.frame=CGRectMake(self.view.frame.size.width/2-110, topView.frame.size.height-400, 250, 20);
//        
//        threeMonths.frame=CGRectMake(self.view.frame.size.width/2-150, topView.frame.size.height-380, 328, button_hight);
//        threeMonthBtn.frame=CGRectMake(self.view.frame.size.width/2-110, topView.frame.size.height-310, 100, 20);
//        threeMonthsLbl.frame=CGRectMake(self.view.frame.size.width/2, topView.frame.size.height-310, 200, 20);
//        oneMonths.frame=CGRectMake(self.view.frame.size.width/2-150, topView.frame.size.height-290, 328, button_hight);
//        oneMonthLbl.frame=CGRectMake(self.view.frame.size.width/2, topView.frame.size.height-220, 200, 20);
//        sixMonths.frame=CGRectMake(self.view.frame.size.width/2-150, topView.frame.size.height-200, 328, button_hight);
//        sixMonthBtn.frame=CGRectMake(self.view.frame.size.width/2-110, topView.frame.size.height-120, 100, 20);
//        sixMonthLbl.frame=CGRectMake(self.view.frame.size.width/2, topView.frame.size.height-120, 200, 20);
//        oneYear.frame=CGRectMake(topView.frame.size.width/2-150, topView.frame.size.height-100, 328, button_hight);
//        oneYearBtn.frame=CGRectMake(self.view.frame.size.width/2-110, topView.frame.size.height-20, 100, 20);
//        oneYearLbl.frame=CGRectMake(self.view.frame.size.width/2,topView.frame.size.height-20, 200, 20);
//        
//        
//        sectionTwo.frame=CGRectMake(10, scroll.frame.size.height+180, 200, 50);
//        bottomView.frame=CGRectMake(0,scroll.frame.size.height+230, self.view.frame.size.width, 450);
//        
//        
//        
//        imgView1.frame=CGRectMake(self.view.frame.size.width/2-180, 10, 460, 80);
//        imgView2.frame=CGRectMake(self.view.frame.size.width/2-180,110, 460, 80);
//        imgView3.frame=CGRectMake(self.view.frame.size.width/2-180, 210, 460, 80);
//        imgView4.frame=CGRectMake(self.view.frame.size.width/2-180, 310, 460, 80);
//        
//        
//        
//        chatLabel.frame=CGRectMake(self.view.frame.size.width/2-200, 10, 250, 20);
//        chatLabel2.frame=CGRectMake(self.view.frame.size.width/2-200, 25, 250, 40);
//        beTheFirst.frame=CGRectMake(self.view.frame.size.width/2-200, 10, 250, 20);
//        beTheFirst2.frame=CGRectMake(self.view.frame.size.width/2-200, 25, 250, 40);
//        like.frame=CGRectMake(self.view.frame.size.width/2-200, 10, 250, 20);
//        like2.frame=CGRectMake(self.view.frame.size.width/2-200, 25, 250, 40);
//        favorite.frame=CGRectMake(self.view.frame.size.width/2-200, 10, 250, 20);
//        favorite2.frame=CGRectMake(self.view.frame.size.width/2-200, 25, 250, 40);
//        
//        
//    }
//
    
    
}
#pragma  mark- Button actions

-(void)tryFreeButtonAction:(id)sender{
    if (spFree) {
        spFree=nil;
    }
    spFree=[[SuperPowerFreeViewController alloc]initWithNibName:@"SuperPowerFreeViewController" bundle:nil];
    appdalegate =[UIApplication sharedApplication].delegate ;
    [appdalegate.window addSubview:spFree.view];
}


#pragma mark Cancel button

-(void)cancelButtonAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    //[[[[[UIApplication sharedApplication]keyWindow]subviews]lastObject]removeFromSuperview];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
