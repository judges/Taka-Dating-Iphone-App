//
//  BasicInfoViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 15/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "BasicInfoViewController.h"
#import "SingletonClass.h"

@interface BasicInfoViewController ()

@end

@implementation BasicInfoViewController

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
   
    UIColor *firstColor = [UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
    UIColor *secColor = [UIColor colorWithRed:(CGFloat)121/255 green:(CGFloat)2/255 blue:(CGFloat)0/255 alpha:1.0];
    layer.colors = [NSArray arrayWithObjects:(id)[firstColor CGColor],(id)[secColor CGColor], nil];
    [self.view.layer insertSublayer:layer atIndex:0];
    
    //Adding title Label
    self.titleLabel=[[UILabel alloc]init];
    
    self.titleLabel.text=@"Basic Info";
    self.titleLabel.textColor=[UIColor whiteColor];
   
    [self.view addSubview:self.titleLabel];
    
    //Add Cancel Button
    self.cancelButton=[UIButton buttonWithType:UIButtonTypeCustom];
  
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    self.cancelButton.layer.borderColor=[[UIColor redColor]CGColor];
   
    self.cancelButton.layer.cornerRadius=4;
    self.cancelButton.clipsToBounds=YES;
    self.cancelButton.layer.borderWidth=0.7;
    [self.cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cancelButton];
    
    
    self.saveButton=[UIButton buttonWithType:UIButtonTypeCustom];
   
    [self.saveButton setTitle:@"Save" forState:UIControlStateNormal];
    self.saveButton.layer.borderColor=[[UIColor redColor]CGColor];
    
    self.saveButton.layer.cornerRadius=4;
    self.saveButton.clipsToBounds=YES;
    self.saveButton.layer.borderWidth=0.7;
    [self.saveButton addTarget:self action:@selector(saveButtonBasicInfoAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.saveButton];
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        layer.frame = CGRectMake(0, 0, windowSize.width, 75);
        self.titleLabel.frame=CGRectMake(windowSize.width/2-40, 25, 150, 40);
        self.cancelButton.frame=CGRectMake(windowSize.width/2-365, 25, 110, 40);
        self.saveButton.frame=CGRectMake(windowSize.width-150, 25, 110, 40);
        
        self.titleLabel.font=[UIFont boldSystemFontOfSize:30];
        self.cancelButton.titleLabel.font=[UIFont boldSystemFontOfSize:20];
        self.saveButton.titleLabel.font=[UIFont boldSystemFontOfSize:20];
        
        
        font_size=25;
        
        img_normal=@"select_normal_ipad.png";
        img_active=@"select_active_ipad.png";

    }
    else{
        img_normal=@"select_normal.png";
        img_active=@"select_active.png";
         layer.frame = CGRectMake(0, 0, windowSize.width, 55);
        self.titleLabel.frame=CGRectMake(windowSize.width/2-40, 25, 100, 25);
          self.cancelButton.frame=CGRectMake(windowSize.width-305, 25, 60, 25);
         self.saveButton.frame=CGRectMake(windowSize.width-70, 25, 60, 25);
        font_size=12;
         self.titleLabel.font=[UIFont boldSystemFontOfSize:20];
         self.cancelButton.titleLabel.font=[UIFont systemFontOfSize:15];
        self.saveButton.titleLabel.font=[UIFont systemFontOfSize:15];
    }
    
    
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark-create UI
-(void)createUI{
    //need to access data from server.
    CALayer * layer=[[CALayer alloc]init];
    layer.borderColor= [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)97/255 blue:(CGFloat)97/255 alpha:1.0].CGColor;
    layer.backgroundColor=[UIColor whiteColor].CGColor;
    layer.borderWidth=0.7;
    [self.view.layer insertSublayer:layer atIndex:0];
    
    self.nameLabel=[[UILabel alloc]init];
    self.nameLabel.text=@"Name";
    self.nameLabel.font=[UIFont systemFontOfSize:font_size];
    self.nameLabel.textColor=[UIColor blackColor];
    [self.view addSubview:self.nameLabel];
    
    self.birthdayLabel=[[UILabel alloc]init];
 
    self.birthdayLabel.text=@"Birthday";
    self.birthdayLabel.font=[UIFont systemFontOfSize:font_size];
    self.birthdayLabel.textColor=[UIColor blackColor];
    [self.view addSubview:self.birthdayLabel];
    
    self.genderLabel=[[UILabel alloc]init];
    
    self.genderLabel.text=@"Gender";
    self.genderLabel.font=[UIFont systemFontOfSize:font_size];
    [self.view addSubview:self.genderLabel];
    
    self.nameText=[[UITextField alloc]init];
    
    self.nameText.text=[SingletonClass shareSingleton].name;
    self.nameText.textAlignment=NSTextAlignmentCenter;
    self.nameText.font=[UIFont systemFontOfSize:font_size];
    self.nameText.delegate=self;
    [self.view addSubview:self.nameText];
    
    self.birthdayButton=[UIButton buttonWithType:UIButtonTypeCustom];
   
    [self.birthdayButton setTitle:[SingletonClass shareSingleton].dob forState:UIControlStateNormal];
    self.birthdayButton.clipsToBounds=YES;
    self.birthdayButton.titleLabel.font=[UIFont systemFontOfSize:font_size];
    [self.birthdayButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
   // self.birthdayButton.layer.borderColor=[UIColor blackColor].CGColor;
    //self.birthdayButton.layer.borderWidth=0.7;
   // self.birthdayButton.layer.cornerRadius=4;
    //[self.birthdayButton addTarget:self action:@selector(birthdayButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.birthdayButton];
    
    UIImageView * femaleImageView=[[UIImageView alloc]init];
    femaleImageView.image=[UIImage imageNamed:@"gen_female_icon.png"];
    [self.view addSubview:femaleImageView];
    
    UIImageView * maleImageView=[[UIImageView alloc]init];
    maleImageView.image=[UIImage imageNamed:@"gen_male_icon.png"];
    [self.view addSubview:maleImageView];
    
    
    self.radioButtonGirl=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.radioButtonGirl setImage:[UIImage imageNamed:img_normal] forState:UIControlStateNormal];
    self.radioButtonGirl.tag=0;
    
    [self.radioButtonGirl addTarget:self action:@selector(radioButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.radioButtonGirl];
    
    self.radioButtonBoy=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.radioButtonBoy setImage:[UIImage imageNamed:img_normal] forState:UIControlStateNormal];
    self.radioButtonBoy.tag=1;
    
    [self.radioButtonBoy addTarget:self action:@selector(radioButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.radioButtonBoy];
   // self.radio_Select=NO;

    if ([SingletonClass shareSingleton].sex==0) {
        [self.radioButtonBoy setImage:[UIImage imageNamed:img_active] forState:UIControlStateSelected];
        [self.radioButtonBoy setSelected:YES];
    }
    else{
        [self.radioButtonGirl setImage:[UIImage imageNamed:img_active] forState:UIControlStateSelected];
        [self.radioButtonGirl setSelected:YES];
    }
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        
        layer.frame=CGRectMake(20, 100, windowSize.width-40, windowSize.width/2);
        self.nameLabel.frame=CGRectMake(windowSize.width/2-200, windowSize.height/2-400, windowSize.width/2-200, 60);
        self.birthdayLabel.frame=CGRectMake(windowSize.width/2-200, windowSize.height/2-300, 150, 60);
        self.genderLabel.frame=CGRectMake(windowSize.width/2-200, windowSize.height/2-200, 150, 60);
        
        self.nameText.frame=CGRectMake(windowSize.width/2, windowSize.height/2-400, 200, 60);
        self.birthdayButton.frame=CGRectMake(windowSize.width/2, windowSize.height/2-300, 250, 60);
        
        femaleImageView.frame=CGRectMake(windowSize.width/2+80, windowSize.height/2-200, 40, 40);
        maleImageView.frame=CGRectMake(windowSize.width/2+100+100, windowSize.height/2-200, 40, 40);
        self.radioButtonGirl.frame=CGRectMake(windowSize.width/2+30, windowSize.height/2-200, 20, 40);
        self.radioButtonBoy.frame=CGRectMake(windowSize.width/2+150,windowSize.height/2-200, 20, 40);
    }
    else{
        layer.frame=CGRectMake(20, 100, self.view.frame.size.width-40, 140);
        self.nameLabel.frame=CGRectMake(30, 115, 50, 30);
        self.birthdayLabel.frame=CGRectMake(30, 155, 50, 30);
        self.nameText.frame=CGRectMake(85, 115, 200, 30);
        self.birthdayButton.frame=CGRectMake(110, 155, 150, 30);
        femaleImageView.frame=CGRectMake(150, 190, 20, 20);
        maleImageView.frame=CGRectMake(220, 190, 20, 20);
        self.radioButtonGirl.frame=CGRectMake(130, 193, 20, 20);
        self.radioButtonBoy.frame=CGRectMake(200,193, 20, 20);
    }
    
}

