//
//  SuperPowerViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 03/12/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "SuperPowerViewController.h"
#import "SingletonClass.h"

@interface SuperPowerViewController ()

@end

@implementation SuperPowerViewController
/*- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}*/


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        //        if (!frame) {
        //            return nil;
        //        }
        
        [SingletonClass shareSingleton].frame = frame;
        
    }
    return self;
}


- (void)viewDidLoad
{
    self.view.userInteractionEnabled=NO;
    [super viewDidLoad];
    continent=[self findContinent ];
    self.view.frame=[SingletonClass shareSingleton].frame;
    NSLog(@"self.view %f",self.view.frame.size.height);
   // self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    
    self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)148/255 blue:(CGFloat)214/255 alpha:1.0];
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, self.view.frame.size.width, 55);
    UIColor *firstColor = [UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
    UIColor *secColor = [UIColor colorWithRed:(CGFloat)121/255 green:(CGFloat)2/255 blue:(CGFloat)0/255 alpha:1.0];
    layer.colors = [NSArray arrayWithObjects:(id)[firstColor CGColor],(id)[secColor CGColor], nil];
    //[self.view.layer insertSublayer:layer atIndex:0];
    [self.navigationController.navigationBar.layer insertSublayer:layer atIndex:0];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, self.view.frame.size.width-200, 35)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.text = @"Super Power";
    [self.navigationController.navigationBar addSubview:self.titleLabel];
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
    [self.navigationController.navigationBar addSubview:self.cancelButton];

    [self createUI];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)createUI{
    
    UIScrollView * scroll=[[UIScrollView alloc]init];
    scroll.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    CGRect frame_Topview;
    NSString * image,* chatImage,* beFirtImage,*likeImage,* whoAdded ;
    CGFloat button_hight,distance_bw_Btns,fontSize,sectionFont_size;;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        frame_Topview=CGRectMake(0, 120, scroll.frame.size.width, 480);
        button_hight=63;
        distance_bw_Btns=20;
        fontSize=15;
        sectionFont_size=20;
        image=@"setting_btn_bg_ipad.png";
        chatImage=@"chat_popular_user_ipad.png";
        beFirtImage=@"be_the_first_ipad.png";
        likeImage=@"people_who_like_ipad.png";
        whoAdded=@"favorite_ipad.png";
    }
    else{
        chatImage=@"chat_popular_user.png";
        beFirtImage=@"be_the_first.png";
        likeImage=@"people_who_like.png";
        whoAdded=@"favorite.png";
        fontSize=9;
        sectionFont_size=13;
        frame_Topview=CGRectMake(0, 120, scroll.frame.size.width, 340);
        button_hight=30;
        distance_bw_Btns=0;
        image=@"setting_btn_bg.png";
    }
    
    scroll.backgroundColor=[UIColor clearColor];
    [self.view addSubview:scroll];
    
    scroll.contentSize=CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*2.5);
    
    UIView * topView=[[UIView alloc]init];
    topView.frame=frame_Topview;
    topView.backgroundColor=[UIColor whiteColor];
    topView.layer.cornerRadius=5;
    topView.clipsToBounds=YES;
    [scroll addSubview:topView];
    
   //Free
  /*  UIButton * tryFree=[UIButton buttonWithType:UIButtonTypeCustom];
       tryFree.layer.cornerRadius=15;
    tryFree.clipsToBounds=YES;
    [tryFree setTitle:@"Try for free" forState:UIControlStateNormal];
    [tryFree setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tryFree setBackgroundColor:[UIColor orangeColor]];
    [tryFree addTarget:self action:@selector(tryFreeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    tryFree.titleLabel.font=[UIFont systemFontOfSize:fontSize];
    [topView addSubview:tryFree];
    
    UILabel * invite=[[UILabel alloc]init];
    
    invite.font=[UIFont systemFontOfSize:fontSize];
    invite.textAlignment=NSTextAlignmentCenter;
    invite.text=@"Invite your friends to Taka";
    [topView addSubview:invite];
    */
    
    //Three months
    UIButton * threeMonths=[UIButton buttonWithType:UIButtonTypeCustom];
    
    threeMonths.layer.cornerRadius=5;
    threeMonths.clipsToBounds=YES;
    [threeMonths setTitle:@"3 months " forState:UIControlStateNormal];
    [threeMonths setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [threeMonths setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:image]]];
    threeMonths.titleLabel.font=[UIFont systemFontOfSize:fontSize];
    [threeMonths addTarget:self action:@selector(callPayPalPaymentMethod:) forControlEvents:UIControlEventTouchUpInside];
    threeMonths.tag=200;
    [topView addSubview:threeMonths];
    
    UIButton * threeMonthBtn=[[UIButton alloc]init];
    
    [threeMonthBtn setTitle:@"Save 18%" forState:UIControlStateNormal];
    threeMonthBtn.layer.borderColor=[UIColor blackColor].CGColor;
    threeMonthBtn.layer.borderWidth=0.3;
    threeMonthBtn.titleLabel.font=[UIFont systemFontOfSize:fontSize];
    [threeMonthBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    threeMonthBtn.clipsToBounds=YES;
    threeMonthBtn.layer.cornerRadius=4;
    threeMonthBtn.backgroundColor=[UIColor lightGrayColor];
    
    [topView addSubview:threeMonthBtn];
    
    UILabel * threeMonthsLbl=[[UILabel alloc]init];
    
    threeMonthsLbl.font=[UIFont systemFontOfSize:fontSize];
    threeMonthsLbl.text=@"1,35.00 INR in total";
    [topView addSubview:threeMonthsLbl];
    
    //One month
    UIButton * oneMonths=[UIButton buttonWithType:UIButtonTypeCustom];
    
    oneMonths.layer.cornerRadius=5;
    oneMonths.clipsToBounds=YES;
    [oneMonths setTitle:@"1 months " forState:UIControlStateNormal];
    [oneMonths setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [oneMonths setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:image]]];
     oneMonths.titleLabel.font=[UIFont systemFontOfSize:fontSize];
    [oneMonths addTarget:self action:@selector(callPayPalPaymentMethod:) forControlEvents:UIControlEventTouchUpInside];
    oneMonths.tag=100;
    [topView addSubview:oneMonths];
    
    UILabel * oneMonthLbl=[[UILabel alloc]init];
    
    oneMonthLbl.font=[UIFont systemFontOfSize:fontSize];
    oneMonthLbl.text=@"550.00 INR in total";
    [topView addSubview:oneMonthLbl];
    
    
    //Six month
    
    UIButton * sixMonths=[UIButton buttonWithType:UIButtonTypeCustom];
    
    sixMonths.layer.cornerRadius=5;
    sixMonths.clipsToBounds=YES;
    [sixMonths setTitle:@"6 months " forState:UIControlStateNormal];
    [sixMonths setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sixMonths setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:image]]];
    sixMonths.titleLabel.font=[UIFont systemFontOfSize:fontSize];
    [sixMonths addTarget:self action:@selector(callPayPalPaymentMethod:) forControlEvents:UIControlEventTouchUpInside];
     sixMonths.tag=300;
    [topView addSubview:sixMonths];
    
    UIButton * sixMonthBtn=[[UIButton alloc]init];
    
    [sixMonthBtn setTitle:@"Save 38%" forState:UIControlStateNormal];
    sixMonthBtn.layer.borderColor=[UIColor blackColor].CGColor;
    sixMonthBtn.layer.borderWidth=0.3;
    sixMonthBtn.titleLabel.font=[UIFont systemFontOfSize:fontSize];
    [sixMonthBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    sixMonthBtn.clipsToBounds=YES;
    sixMonthBtn.layer.cornerRadius=4;
    sixMonthBtn.backgroundColor=[UIColor lightGrayColor];
    
    [topView addSubview:sixMonthBtn];
    
    UILabel * sixMonthLbl=[[UILabel alloc]init];
    
    sixMonthLbl.font=[UIFont systemFontOfSize:fontSize];
    sixMonthLbl.text=@"2050.00 INR in total";
    [topView addSubview:sixMonthLbl];
    
    
    //One Year
    UIButton * oneYear=[UIButton buttonWithType:UIButtonTypeCustom];
   
    oneYear.layer.cornerRadius=5;
    oneYear.titleLabel.font=[UIFont systemFontOfSize:fontSize];
    oneYear.clipsToBounds=YES;
    [oneYear setTitle:@"12 months " forState:UIControlStateNormal];
    [oneYear setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [oneYear setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:image]]];
    [oneYear addTarget:self action:@selector(callPayPalPaymentMethod:) forControlEvents:UIControlEventTouchUpInside];
     oneYear.tag=400;
    [topView addSubview:oneYear];
    
    
    UIButton * oneYearBtn=[[UIButton alloc]init];
   
    [oneYearBtn setTitle:@"Save 48%" forState:UIControlStateNormal];
    oneYearBtn.layer.borderColor=[UIColor blackColor].CGColor;
    oneYearBtn.layer.borderWidth=0.3;
     oneYearBtn.titleLabel.font=[UIFont systemFontOfSize:fontSize];
    [oneYearBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    oneYearBtn.clipsToBounds=YES;
    oneYearBtn.layer.cornerRadius=4;
    oneYearBtn.backgroundColor=[UIColor lightGrayColor];
    [topView addSubview:oneYearBtn];

    
    UILabel * oneYearLbl=[[UILabel alloc]init];
    
    oneYearLbl.font=[UIFont systemFontOfSize:fontSize];
    oneYearLbl.text=@"3400.00 INR in total";
    [topView addSubview:oneYearLbl];
    
    
    //===========================================
    
    UILabel * sectionTwo=[[UILabel alloc]init];
     sectionTwo.text=@"What you get:";
    sectionTwo.font=[UIFont boldSystemFontOfSize:sectionFont_size];
    [scroll addSubview:sectionTwo];
    
    
    UIView * bottomView=[[UIView alloc]init];
   
    bottomView.backgroundColor=[UIColor whiteColor];
    bottomView.layer.cornerRadius=5;
    bottomView.clipsToBounds=YES;
    [scroll addSubview:bottomView];
    
    UIImageView * imgView1=[[UIImageView alloc]init];
    imgView1.image=[UIImage imageNamed:chatImage];
    
    //[bottomView addSubview:imgView1];
    
    UIImageView * imgView2=[[UIImageView alloc]init];
    imgView2.image=[UIImage imageNamed:beFirtImage];
   
    [bottomView addSubview:imgView2];
    
    UIImageView * imgView3=[[UIImageView alloc]init];
    imgView3.image=[UIImage imageNamed:likeImage];
    
    [bottomView addSubview:imgView3];
    
    UIImageView * imgView4=[[UIImageView alloc]init];
    imgView4.image=[UIImage imageNamed:whoAdded];
    
    [bottomView addSubview:imgView4];
    
   /* UILabel * chatLabel=[[UILabel alloc]init];
       chatLabel.text=@"Chat with popular user";
    chatLabel.font=[UIFont boldSystemFontOfSize:fontSize];
    [imgView1 addSubview:chatLabel];
    
    UILabel * chatLabel2=[[UILabel alloc]init];
    
    chatLabel2.lineBreakMode=NSLineBreakByCharWrapping;
    chatLabel2.numberOfLines=0;
    chatLabel2.font=[UIFont systemFontOfSize:fontSize];
    chatLabel2.text=@"Get exclusive access to the most popular on Taka.";
    [imgView1 addSubview:chatLabel2];*/
    
    UILabel * beTheFirst=[[UILabel alloc]init];
    
    beTheFirst.text=@"Visitors!";
    beTheFirst.font=[UIFont boldSystemFontOfSize:fontSize];
    [imgView2 addSubview:beTheFirst];
    
    UILabel * beTheFirst2=[[UILabel alloc]init];
   
    beTheFirst2.lineBreakMode=NSLineBreakByCharWrapping;
    beTheFirst2.numberOfLines=0;
    beTheFirst2.font=[UIFont systemFontOfSize:fontSize];
    beTheFirst2.text=@"Check who visited you";
    [imgView2 addSubview:beTheFirst2];

    UILabel * like=[[UILabel alloc]init];
   
    like.text=@"People who like you";
    like.font=[UIFont boldSystemFontOfSize:fontSize];
    [imgView3 addSubview:like];
    
    UILabel * like2=[[UILabel alloc]init];
    
    like2.lineBreakMode=NSLineBreakByCharWrapping;
    like2.numberOfLines=0;
    like2.font=[UIFont systemFontOfSize:fontSize];
    like2.text=@"See everyone who voted 'Yes' for you in Encounters.";
    [imgView3 addSubview:like2];
    
    
    UILabel * favorite=[[UILabel alloc]init];
    
    favorite.text=@"Who added  you as a Favorite.";
    favorite.font=[UIFont boldSystemFontOfSize:fontSize];
    [imgView4 addSubview:favorite];
    
    UILabel * favorite2=[[UILabel alloc]init];
        favorite2.lineBreakMode=NSLineBreakByCharWrapping;
    favorite2.numberOfLines=0;
    favorite2.font=[UIFont systemFontOfSize:fontSize];
    favorite2.text=@"See  everyone who added you as a Favorite.";
    [imgView4 addSubview:favorite2];
    
    
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        
        
     //   tryFree.frame=CGRectMake(topView.frame.size.width/2-150, 5, 328, button_hight);
     //   invite.frame=CGRectMake(self.view.frame.size.width/2-110, topView.frame.size.height-400, 250, 20);

        threeMonths.frame=CGRectMake(self.view.frame.size.width/2-150, topView.frame.size.height-380, 328, button_hight);
        threeMonthBtn.frame=CGRectMake(self.view.frame.size.width/2-110, topView.frame.size.height-310, 100, 20);
        threeMonthsLbl.frame=CGRectMake(self.view.frame.size.width/2, topView.frame.size.height-310, 200, 20);
        oneMonths.frame=CGRectMake(self.view.frame.size.width/2-150, topView.frame.size.height-290, 328, button_hight);
        oneMonthLbl.frame=CGRectMake(self.view.frame.size.width/2, topView.frame.size.height-220, 200, 20);
        sixMonths.frame=CGRectMake(self.view.frame.size.width/2-150, topView.frame.size.height-200, 328, button_hight);
        sixMonthBtn.frame=CGRectMake(self.view.frame.size.width/2-110, topView.frame.size.height-120, 100, 20);
        sixMonthLbl.frame=CGRectMake(self.view.frame.size.width/2, topView.frame.size.height-120, 200, 20);
        oneYear.frame=CGRectMake(topView.frame.size.width/2-150, topView.frame.size.height-100, 328, button_hight);
        oneYearBtn.frame=CGRectMake(self.view.frame.size.width/2-110, topView.frame.size.height-20, 100, 20);
        oneYearLbl.frame=CGRectMake(self.view.frame.size.width/2,topView.frame.size.height-20, 200, 20);
        
        
        sectionTwo.frame=CGRectMake(10, scroll.frame.size.height+180, 200, 50);
        bottomView.frame=CGRectMake(0,scroll.frame.size.height+230, self.view.frame.size.width, 350);

        
        
       // imgView1.frame=CGRectMake(self.view.frame.size.width/2-180, 10, 460, 80);
        imgView2.frame=CGRectMake(self.view.frame.size.width/2-200,10, 460, 80);
        imgView3.frame=CGRectMake(self.view.frame.size.width/2-200, 110, 460, 80);
        imgView4.frame=CGRectMake(self.view.frame.size.width/2-200, 210, 460, 80);

        
        
       // chatLabel.frame=CGRectMake(self.view.frame.size.width/2-200, 10, 250, 20);
      //  chatLabel2.frame=CGRectMake(self.view.frame.size.width/2-200, 25, 250, 40);
        beTheFirst.frame=CGRectMake(self.view.frame.size.width/2-220, 10, 260, 20);
        beTheFirst2.frame=CGRectMake(self.view.frame.size.width/2-220, 25, 260, 40);
        like.frame=CGRectMake(self.view.frame.size.width/2-220, 10, 260, 20);
        like2.frame=CGRectMake(self.view.frame.size.width/2-220, 25, 260, 40);
        favorite.frame=CGRectMake(self.view.frame.size.width/2-220, 10, 260, 20);
        favorite2.frame=CGRectMake(self.view.frame.size.width/2-220, 25, 250, 40);
        
        
    }
    else{
       // invite.frame=CGRectMake(60, 45, 200, 15);
       // tryFree.frame=CGRectMake(topView.frame.size.width/2-80, 5, 168, 30);
        
        threeMonths.frame=CGRectMake(topView.frame.size.width/2-80, 70, 168, button_hight);
        threeMonthBtn.frame=CGRectMake(topView.frame.size.width/2-80, 110, 70, 10);
        threeMonthsLbl.frame=CGRectMake(topView.frame.size.width/2, 110, 200, 10);
        oneMonths.frame=CGRectMake(topView.frame.size.width/2-80, 140,168, button_hight);
        oneMonthLbl.frame=CGRectMake(topView.frame.size.width/2-20, 180, 200, 10);
        sixMonths.frame=CGRectMake(topView.frame.size.width/2-80, 205,168, button_hight);
        sixMonthBtn.frame=CGRectMake(topView.frame.size.width/2-80, 250, 70, 10);
        sixMonthLbl.frame=CGRectMake(topView.frame.size.width/2, 250, 200, 10);
        oneYear.frame=CGRectMake(topView.frame.size.width/2-80, 270, 168, button_hight);
        oneYearBtn.frame=CGRectMake(topView.frame.size.width/2-80, 310, 70, 10);
        oneYearLbl.frame=CGRectMake(topView.frame.size.width/2, 310, 200, 10);
        
        
        sectionTwo.frame=CGRectMake(10, 470, 200, 30);
        bottomView.frame=CGRectMake(0, 500, self.view.frame.size.width, 175);
        
        //imgView1.frame=CGRectMake(0, 5, bottomView.frame.size.width, 50);
         imgView2.frame=CGRectMake(0, 5, bottomView.frame.size.width, 50);
        imgView3.frame=CGRectMake(0, 60, bottomView.frame.size.width, 50);
        imgView4.frame=CGRectMake(0, 115, bottomView.frame.size.width, 50);
        
       // chatLabel.frame=CGRectMake(90, 5, 160, 15);
      //  chatLabel2.frame=CGRectMake(90, 17, 160, 30);
        beTheFirst.frame=CGRectMake(90, 5, 160, 15);
         beTheFirst2.frame=CGRectMake(90, 17, 160, 30);
         like.frame=CGRectMake(90, 5, 160, 15);
        like2.frame=CGRectMake(90, 17, 160, 30);
        favorite.frame=CGRectMake(90, 5, 160, 15);
        favorite2.frame=CGRectMake(90, 17, 160, 30);

    }

    
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
//    [[[[[UIApplication sharedApplication]keyWindow]subviews]lastObject]removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark- find continent
-(NSString*)findContinent{
    NSError * error=nil;
    NSURLResponse * urlResponse=nil;
    
    NSString * urlStr=@"http://www.geoplugin.net/json.gp";
    
    urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url=[NSURL URLWithString:urlStr];
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (data==nil) {
        return nil;
    }
    id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"json for continent %@",json );
    if ([[json objectForKey:@"geoplugin_continentCode"]isEqualToString:@"AS"]) {
        return  [json objectForKey:@"geoplugin_continentCode"];
    }
    else if ([[json objectForKey:@"geoplugin_continentCode"]isEqualToString:@"AF"]) {
        return  [json objectForKey:@"geoplugin_continentCode"];
    }
    else if ([[json objectForKey:@"geoplugin_continentCode"]isEqualToString:@"AM"]) {
        return  [json objectForKey:@"geoplugin_continentCode"];
    }
    else if ([[json objectForKey:@"geoplugin_continentCode"]isEqualToString:@"EU"]) {
        return  [json objectForKey:@"geoplugin_continentCode"];
    }
    else if ([[json objectForKey:@"geoplugin_continentCode"]isEqualToString:@"AUS"]) {
        return  [json objectForKey:@"geoplugin_continentCode"];
    }
    else if ([[json objectForKey:@"geoplugin_continentCode"]isEqualToString:@"SAM"]) {
        return  [json objectForKey:@"geoplugin_continentCode"];
    }
    else{
        return @"";
    }
    
}



