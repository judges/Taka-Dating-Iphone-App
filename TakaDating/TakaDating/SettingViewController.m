//
//  SettingViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 17/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "SettingViewController.h"
#import "BasicInfoViewController.h"
#import "PrivacyViewController.h"
#import "AccountInfoViewController.h"
#import "AccountSignOutViewController.h"
#import "NotificationViewController.h"
#import "FeedBackViewController.h"
#import "HelpViewController.h"
#import "AppDelegate.h"

@interface SettingViewController ()
{
    AppDelegate * appdelegate;
}
@property(nonatomic,strong)BasicInfoViewController * basicInfo;
@property(nonatomic,strong)PrivacyViewController * privacyVC;
@property(nonatomic,strong)AccountSignOutViewController * accountVC;
@property(nonatomic,strong)NotificationViewController * notifyVC;
@property(nonatomic,strong)FeedBackViewController * feedBackVC;
@property(nonatomic,strong)HelpViewController * helpVC;
@end

@implementation SettingViewController

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
    appdelegate=[UIApplication sharedApplication].delegate;
    
    self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    windowSize=[UIScreen mainScreen].bounds.size;
    
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, self.view.frame.size.width, 60);
    UIColor *firstColor = [UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
    UIColor *secColor = [UIColor colorWithRed:(CGFloat)121/255 green:(CGFloat)2/255 blue:(CGFloat)0/255 alpha:1.0];
    layer.colors = [NSArray arrayWithObjects:(id)[firstColor CGColor],(id)[secColor CGColor], nil];
    [self.view.layer insertSublayer:layer atIndex:0];
    
    self.titleLabel = [[UILabel alloc] init ];
    self.titleLabel.frame=CGRectMake(100, 20, self.view.frame.size.width-200, 35);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.text = @"Settings";
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
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        layer.frame = CGRectMake(0, 0, windowSize.width, 75);
        self.titleLabel.frame=CGRectMake(windowSize.width/2-270, 20, windowSize.width-200, 50);
        self.cancelButton.frame = CGRectMake(windowSize.width/2-350, 25, 120, 40);
        self.cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:30];
        
        
    }
    
    
    
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}

-(void)createUI{
    if(!self.settingsTableView)
    {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            self.settingsTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 75, windowSize.width, windowSize.height-50)];
            cell_hh=85.0;
            cell_font=25;
        }
        else{
            cell_hh=40.0;
            cell_font=12;

        
        if ([UIScreen mainScreen].bounds.size.height>500) {
            self.settingsTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 55, windowSize.width, windowSize.height-50)];
            }
        else{
            self.settingsTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 55, windowSize.width, windowSize.height-50)];
        }
    }//else part complete
        
        self.settingsTableView.delegate=self;
        self.settingsTableView.dataSource=self;
        self.settingsTableView.backgroundColor=[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
        self.settingsTableView.separatorColor=[UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)165/255 blue:(CGFloat)165/255 alpha:1.0];
        self.settingsTableView.scrollEnabled=NO;
        [self.view addSubview:self.settingsTableView];
    }
    self.settingsTableView.hidden=NO;
}

#pragma mark-

-(void)cancelButtonAction:(id)sender{
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
   // [[[[[UIApplication sharedApplication]keyWindow]subviews]lastObject]removeFromSuperview];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-Table delgate methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return cell_hh/2+20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cell_hh;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font=[UIFont systemFontOfSize:cell_font];
    if (indexPath.section==0) {
     
        cell.textLabel.text=@"Edit basic info";
    }
    else if (indexPath.section==1)
    {
        if (indexPath.row==0) {
            cell.textLabel.text=@"About";
        }
        else if(indexPath.row==1){
            cell.textLabel.text=@"Help";
        }
        else{
            cell.textLabel.text=@"Feedback";
        }
    }
    else if (indexPath.section==2)
    {
        if (indexPath.row==0) {
            cell.textLabel.text=@"Notification";
        }
        else if(indexPath.row==1){
            cell.textLabel.text=@"Privacy";
        }
        else if(indexPath.row==2){
            cell.textLabel.text=@"Account";
            
            if (!self.emailLabel) {
                self.emailLabel=[[UILabel alloc]init];
                self.emailLabel.frame=CGRectMake(80, 0, cell.frame.size.width-30, cell.frame.size.height);
                self.emailLabel.text=[SingletonClass shareSingleton].emailID;
                self.emailLabel.font=[UIFont systemFontOfSize:12];
                [cell.contentView addSubview:self.emailLabel];
            }
            self.emailLabel.hidden=NO;
            
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section==0) {
        if(indexPath.row==0)
        {
            if(!self.basicInfo)
            {
                self.basicInfo=[[BasicInfoViewController alloc]initWithNibName:@"BasicInfoViewController" bundle:nil];
            }
            //[appdelegate.window addSubview:self.basicInfo.view];
            [self.navigationController pushViewController:self.basicInfo animated:YES];
        }
    }
    if(indexPath.section==2)
    {
        if (indexPath.row==1) {
            if(!self.privacyVC)
            {
                self.privacyVC=[[PrivacyViewController alloc]initWithNibName:@"PrivacyViewController" bundle:nil];
                
            }
           // [appdelegate.window addSubview:self.privacyVC.view];
            [self.navigationController pushViewController:self.privacyVC animated:YES];
        }
    }
        if(indexPath.section==2)
        {
            if (indexPath.row==2) {
                if(!self.accountVC)
                {
                    
                    self.accountVC=[[AccountSignOutViewController alloc]initWithNibName:@"AccountSignOutViewController" bundle:nil];
                    
                }
                //[appdelegate.window addSubview:self.accountVC.view];
                [self.navigationController pushViewController:self.accountVC animated:YES];
            }
    }
    if(indexPath.section==2)
    {
        if (indexPath.row==0) {
            if(!self.notifyVC)
            {
                self.notifyVC=[[NotificationViewController alloc]initWithNibName:@"NotificationViewController" bundle:nil];
                
            }
            //[appdelegate.window addSubview:self.notifyVC.view];
            [self.navigationController pushViewController:self.notifyVC animated:YES];
        }
    }
    if(indexPath.section==1)
    {
        if (indexPath.row==2) {
            NSLog(@"Support at taka.dating");

           /* if(!self.feedBackVC)
            {
                self.feedBackVC=[[FeedBackViewController alloc]initWithNibName:@"FeedBackViewController" bundle:nil];
                
            }
          //  [appdelegate.window addSubview:self.feedBackVC.view];
            [self.navigationController pushViewController:self.feedBackVC animated:YES];*?
        }
    }
    if(indexPath.section==1)
    {
        if (indexPath.row==1) {
            NSLog(@"Support at taka.dating");
           /* if(!self.helpVC)
            {
                self.helpVC=[[HelpViewController alloc]initWithNibName:@"HelpViewController" bundle:nil];
                
            }
           //[appdelegate.window addSubview:self.helpVC.view];
            [self.navigationController pushViewController:self.helpVC animated:YES];*/
        }
    }
  
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rows;
    if(section==0)
    {
        rows=1;
        return rows;
    }
    else if (section==1)
    {
        rows =3;
        return rows;
    }
    else{
        rows =3;
        return rows;
        
    }
    return rows;

}



@end