#pragma mark- Buuton actions
-(void)birthdayButtonClickAction:(id)sender{
    if(!self.datePick)
    {
        [self creatBottomUI];
        if(!self.datePick)
        {
            self.datePick=[[UIDatePicker alloc]init];
        }
        
        self.datePick.frame=CGRectMake(0.0, self.view.frame.size.height-240,0, 0);
        self.datePick.datePickerMode=UIDatePickerModeDate;
        self.dateSelect=YES;
        [self.view addSubview:self.datePick];
    }
    else
    {
         [self creatBottomUI];
        self.datePick.hidden=NO;
        self.dateSelect=YES;
    }
}

-(void)creatBottomUI{
    if(!self.tabView)
    {
        self.tabView=[[UIView alloc]init ];
    }
    self.tabView.frame =CGRectMake(0.0, self.view.frame.size.height-280, self.view.frame.size.width, 40);
    self.tabView.backgroundColor=[UIColor colorWithRed:139.0/255.0 green:26.0/255.0 blue:25.0/255.0 alpha:1.0];
    [self.view addSubview:self.tabView];
    self.tabView.hidden=NO;
    
    UIButton * doneBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    doneBtn.frame=CGRectMake(250, 7, 50, 25);
    [doneBtn setTitle:@"Done" forState:UIControlStateNormal];
    doneBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    doneBtn.clipsToBounds=YES;
    doneBtn.layer.borderColor=[[UIColor whiteColor]CGColor];
    doneBtn.layer.borderWidth=0.7;
    doneBtn.layer.cornerRadius=4;
    [doneBtn addTarget:self action:@selector(doneButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabView addSubview:doneBtn];

}

-(void)doneButtonClicked:(id)sender{
    if(self.dateSelect==YES)
    {
        self.dateSelect=NO;
        NSDate * date=self.datePick.date;
        NSDateFormatter * dateFormate=[[NSDateFormatter alloc]init];
        [dateFormate setDateFormat:@"dd/MM/yy"];
        
        NSString * dateString=[NSString stringWithFormat:@"%@",[dateFormate stringFromDate:date]];
        date=[dateFormate dateFromString:dateString];
        
        NSString * currentDateStr=[dateFormate stringFromDate:[NSDate date]];
        NSDate * currentDate=[dateFormate dateFromString:currentDateStr];
        NSDateComponents * components=[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:date toDate:currentDate options:0];
        NSInteger age=[components year];
        if(age<18)
        {
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:@"Your age must be 18 " delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [alert show];
        }
        else{
            [self.birthdayButton setTitle:dateString forState:UIControlStateNormal];
        }
    }

    self.tabView.hidden=YES;
     self.datePick .hidden=YES;
}

-(void)saveButtonBasicInfoAction:(id)sender
{
    NSError * error;
    NSURLResponse * urlRespaonse;
    /*NSString * urlStr=[NSString stringWithFormat:@"http://taka.dating/updateinfo/userData/%@/%@",[SingletonClass shareSingleton].userID,[SingletonClass shareSingleton].name];
    
    urlStr=[urlStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];*/
    NSString * urlStr=@"http://23.238.24.26/user/user-update";
    NSURL * url=[NSURL URLWithString:urlStr];
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"POST"];
     [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSString * body=[NSString stringWithFormat:@"userId=%@&name=%@",[SingletonClass shareSingleton].userID,[SingletonClass shareSingleton].name];
    [request setHTTPBody:[body dataUsingEncoding:NSASCIIStringEncoding  allowLossyConversion:YES]];
    
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlRespaonse error:&error];
    if (data==nil) {
        NSLog(@"No data");
        return ;
    }
    
    id parse=[NSJSONSerialization JSONObjectWithData:data
                                             options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"parse  data for Basic %@",parse);
}