#pragma mark PayPalPaymentDelegate methods

- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
    NSLog(@"PayPal Payment Success!");
    //  self.resultText = [completedPayment description];
    [self showSuccess];
    
    [self sendCompletedPaymentToServer:completedPayment]; // Payment was processed successfully; send to server for verification and fulfillment
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    NSLog(@"PayPal Payment Canceled");
    // self.resultText = nil;
    self.successView.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Helpers

- (void)showSuccess {
    self.successView.hidden = NO;
    self.successView.alpha = 1.0f;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:2.0];
    self.successView.alpha = 0.0f;
    [UIView commitAnimations];
}

#pragma mark Proof of payment validation

- (void)sendCompletedPaymentToServer:(PayPalPayment *)completedPayment {
    // TODO: Send completedPayment.confirmation to server
    NSLog(@"Here is your proof of payment:\n\n%@\n\nSend this to your server for confirmation and fulfillment.", completedPayment.confirmation);
    NSMutableDictionary * dict=[NSMutableDictionary dictionary];
    dict=[completedPayment.confirmation objectForKey:@"response"];
    if ([[dict objectForKey:@"state"]  isEqualToString:@"approved"]) {
       
        
        NSError * error=nil;
        NSURLResponse * urlResponse=nil;
        
        NSURL * postUrl=[NSURL URLWithString:@"http://23.238.24.26/mobile-app/insert-payment"];
        NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:postUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
        [request setHTTPMethod:@"POST"];
        [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        NSString * body=[NSString stringWithFormat:@"userid=%@&txn_id=%@&paypal_id=%@&created_at=%@&discription=%@&amount=%@&status=%@&&transactiontype=1",[SingletonClass shareSingleton].userID,[dict objectForKey:@"id"],[dict objectForKey:@"id"],[dict objectForKey:@"create_time"],desc,[NSString stringWithFormat:@"%@",total],@"Success"];
        
        [request setHTTPBody:[body dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
        
        NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
        if (data==nil) {
            return;
        }
        id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if ([[json objectForKey:@"code"]isEqualToNumber:[NSNumber numberWithInt:200]]) {
            
            NSURL * url=[NSURL URLWithString:@"http://23.238.24.26/mobile-app/activate-super"];
            NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
            [request setHTTPMethod:@"POST"];
            [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
            
            NSString * body=[NSString stringWithFormat:@"userId=%@",[SingletonClass shareSingleton].userID];
            [request setHTTPBody:[body dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
            NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
            if (data==nil) {
                return;
            }
            id  parse=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSLog(@"super power activation response %@",parse);
            if ([[parse objectForKey:@"code"]isEqualToNumber:[NSNumber numberWithInt:200]]) {
                [SingletonClass shareSingleton].superPower=1;
            }
            
        }
    }
}


#pragma mark- callPayPalPaymentMethod
-(void)callPayPalPaymentMethod:(UIButton*)sender{
    if ([SingletonClass shareSingleton].superPower==1) {
         [[AppDelegate sharedAppDelegate]showToastMessage:@"You are SUPER POWER user..!"];
        return;
    }
    NSString * description;
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    if ([sender tag]==100) {
       // total=[NSNumber numberWithDouble:2.09];
        description=@"100 Points Credit";
        //desc=@"100";
         [self checkForContinent:100];
        
    }
    else if ([sender tag]==200)
    {
        //total=[NSNumber numberWithDouble:8.83];
        description=@"600 Points Credit";
       // desc=@"600";
         [self checkForContinent:200];
    }
    else  if ([sender tag]==300){
       // total=[NSNumber numberWithDouble: 20.99 ];
        description=@"1500 Points Credit";
        //desc=@"1500";
        [self checkForContinent:300];
    }
    else  {
        //total=[NSNumber numberWithDouble: 20.99 ];
        description=@"1500 Points Credit";
        //desc=@"1500";
        [self checkForContinent:400];
    }
    payment.amount = (NSDecimalNumber*)total;
    if ([continent isEqualToString:@"EU"])
    {
         payment.currencyCode = @"EUR";
    }
    else{
        payment.currencyCode = @"USD";
    }
    payment.shortDescription =description;
    // payment.items = items;  // if not including multiple items, then leave payment.items as nil
    //payment.paymentDetails = paymentDetails; // if not including payment details, then leave payment.paymentDetails as nil
    
    if (!payment.processable) {
        // This particular payment will always be processable. If, for
        // example, the amount was negative or the shortDescription was
        // empty, this payment wouldn't be processable, and you'd want
        // to handle that here.
    }
    
    // Update payPalConfig re accepting credit cards.
    self.payPalConfig.acceptCreditCards = YES;
    
    PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
                                                                                                configuration:self.payPalConfig
                                                                                                     delegate:self];
    [self presentViewController:paymentViewController animated:YES completion:nil];
}


 #pragma  check for continent
 -(void)checkForContinent:(int)tag{
     if (tag==100) {
         if ([continent isEqualToString:@"AS"]) {
             desc=@"AS1";
              total=[NSNumber numberWithDouble:1.99];
         }
         else if([continent isEqualToString:@"AF"]){
             desc=@"AF1";
              total=[NSNumber numberWithDouble:1.99];
         }
        else if ([continent isEqualToString:@"AM"]){
            desc=@"AM1";
             total=[NSNumber numberWithDouble:6.99];
        }
        else if ([continent isEqualToString:@"AUS"]){
            desc=@"AUS1";
             total=[NSNumber numberWithDouble:6.99];
        }
        else if ([continent isEqualToString:@"SAM"]){
            desc=@"SAM1";
             total=[NSNumber numberWithDouble:3.99];
        }
        else if ([continent isEqualToString:@"EU"]){
            desc=@"EU1";
             total=[NSNumber numberWithDouble:6.99];
        }
     }

     else if(tag==200){
         if ([continent isEqualToString:@"AS"]) {
             desc=@"AS3";
              total=[NSNumber numberWithDouble:4.99];
         }
         else if([continent isEqualToString:@"AF"]){
             desc=@"AF3";
              total=[NSNumber numberWithDouble:4.99];
         }
         else if ([continent isEqualToString:@"AM"]){
             desc=@"AM3";
             total=[NSNumber numberWithDouble:18.99];
         }
         else if ([continent isEqualToString:@"AUS"]){
             desc=@"AUS3";
              total=[NSNumber numberWithDouble:18.99];
         }
         else if ([continent isEqualToString:@"SAM"]){
             desc=@"SAM3";
              total=[NSNumber numberWithDouble:9.99];
         }
         else if ([continent isEqualToString:@"EU"]){
             desc=@"EU3";
              total=[NSNumber numberWithDouble:18.99];
        }
     }

 else if(tag==300){
     if ([continent isEqualToString:@"AS"]) {
         desc=@"AS6";
          total=[NSNumber numberWithDouble:9.99];
     }
     else if([continent isEqualToString:@"AF"]){
         desc=@"AF6";
          total=[NSNumber numberWithDouble:9.99];
     }
     else if ([continent isEqualToString:@"AM"]){
         desc=@"AM6";
          total=[NSNumber numberWithDouble:29.99];
     }
     else if ([continent isEqualToString:@"AUS"]){
         desc=@"AUS6";
          total=[NSNumber numberWithDouble:29.99];
     }
     else if ([continent isEqualToString:@"SAM"]){
         desc=@"SAM6";
          total=[NSNumber numberWithDouble:14.99];
     }
     else if ([continent isEqualToString:@"EU"]){
         desc=@"EU6";
          total=[NSNumber numberWithDouble:29.99];
     }
     
    }
 
 else{
     if ([continent isEqualToString:@"AS"]) {
         desc=@"AS12";
         total=[NSNumber numberWithDouble:19.99];
     }
     else if([continent isEqualToString:@"AF"]){
         desc=@"AF12";
         total=[NSNumber numberWithDouble:19.99];
     }
     else if ([continent isEqualToString:@"AM"]){
         desc=@"AM12";
         total=[NSNumber numberWithDouble:49.99];
     }
     else if ([continent isEqualToString:@"AUS"]){
         desc=@"AUS12";
         total=[NSNumber numberWithDouble:49.99];
     }
     else if ([continent isEqualToString:@"SAM"]){
         desc=@"SAM12";
         total=[NSNumber numberWithDouble:24.99];
     }
     else if ([continent isEqualToString:@"EU"]){
         desc=@"EU12";
         total=[NSNumber numberWithDouble:49.99];
     }

 }
 }


@end
