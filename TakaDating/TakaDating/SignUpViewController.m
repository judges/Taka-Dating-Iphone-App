//
//  SignUpViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 08/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "SignUpViewController.h"
#import "ProfileViewController.h"
#import "PeopleNearByViewController.h"
#import "EncountersViewController.h"
#import "CustomMenuViewController.h"
#import "AppDelegate.h"
#import "FavoritViewController.h"
#import "ActivationViewController.h"
#import "LikedYouViewController.h"
#import "AFNHelper.h"


@interface SignUpViewController ()
{
    ActivationViewController * activationVC;
}
@property (nonatomic, strong) AddPhotoViewController * addphoto;
@property(nonatomic,strong)VisitorsViewController * visitorsVC;

@end

@implementation SignUpViewController

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
    self.windowSize = [UIScreen mainScreen].bounds.size;
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, self.windowSize.width, 55);
    UIColor *firstColor = [UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
    UIColor *secColor = [UIColor colorWithRed:(CGFloat)121/255 green:(CGFloat)2/255 blue:(CGFloat)0/255 alpha:1.0];
    layer.colors = [NSArray arrayWithObjects:(id)[firstColor CGColor],(id)[secColor CGColor], nil];
    [self.view.layer insertSublayer:layer atIndex:0];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.frame=CGRectMake(100, 20, self.windowSize.width-200, 35);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.text = @"SignUp";
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
    
    windowSize=[UIScreen mainScreen].bounds.size;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        layer.frame = CGRectMake(0, 0, windowSize.width, 75);
        
        self.titleLabel.frame=CGRectMake(windowSize.width/2-100, 25, windowSize.width/2-200, 40);
        self.cancelButton.frame = CGRectMake(windowSize.width/2-350, 25, 120, 35);
        self.cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:30];
    }

    
    
    [self signUpUI];
    
    self.selectOption=NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) signUpUI{
    
    self.pickerViewArray=[NSArray arrayWithObjects:@"Make new friends",@"Chat",@"Date", nil];
    UIImage * img1=[UIImage imageNamed:@"add_friends.png"];
    UIImage * img2=[UIImage imageNamed:@"chat.png"];
    UIImage * img3=[UIImage imageNamed:@"date.png"];
    self.pickerViewImages=[NSArray arrayWithObjects:img1,img2,img3, nil];
    
    UIImageView * warningView=[[UIImageView alloc]init];
    
    warningView.image=[UIImage imageNamed:@"warning_icon_small.png"];
    [self.view addSubview:warningView];
    
    UILabel * eighteenPlusLabel=[[UILabel alloc]init];
    
    eighteenPlusLabel.text=@"Only 18 and 18+ can use Taka. ";
    eighteenPlusLabel.textColor=[UIColor redColor];
    eighteenPlusLabel.font=[UIFont systemFontOfSize:9];
    [self.view addSubview:eighteenPlusLabel];
    
    
    self.layer = [CALayer layer];
    //240
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 0.7;
    self.layer.borderColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)97/255 blue:(CGFloat)97/255 alpha:1.0].CGColor;
    [self.view.layer insertSublayer:self.layer atIndex:0];
    
    
    
    //Add all Labels
    UILabel *emailLabel=[[UILabel alloc]init ];
    emailLabel.text=@"Email";
    [emailLabel setTextColor:[UIColor grayColor]];
    emailLabel.font=[UIFont systemFontOfSize:10];
    [self.view addSubview:emailLabel];
    
    UILabel * nameLabel=[[UILabel alloc]init ];
    
    nameLabel.text=@"Name";
    [nameLabel setTextColor:[UIColor grayColor]];
    nameLabel.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:nameLabel];
    
    UILabel * birthdayLabel=[[UILabel alloc]init ];
    
    birthdayLabel.text=@"Birthday";
    [birthdayLabel setTextColor:[UIColor grayColor]];
    birthdayLabel.font=[UIFont systemFontOfSize:10];
    [self.view addSubview:birthdayLabel];
    
    UILabel * genderLabel=[[UILabel alloc]init];
    genderLabel.text=@"Gender";
    genderLabel.textColor=[UIColor grayColor];
    genderLabel.font=[UIFont systemFontOfSize:10];
    [self.view addSubview:genderLabel];
    
    UILabel * im_here_tooLabel=[[UILabel alloc]init];
    im_here_tooLabel.textColor=[UIColor grayColor];
    im_here_tooLabel.text=@"I'am here too";
    im_here_tooLabel.font=[UIFont systemFontOfSize:10];
    [self.view addSubview:im_here_tooLabel];
    
    UILabel * passowrdLabel=[[UILabel alloc]init];
    passowrdLabel.textColor=[UIColor grayColor];
    passowrdLabel.text=@"Password";
    passowrdLabel.font=[UIFont systemFontOfSize:10];
    [self.view addSubview:passowrdLabel];
    
    self.LookingforLabel=[[UILabel alloc]init];
    self.LookingforLabel.textColor=[UIColor grayColor];
    self.LookingforLabel.text=@"Looking for";
    self.LookingforLabel.font=[UIFont systemFontOfSize:10];
    [self.view addSubview:self.LookingforLabel];
    self.LookingforLabel.hidden=YES;
    
    
    //Add TextFields
    
    self.emailText=[[UITextField alloc]init];
    
    self.emailText.background=[UIImage imageNamed:@"signup_greyline.png"];
   
    self.emailText.placeholder=@"Enter Valid Email";
    self.emailText.font=[UIFont systemFontOfSize:11];
    self.emailText.textAlignment=NSTextAlignmentCenter;
    //    self.emailText.layer.cornerRadius=0.5;
    //    self.emailText.layer.borderColor=[UIColor blackColor].CGColor;
    //    self.emailText.layer.borderWidth=0.7;
    self.emailText.delegate=self;
    [self.view addSubview:self.emailText];
    
    self.nameText=[[UITextField alloc]init];
    
    self.nameText.background=[UIImage imageNamed:@"signup_greyline.png"];
    self.nameText.placeholder=@"Enter Your Name";
    self.nameText.textAlignment=NSTextAlignmentCenter;
    self.nameText.font=[UIFont systemFontOfSize:11];
    //    self.nameText.layer.cornerRadius=0.5;
    //    self.nameText.layer.borderColor=[UIColor blackColor].CGColor;
    //    self.nameText.layer.borderWidth=0.7;
    self.nameText.delegate=self;
    [self.view addSubview:self.nameText];
    
    self.passwordText=[[UITextField alloc]init];
    
    self.passwordText.background=[UIImage imageNamed:@"signup_greyline.png"];
    self.passwordText.placeholder=@"Password";
    self.passwordText.textAlignment=NSTextAlignmentCenter;
    self.passwordText.font=[UIFont systemFontOfSize:11];
    //    self.nameText.layer.cornerRadius=0.5;
    //    self.nameText.layer.borderColor=[UIColor blackColor].CGColor;
    //    self.nameText.layer.borderWidth=0.7;
    self.passwordText.secureTextEntry=YES;
    self.passwordText.delegate=self;
    [self.view addSubview:self.passwordText];
    
    
    
    //Add UIbutton
    
    self.dateBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    //    self.dateBtn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"signup_greyline.png"]];
    [self.dateBtn setTitle:@"YYYY/MM/DD" forState:UIControlStateNormal];
    self.dateBtn.titleLabel.font=[UIFont systemFontOfSize:11];
    [self.dateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.dateBtn.layer.borderColor = [UIColor blackColor].CGColor;
    //self.dateBtn.layer.borderWidth = 0.7;
    self.dateBtn.layer.cornerRadius =4;
    self.dateBtn.clipsToBounds = YES;
    [self.dateBtn addTarget:self action:@selector(PickDate:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.dateBtn];
    
    self.im_here_tooBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    //     self.im_here_tooBtn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"signup_greyline.png"]];
    [self.im_here_tooBtn setTitle:@"Please select" forState:UIControlStateNormal];
    self.im_here_tooBtn.titleLabel.font=[UIFont systemFontOfSize:11];
    [self.im_here_tooBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.im_here_tooBtn.layer.borderColor = [UIColor blackColor].CGColor;
    // self.im_here_tooBtn.layer.borderWidth = 0.7;
    self.im_here_tooBtn.layer.cornerRadius =4;
    self.im_here_tooBtn.clipsToBounds = YES;
    [self.im_here_tooBtn addTarget:self action:@selector(iAmHereTooBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.im_here_tooBtn];
    
    self.letsGo=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [ self.letsGo setBackgroundImage:[UIImage imageNamed:@"lets_go_btn.png"] forState:UIControlStateNormal];
    [ self.letsGo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.letsGo.layer.cornerRadius =7;
    self.letsGo.clipsToBounds = YES;
    [ self.letsGo addTarget:self action:@selector(letsGoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: self.letsGo];
    
    NSString * termsAndCondtion=@"By continuing you accept our Terms and Conditions. We will never share your Contact Details.";
    self.termsAndCondtionLabel=[[UILabel alloc]init];
    
    self.termsAndCondtionLabel.text=termsAndCondtion;
    self.termsAndCondtionLabel.textColor=[UIColor blackColor];
    self.termsAndCondtionLabel.font=[UIFont systemFontOfSize:11];
    self.termsAndCondtionLabel.lineBreakMode=NSLineBreakByCharWrapping;
    self.termsAndCondtionLabel.numberOfLines=0;
    [self.termsAndCondtionLabel sizeToFit];
    
    [self.view addSubview:self.termsAndCondtionLabel];
    
    //Add gender Images here.
    
    UIImageView * femaleImageView=[[UIImageView alloc]init];
    
    femaleImageView.image=[UIImage imageNamed:@"gen_female_icon.png"];
    [self.view addSubview:femaleImageView];
    
    UIImageView * maleImageView=[[UIImageView alloc]init];
    
    maleImageView.image=[UIImage imageNamed:@"gen_male_icon.png"];
    [self.view addSubview:maleImageView];
    
    
    //Add looking for
    
    /* self.looking_for_male=[[UIImageView alloc]init];
     self.looking_for_male.frame=CGRectMake(150, 315, 20, 20);
     self.looking_for_male.image=[UIImage imageNamed:@"gen_female_icon.png"];
     [self.view addSubview:self.looking_for_male];
     self.looking_for_male.hidden=YES;
     
     self.looking_for_female=[[UIImageView alloc]init];
     self.looking_for_female.frame=CGRectMake(220, 315, 20, 20);
     self.looking_for_female.image=[UIImage imageNamed:@"gen_male_icon.png"];
     [self.view addSubview:self.looking_for_female];
     self.looking_for_female.hidden=YES;*/
    
    
    self.radioButtonGirl=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.radioButtonGirl setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
    [self.radioButtonGirl setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
    self.radioButtonGirl.tag=0;
    
    [self.radioButtonGirl addTarget:self action:@selector(radioButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.radioButtonGirl];
    
    self.radioButtonBoy=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.radioButtonBoy setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
    self.radioButtonBoy.tag=1;
    [self.radioButtonBoy setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
    [self.radioButtonBoy addTarget:self action:@selector(radioButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.radioButtonBoy];
    self.radio_Select=NO;
    
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        self.layer.frame = CGRectMake(20, self.windowSize.width/2-200, self.windowSize.width-40,self.windowSize.width-200);
        warningView.frame=CGRectMake(self.windowSize.width/2-100, 70, 15, 15);
        eighteenPlusLabel.frame=CGRectMake(self.windowSize.width/2-75, 67, 210, 20);
        
        
        emailLabel.Frame=CGRectMake(self.windowSize.width/2-250, self.windowSize.width/2-150,100,60);
        emailLabel.font=[UIFont boldSystemFontOfSize:18];
        nameLabel.Frame=CGRectMake(self.windowSize.width/2-250, self.windowSize.width/2-70,100, 60);
        nameLabel.font= [UIFont boldSystemFontOfSize:18];
        passowrdLabel.Frame=CGRectMake(self.windowSize.width/2-250, self.windowSize.width/2+10, 100, 60);
        passowrdLabel.font=[UIFont boldSystemFontOfSize:18];
        birthdayLabel.Frame=CGRectMake(self.windowSize.width/2-250, self.windowSize.width/2+90, 100, 60);
        birthdayLabel.font=[UIFont boldSystemFontOfSize:18];
        genderLabel.Frame=CGRectMake(self.windowSize.width/2-250, self.windowSize.width/2+180, 100, 60);
        genderLabel.font=[UIFont boldSystemFontOfSize:18];
        im_here_tooLabel.Frame=CGRectMake(self.windowSize.width/2-250, self.windowSize.width/2+260, 150, 60);
        im_here_tooLabel.font=[UIFont boldSystemFontOfSize:18];
        
        
        self.LookingforLabel.Frame=CGRectMake(self.windowSize.width/2-200, self.windowSize.width/2+150, 100, 60);
        self.LookingforLabel.font=[UIFont boldSystemFontOfSize:18];
        
        
        self.emailText.Frame=CGRectMake(self.windowSize.width/2-100, self.windowSize.width/2-150, 300, 60);
        self.nameText.Frame=CGRectMake(self.windowSize.width/2-100, self.windowSize.width/2-70, 300, 60);
        self.passwordText.Frame=CGRectMake(self.windowSize.width/2-100, self.windowSize.width/2+10, 300, 60);
        self.dateBtn.frame= CGRectMake(self.windowSize.width/2-100, self.windowSize.width/2+90, 300, 60);
        
        self.emailText.font=[UIFont systemFontOfSize:18];
        self.nameText.font=[UIFont systemFontOfSize:18];
        self.passwordText.font=[UIFont systemFontOfSize:18];
        self.dateBtn.titleLabel.font=[UIFont systemFontOfSize:18];
        self.im_here_tooBtn.titleLabel.font=[UIFont systemFontOfSize:18];
        
        femaleImageView.frame=CGRectMake(self.windowSize.width/2-30, self.windowSize.width/2+180, 40, 40);
        maleImageView.frame=CGRectMake(self.windowSize.width/2+120, self.windowSize.width/2+180, 40, 40);
        self.radioButtonGirl.frame=CGRectMake(self.windowSize.width/2-80, self.windowSize.width/2+190, 40, 40);
        self.radioButtonBoy.frame=CGRectMake(self.windowSize.width/2+70, self.windowSize.width/2+190, 40, 40);
        
        
        self.im_here_tooBtn.frame=CGRectMake(self.windowSize.width/2-100, self.windowSize.width/2+260, 220, 60);
        
        
        self.letsGo.frame=CGRectMake(self.windowSize.width/2-150, self.windowSize.width+100, 328, 62);
        self.termsAndCondtionLabel.Frame=CGRectMake(self.windowSize.width/2-250,self.windowSize.width, self.windowSize.width/2+100, 50);
        self.termsAndCondtionLabel.font=[UIFont systemFontOfSize:18];
       
        
        femaleImageView.image=[UIImage imageNamed:@"gen_female_icon_ipad.png"];
        maleImageView.image=[UIImage imageNamed:@"gen_male_icon_ipad.png"];
        
        [self.radioButtonGirl setImage:[UIImage imageNamed:@"select_normal_ipad.png"] forState:UIControlStateNormal];
        [self.radioButtonGirl setImage:[UIImage imageNamed:@"select_active_ipad.png"] forState:UIControlStateSelected];
        [self.radioButtonBoy setImage:[UIImage imageNamed:@"select_normal_ipad.png"] forState:UIControlStateNormal];
        [self.radioButtonBoy setImage:[UIImage imageNamed:@"select_active_ipad.png"] forState:UIControlStateSelected];
        [ self.letsGo setBackgroundImage:[UIImage imageNamed:@"lets_go_btn_ipad.png"] forState:UIControlStateNormal];
        
        self.emailText.background=[UIImage imageNamed:@"signup_greyline_ipad.png"];
        self.nameText.background=[UIImage imageNamed:@"signup_greyline_ipad.png"];
        self.passwordText.background=[UIImage imageNamed:@"signup_greyline_ipad.png"];
        
        
    }
    else {
        
      
        self.layer.frame = CGRectMake(20, 90, self.windowSize.width-40,self.windowSize.width-50);
        warningView.frame=CGRectMake(50, 70, 15, 15);
        eighteenPlusLabel.frame=CGRectMake(75, 67, 180, 20);
        emailLabel.Frame=CGRectMake(50, 110,40,25);
        nameLabel.Frame=CGRectMake(50, 150,40, 25);
        passowrdLabel.Frame=CGRectMake(50, 185, 80, 25);
        birthdayLabel.Frame=CGRectMake(50, 220, 60, 25);
        genderLabel.Frame=CGRectMake(50, 250, 50, 25);
        im_here_tooLabel.Frame=CGRectMake(50, 280, 80, 25);
        
        
        self.LookingforLabel.Frame=CGRectMake(50, 315, 80, 25);
        self.emailText.Frame=CGRectMake(120, 110, 150, 25);
        self.nameText.Frame=CGRectMake(120, 150, 150, 25);
        self.passwordText.Frame=CGRectMake(120, 185, 150, 25);
        self.dateBtn.frame= CGRectMake(120, 220, 150, 25);
        self.im_here_tooBtn.frame=CGRectMake(120, 280, 150, 25);
        self.letsGo.frame=CGRectMake(80, self.windowSize.height-50, 160, 30);
        self.termsAndCondtionLabel.Frame=CGRectMake(25,self.windowSize.height-100, self.windowSize.width-45, 30);
        femaleImageView.frame=CGRectMake(150, 250, 20, 20);
        maleImageView.frame=CGRectMake(220, 250, 20, 20);
        self.radioButtonGirl.frame=CGRectMake(130, 253, 20, 20);
        self.radioButtonBoy.frame=CGRectMake(200, 253, 20, 20);
        //}
        
    }
    
    //if facebook login first time
   /* if ([SingletonClass shareSingleton].userID) {
        self.nameText.text=[SingletonClass shareSingleton].name;
        self.emailText.text=[SingletonClass shareSingleton].emailID;
        
        NSDateFormatter * dateFormate=[[NSDateFormatter alloc]init];
        [dateFormate setDateFormat:@"yyyy-MM-dd"];
        NSString * currentDateStr=[dateFormate stringFromDate:[NSDate date]];
        NSDate * currentDate=[dateFormate dateFromString:currentDateStr];
        NSString * dateStr=[[SingletonClass shareSingleton].dob stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
      //  NSLog(@" date %@",dateStr);
        NSDate * fbDate=[[NSDate alloc]init];
        fbDate=[dateFormate dateFromString:[SingletonClass shareSingleton].dob];
        NSLog(@"fb date %@",fbDate);
        
        
        NSDateComponents * components=[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:fbDate toDate:currentDate options:0];
        NSInteger age=[components year];
        if (age>18) {
            NSString * fbDateStr=[dateFormate stringFromDate:fbDate];
            [self.dateBtn setTitle:fbDateStr forState:UIControlStateNormal];
        }
        else{
            NSLog(@"age should be greater than 18");
        }*/
       /* if ([SingletonClass shareSingleton].sex ==1) {
            [self.radioButtonGirl setSelected:YES];
            [self.radioButtonBoy setSelected:NO];
        }
        else{
            [self.radioButtonGirl setSelected:NO];
            [self.radioButtonBoy setSelected:YES];
        }
        
    }
    */
    
    
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
         textField.background=[UIImage imageNamed:@"signup_blueline_ipad.png"];
    }
    else{
            textField.background=[UIImage imageNamed:@"signup_blueline.png"];
    }
    return  YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        textField.background=[UIImage imageNamed:@"signup_greyline_ipad.png"];
    }
    else{
        textField.background=[UIImage imageNamed:@"signup_greyline.png"];
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}

/*-(void)letsGoButtonAction:(id)sender{
    NSString * errorMessage=[self validationFunction];
    if (errorMessage) {
        [self alertViewFunction:errorMessage];
        return;
    }
    else
    {
        if(!self.addphoto)
        {
            self.addphoto=[[AddPhotoViewController alloc]initWithNibName:@"AddPhotoViewController" bundle:nil];
        }
        [self.navigationController pushViewController:self.addphoto animated:YES];
    }
}
*/
-(void)PickDate:(id)sender{
    self.selectOption=YES;
    [self.nameText endEditing:YES];
    [self.emailText endEditing:YES];
    [self.passwordText endEditing:YES];
    self.pickerView.hidden=YES;
    self.datePick.hidden=NO;
     self.dateSelect=NO;
    
    self.termsAndCondtionLabel.hidden=YES;
    self.letsGo.hidden=YES;
    [self creatBottomUI];
    if(!self.datePick)
    {
        self.datePick=[[UIDatePicker alloc]init];
    }
    
    self.datePick.frame=CGRectMake(0.0, self.windowSize.height-130,self.windowSize.width, 0);
    self.datePick.datePickerMode=UIDatePickerModeDate;
    self.dateSelect=YES;
    [self.view addSubview:self.datePick];
}

-(void)iAmHereTooBtnClicked:(id)sender{
    [self.nameText endEditing:YES];
    [self.emailText endEditing:YES];
    [self.passwordText endEditing:YES];
    self.datePick.hidden=YES;
    self.dateSelect=NO;
    
    self.termsAndCondtionLabel.hidden=YES;
    self.letsGo.hidden=YES;
    
    [self creatBottomUI];
    if(!self.pickerView)
    {
        self.pickerView=[[UIPickerView alloc]initWithFrame:CGRectMake(0.0, self.windowSize.height-130,self.windowSize.width,100)];
    }
    self.pickerView.delegate=self;
    self.pickerView.dataSource=self;
    self.pickerView.hidden=NO;
    
    [self.view addSubview:self.pickerView];
}

-(void)creatBottomUI
{
    if(!self.tabView)
    {
        self.tabView=[[UIView alloc]init ];
    }
    
    self.tabView.backgroundColor=[UIColor colorWithRed:139.0/255.0 green:26.0/255.0 blue:25.0/255.0 alpha:1.0];
    [self.view addSubview:self.tabView];
    
    UIButton * doneBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        doneBtn.frame=CGRectMake(self.windowSize.width-100, 7, 90, 40);
        self.tabView.frame =CGRectMake(0.0, self.windowSize.height-200, self.windowSize.width, 60);
    }
    else{
            doneBtn.frame=CGRectMake(250, 7, 50, 25);
        self.tabView.frame =CGRectMake(0.0, self.windowSize.height-160, self.windowSize.width, 40);
    }
    [doneBtn setTitle:@"Done" forState:UIControlStateNormal];
    doneBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    doneBtn.clipsToBounds=YES;
    doneBtn.layer.borderColor=[[UIColor whiteColor]CGColor];
    doneBtn.layer.borderWidth=0.7;
    doneBtn.layer.cornerRadius=4;
    [doneBtn addTarget:self action:@selector(doneButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabView addSubview:doneBtn];
    
    /*UIButton * cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame=CGRectMake(20, 7, 60, 25);
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelBtn.clipsToBounds=YES;
    cancelBtn.layer.borderColor=[[UIColor whiteColor]CGColor];
    cancelBtn.layer.borderWidth=0.7;
    cancelBtn.layer.cornerRadius=4;
    [cancelBtn addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabView addSubview:cancelBtn];*/
    
    
}
#pragma mark- Radio Button Method
-(void)radioButtonAction:(UIButton*)sender{
    
    self.radio_Select=YES;
    switch ([sender tag]) {
        case 0:
            if([self.radioButtonGirl isSelected]==YES)
            {
              
            }
            else{
                [self.radioButtonGirl setSelected:YES];
                [self.radioButtonBoy setSelected:NO];
                radiobutton=@"1";

            }
            
            break;
            
        case 1:
            if([self.radioButtonBoy isSelected]==YES)
            {
              
            }
            else{
                [self.radioButtonBoy setSelected:YES];
                [self.radioButtonGirl setSelected:NO];
                radiobutton=@"0";
                
            }
            
            break;
            
        default:
            break;
    }

    
}


#pragma mark- uipickerView delegate methods

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return  self.pickerViewArray.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return  [self.pickerViewArray objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    self.pickerstr=[self.pickerViewArray objectAtIndex:row];
    [self.im_here_tooBtn setTitle:self.pickerstr forState:UIControlStateNormal];
    /*if ([ self.pickerstr isEqualToString:@"Date"]) {
        self.layer.frame=CGRectMake(20, 90, self.view.frame.size.width-40, 260);
        self.LookingforLabel.hidden=NO;
        self.looking_for_female.hidden=NO;
        self.looking_for_male.hidden=NO;
    }
    else{*/
        //self.layer.frame=CGRectMake(20, 90, self.view.frame.size.width-40, 240);
        self.LookingforLabel.hidden=YES;
        self.looking_for_female.hidden=YES;
        self.looking_for_male.hidden=YES;
   // }
    
}

-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    
    UIImageView *temp = [[UIImageView alloc] initWithImage:[self.pickerViewImages objectAtIndex:row]];
    temp.frame = CGRectMake(-70, 10, 40, 40);
    
    UILabel *channelLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, -5, 150, 60)];
    channelLabel.text = [NSString stringWithFormat:@"%@",[self.pickerViewArray objectAtIndex:row] ];
    channelLabel.textAlignment = NSTextAlignmentLeft;
    channelLabel.backgroundColor = [UIColor clearColor];
    
    UIView *tmpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 110, 50)];
    
    [tmpView insertSubview:temp atIndex:0];
    [tmpView insertSubview:channelLabel atIndex:1];
    
    return  tmpView;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 50;
}

#pragma mark-
-(void)cancelButtonClicked:(id)sender{
   
    [self.im_here_tooBtn setTitle:@"Please select " forState:UIControlStateNormal];
    [self.tabView removeFromSuperview];
    [self.datePick removeFromSuperview];
    [self.pickerView removeFromSuperview];
}

-(void)doneButtonClicked:(id)sender{
    if(self.dateSelect==YES)
    {
       
        self.dateSelect=NO;
        NSDate * date=self.datePick.date;
        NSDateFormatter * dateFormate=[[NSDateFormatter alloc]init];
        [dateFormate setDateFormat:@"yyyy-MM-dd"];
       
         self.dateString=[NSString stringWithFormat:@"%@",[dateFormate stringFromDate:date]];
        date=[dateFormate dateFromString:self.dateString];
        
        NSString * currentDateStr=[dateFormate stringFromDate:[NSDate date]];
        NSDate * currentDate=[dateFormate dateFromString:currentDateStr];
        NSDateComponents * components=[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:date toDate:currentDate options:0];
        NSInteger age=[components year];
        if(age<18)
        {
            [self alertViewFunction:@"Age should be 18 or 18+."];
        }
        else{
            [self.dateBtn setTitle:self.dateString forState:UIControlStateNormal];
        }
    }
    self.termsAndCondtionLabel.hidden=NO;
    self.letsGo.hidden=NO;
    [self.pickerView removeFromSuperview];
    [self.tabView removeFromSuperview];
    [self.datePick removeFromSuperview];
}
-(void)cancelButtonAction:(id)sender{
    self.emailText.text=nil;
    self.emailText.placeholder=@"   Email or Cell phone";
    self.nameText.text=nil;
    self.nameText.placeholder=@"Enter Your Name";
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark- Validation Function

-(NSString *)validationFunction{
    
    NSString * errmsg;
    NSString * EmailregexPat=@"[^@]+@[A-Za-z0-9.-]+\\.[A-Za-z]+";
    NSRegularExpression *regex=[[NSRegularExpression alloc]initWithPattern:EmailregexPat options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger emailregmatch=[regex numberOfMatchesInString:self.emailText.text options:0 range:NSMakeRange(0, [self.emailText.text length])];

    NSString * usernameregexPat=@"^[a-zA-Z]{1}[a-zA-Z0-9\\._\\-]{0,23}[^.-]";
    NSRegularExpression * regexusername=[[NSRegularExpression alloc]initWithPattern:usernameregexPat options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger usernamegmatch=[regexusername numberOfMatchesInString:self.nameText.text options:0 range:NSMakeRange(0, self.nameText.text.length)];
    
    if(emailregmatch==0)
    {
        errmsg=@"Please enter a valid email-Id.";
    }
    else if (usernamegmatch==0)
    {
        errmsg=@"Name is not in correct form.";
    }
//    else if (self.passwordText.text.length<4)
//    {
//        errmsg=@"Password should not be less 4 characters.";
//    }
    else if (self.radio_Select==NO)
    {
        errmsg=@"Select your gender.";
    }
    NSLog(@"%lu",(unsigned long)self.passwordText.text.length);
    return errmsg;
    
}

-(void)alertViewFunction:(NSString *)message{
    
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    [alert show];
}


#pragma mark-second lets go button

-(void)letsGoButtonAction:(id)sender{
   
   NSString * errorMessage=[self validationFunction];
    if (errorMessage) {
        [self alertViewFunction:errorMessage];
        return;
    }
    else
    {
        if (![SingletonClass shareSingleton].location) {
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:@"Enable Location service in device" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }
        else{
            NSString * hereForNum;
            if ([self.pickerstr isEqualToString:@"Make new friends"]) {
                hereForNum=@"0";
            }
            else if([self.pickerstr isEqualToString:@"Chat"])
            {
                hereForNum=@"1";
            }
            else{
                hereForNum=@"2";
            }
        
     /*   NSError * error=nil;
        NSURLResponse * response=nil;
      NSString * urlstr=[NSString stringWithFormat:@"http://taka.dating/mobile/signup/%@/%@/%@/%@/%@/%d/%d/%@/%@/",self.nameText.text,self.dateString,[SingletonClass shareSingleton].location,[SingletonClass shareSingleton].lattitude,[SingletonClass shareSingleton].longitude,radiobutton,hereForNum, self.emailText.text,self.passwordText.text];
    
            
            urlstr=[urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL * url=[NSURL URLWithString:urlstr];
        
         NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
        NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        if(data==nil)
        {
            NSLog(@"Error %@",error);
            return;
        }
        
        id parse=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"Parse %@",parse);
        
      
                 NSNumber  *code=[NSNumber numberWithInt:200] ;
            NSLog(@"code %@",[parse objectForKey:@"code"]);
    if(![[parse objectForKey:@"code"] isEqualToNumber:code])
    {
        
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Email is already exisits" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
   
    }
    else
    {
        
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Registration successfull" message:@"" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
         NSNumber  *code=[NSNumber numberWithInt:200] ;
        NSString * activationkey=[parse objectForKey:@"active"];
       NSString * urlActiveStr=[NSString stringWithFormat:@"http://taka.dating/mobile/account/verification/%@/%@/%@",self.emailText.text,activationkey,self.passwordText.text];
        urlActiveStr=[urlActiveStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL * urlActive=[NSURL URLWithString:urlActiveStr];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:urlActive cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
        NSData *dataActivation=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        if (!dataActivation) {
            return;
        }
        id parse1=[NSJSONSerialization JSONObjectWithData:dataActivation options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"activation parse %@",parse1);
        
        if ([[parse1 objectForKey:@"code"]isEqualToNumber:[NSNumber numberWithInt:200]] ) {
         
        }
    }
        }
    }*/
   

    
            NSString * checkNetwork=[[NSUserDefaults standardUserDefaults]objectForKey:@"NetworkStatus"];
            if (checkNetwork) {
                
                NSURL * url=[NSURL URLWithString:@"http://23.238.24.26/mobi/signup/"];
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
                
                
                [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
                
                [request setHTTPMethod:@"POST"];
                NSString * requestBody=[NSString stringWithFormat:@"displayName=%@&dob=%@&location=%@&latitude=%@&longitude=%@&sex=%@&hereFor=%@&userEmail=%@&password=%@",self.nameText.text,self.dateString,[SingletonClass shareSingleton].location,[SingletonClass shareSingleton].lattitude,[SingletonClass shareSingleton].longitude,radiobutton,hereForNum,self.emailText.text,self.passwordText.text];
                [request setHTTPBody:[requestBody dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
                
                NSURLResponse * urlResponse=nil;
                NSError * error=nil;
                 NSData *dataActivation=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
                
                id parse=[NSJSONSerialization JSONObjectWithData:dataActivation options:NSJSONReadingAllowFragments error:&error];
                NSLog(@"parse data sign up -==-= %@",parse);
               // [NSURLConnection connectionWithRequest:request delegate:self];
            
            }
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
    NSError * error=nil;
    id parse=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"parse in sign up -==- %@",parse);
    
    if(![[parse objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]])
    {
        
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Email is already exisits" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        
    }
    else
    {
        
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Registration successfull" message:@"" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
      
        NSString * activationkey=[parse objectForKey:@"active"];
        NSURL * urlActiveStr=[NSURL URLWithString:@"http://23.238.24.26/mobi/verification"];
       
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:urlActiveStr cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
        
        
        [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        //NSMutableDictionary * dict=[NSMutableDictionary dictionary];
        NSURLResponse * urlResponse=nil;
        NSError * error=nil;
        
        NSString * active=[NSString stringWithFormat:@"email=%@&activationKey=%@&password=%@",self.emailText.text,activationkey,self.passwordText.text];
        [request setHTTPBody:[active dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
        NSData *dataActivation=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
        
        id parse1=[NSJSONSerialization JSONObjectWithData:dataActivation options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"activation parse %@",parse1);
        
        if ([[parse1 objectForKey:@"code"]isEqualToNumber:[NSNumber numberWithInt:200]] ) {
            
        }
    }
}


-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
   
    NSLog(@"Error in connection -==- %@",error);
}
@end