#pragma mark- Radio Button Method
-(void)radioButtonAction:(id)sender{
    
    //self.radio_Select=YES;
    switch ([sender tag]) {
        case 0:
            if([self.radioButtonGirl isSelected]==YES)
            {
                // [self.radioButtonGirl setSelected:NO];
                // [self.radioButtonBoy setSelected:YES];
            }
            else{
                [self.radioButtonGirl setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
                [self.radioButtonGirl setSelected:YES];
                [self.radioButtonBoy setSelected:NO];
                radiobutton=1;
                
            }
            
            break;
            
        case 1:
            if([self.radioButtonBoy isSelected]==YES)
            {
                //  [self.radioButtonBoy setSelected:NO];
                // [self.radioButtonGirl setSelected:YES];
            }
            else{
                [self.radioButtonBoy setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
                [self.radioButtonBoy setSelected:YES];
                [self.radioButtonGirl setSelected:NO];
                radiobutton=0;
                
            }
            
            break;
            
        default:
            break;
    }
    
    
}

#pragma mark-Textfield delegate methods
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [SingletonClass shareSingleton].name=textField.text;
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [SingletonClass shareSingleton].name=textField.text;
    [textField resignFirstResponder];
    return  YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cancelButtonAction:(id)sender{
     // [[[[[UIApplication sharedApplication]keyWindow]subviews]lastObject]removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
