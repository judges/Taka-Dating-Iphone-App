//
//  PrivacyViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 17/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "PrivacyViewController.h"

@interface PrivacyViewController ()

@end

@implementation PrivacyViewController

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
    w=[UIScreen mainScreen].bounds.size;
    self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, w.width, 55);
    UIColor *firstColor = [UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
    UIColor *secColor = [UIColor colorWithRed:(CGFloat)121/255 green:(CGFloat)2/255 blue:(CGFloat)0/255 alpha:1.0];
    layer.colors = [NSArray arrayWithObjects:(id)[firstColor CGColor],(id)[secColor CGColor], nil];
    [self.view.layer insertSublayer:layer atIndex:0];
    
    //Adding title Label
    self.titleLabel=[[UILabel alloc]init];
    self.titleLabel.frame=CGRectMake(w.width/2-40, 25, 100, 25);
    self.titleLabel.text=@"Privacy";
    self.titleLabel.textColor=[UIColor whiteColor];
    self.titleLabel.font=[UIFont boldSystemFontOfSize:20];
    [self.view addSubview:self.titleLabel];
    
    //Add Cancel Button
    self.cancelButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.frame=CGRectMake(w.width/2-145, 25, 60, 25);
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    self.cancelButton.layer.borderColor=[[UIColor redColor]CGColor];
    self.cancelButton.titleLabel.font=[UIFont systemFontOfSize:15];
    self.cancelButton.layer.cornerRadius=4;
    self.cancelButton.clipsToBounds=YES;
    self.cancelButton.layer.borderWidth=0.7;
    [self.cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cancelButton];
    
    self.saveButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.saveButton.frame=CGRectMake(w.width/2-145, 25, 60, 25);
    [self.saveButton setTitle:@"Save" forState:UIControlStateNormal];
    self.saveButton.layer.borderColor=[[UIColor redColor]CGColor];
    self.saveButton.titleLabel.font=[UIFont systemFontOfSize:15];
    self.saveButton.layer.cornerRadius=4;
    self.saveButton.clipsToBounds=YES;
    self.saveButton.layer.borderWidth=0.7;
    [self.saveButton addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.saveButton];
    self.saveButton.hidden=YES;
    
    self.editButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.editButton.frame=CGRectMake(w.width-70, 25, 60, 25);
    [self.editButton setTitle:@"Edit" forState:UIControlStateNormal];
    self.editButton.layer.borderColor=[[UIColor redColor]CGColor];
    self.editButton.titleLabel.font=[UIFont systemFontOfSize:15];
    self.editButton.layer.cornerRadius=4;
    self.editButton.clipsToBounds=YES;
    self.editButton.layer.borderWidth=0.7;
    [self.editButton addTarget:self action:@selector(editButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.editButton];

    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        head_label_font=20.0;
        choise_font=15.0;
        layer.frame = CGRectMake(0, 0, w.width, 75);
        self.titleLabel.frame=CGRectMake(w.width/2-50, 30, w.width/2-200, 25);
        self.cancelButton.frame=CGRectMake(w.width/2-350, 30, 120, 25);
        self.saveButton.frame=CGRectMake(w.width-140, 30, 120, 25);
        self.editButton.frame=CGRectMake(w.width-140, 30, 120, 25);
    }
    else{
        head_label_font=14.0;
        choise_font=12.0;
    }
    
    [self createUI];

    // Do any additional setup after loading the view from its nib.
}
/*
-(void)createUI{
    if (!self.privacyTableView) {
        if ([UIScreen mainScreen].bounds.size.height>500) {
            self.privacyTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 55, self.view.frame.size.width, self.view.frame.size.height*3)];
        }
        else{
            self.privacyTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 55, self.view.frame.size.width, 420)];
        }
        self.privacyTableView.delegate=self;
        self.privacyTableView.dataSource=self;
        self.privacyTableView.backgroundColor=[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
        [self.view addSubview:self.privacyTableView];
    }
    self.privacyTableView.hidden=NO;
}
*/
/*
#pragma mark- table delegate methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section>=4) {
        return 0;
    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   // UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    UITableViewCell * cell=[tableView cellForRowAtIndexPath:indexPath];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if(indexPath.section==0)
    {
        if(indexPath.row==0)
        {
            
            
            self.switch1=[[UISwitch alloc]initWithFrame:CGRectMake(250, 5, 30, 30)];
            self.switch1.onTintColor=[UIColor greenColor];
            [cell.contentView addSubview:self.switch1];
            
            self.switch1.hidden=NO;
            cell.textLabel.text=@"Show distance";
        }
    }
    if(indexPath.section==1)
    {
        if(indexPath.row==0)
        {
         
            self.switch2=[[UISwitch alloc]initWithFrame:CGRectMake(250, 5, 30, 30)];
            self.switch2.onTintColor=[UIColor greenColor];
            [cell.contentView addSubview:self.switch2];
            
            self.switch2.hidden=NO;
            cell.textLabel.text=@"Show online status";
        }
    }
    if(indexPath.section==2)
    {
        if(indexPath.row==0)
        {
            
                self.switch3=[[UISwitch alloc]initWithFrame:CGRectMake(250, 5, 30, 30)];
                self.switch3.onTintColor=[UIColor greenColor];
                [cell.contentView addSubview:self.switch3];
            
            self.switch3.hidden=NO;
            

            cell.textLabel.text=@"Enabled public search";
        }
    }
    if(indexPath.section==3)
    {
        if(indexPath.row==0)
        {
         
            self.switch4=[[UISwitch alloc]initWithFrame:CGRectMake(250, 5, 30, 30)];
            self.switch4.onTintColor=[UIColor greenColor];
            [cell.contentView addSubview:self.switch4];
            
            self.switch4.hidden=NO;
            cell.textLabel.text=@"Enabled Bumped into";
        }
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0)
    {
        return 35;
    }
    else if (section==4)
    {
        return 120;
    }
    return 80;
}



-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80)];
    if(section==1)
    {
      
        UILabel * strLabel=[[UILabel alloc]init];
        strLabel.frame=CGRectMake(25, 10, 280, 70);
        strLabel.font=[UIFont systemFontOfSize:12];
        strLabel.textAlignment=NSTextAlignmentCenter;
        strLabel.lineBreakMode=NSLineBreakByCharWrapping;
        strLabel.numberOfLines=0;
        strLabel.text= @"User of Badoo prefer to see and connect with people near them.By turning this off,you may receive fewer messages.";;
        [strLabel sizeToFit];
        [footerView addSubview:strLabel];
        return footerView;

    }
    if(section==2)
    {
        
        UILabel * strLabel=[[UILabel alloc]init];
        strLabel.frame=CGRectMake(25, 10, 270, 70);
        strLabel.font=[UIFont systemFontOfSize:12];
        strLabel.textAlignment=NSTextAlignmentCenter;
        strLabel.lineBreakMode=NSLineBreakByCharWrapping;
        strLabel.numberOfLines=0;
        strLabel.text= @"People are more likely tocontact you if they know you are online";
        [strLabel sizeToFit];
        [footerView addSubview:strLabel];
        return footerView;
        
    }
    if(section==3)
    {
        
        UILabel * strLabel=[[UILabel alloc]init];
        strLabel.frame=CGRectMake(25, 10, 270, 70);
        strLabel.font=[UIFont systemFontOfSize:12];
        strLabel.textAlignment=NSTextAlignmentCenter;
        strLabel.lineBreakMode=NSLineBreakByCharWrapping;
        strLabel.numberOfLines=0;
        strLabel.text= @"With public search enabled,people can find your profile using internet search engines.";
        [strLabel sizeToFit];
        [footerView addSubview:strLabel];
        return footerView;
        
    }

    return footerView;
}*/
#pragma mark-

-(void)createUI{
    
    
    
    scroll=[[UIScrollView alloc]init];
    scroll.backgroundColor=[UIColor clearColor];
    [scroll setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:scroll];
    
    scroll.userInteractionEnabled=NO;
    
    scroll.contentSize=CGSizeMake(w.width, w.height*1.2);
    
    UIView * privacyView=[[UIView alloc]init];
    privacyView.backgroundColor=[UIColor whiteColor];
    [scroll addSubview:privacyView];
    
    UILabel * onlineStatus=[[UILabel alloc]init];
    onlineStatus.text=@"Show online status";
    onlineStatus.font=[UIFont systemFontOfSize:head_label_font];
    onlineStatus.backgroundColor=[UIColor clearColor];
    onlineStatus.textColor=[UIColor blackColor];
    [privacyView addSubview:onlineStatus];
    
    UIImageView * lineOne=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"red_line.png"]];
    [privacyView addSubview:lineOne];
    
    UILabel * distance=[[UILabel alloc]init];
    distance.text=@"Distance";
    distance.font=[UIFont systemFontOfSize:head_label_font];
    distance.backgroundColor=[UIColor clearColor];
    distance.textColor=[UIColor blackColor];
    [privacyView addSubview:distance];
    
    UIImageView * lineTwo=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"red_line.png"]];
    [privacyView addSubview:lineTwo];
    
    UILabel * viewProfile=[[UILabel alloc]init];
        viewProfile.text=@"viewProfile";
    viewProfile.font=[UIFont systemFontOfSize:head_label_font];
    viewProfile.backgroundColor=[UIColor clearColor];
    viewProfile.textColor=[UIColor blackColor];
    [privacyView addSubview:viewProfile];
    
    UIImageView * linethree=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"red_line.png"]];
       [privacyView addSubview:linethree];
    
    
    UILabel * securityLevel=[[UILabel alloc]init];
    securityLevel.text=@"securityLevel";
    securityLevel.font=[UIFont systemFontOfSize:head_label_font];
    securityLevel.backgroundColor=[UIColor clearColor];
    securityLevel.textColor=[UIColor blackColor];
    [privacyView addSubview:securityLevel];
    
    UIImageView * lineFour=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"red_line.png"]];
    
    [privacyView addSubview:lineFour];
    UILabel * browsing=[[UILabel alloc]init];
    
    browsing.text=@"browsing";
    browsing.font=[UIFont systemFontOfSize:head_label_font];
    browsing.backgroundColor=[UIColor clearColor];
    browsing.textColor=[UIColor blackColor];
    [privacyView addSubview:browsing];
    
    UIImageView * lineFive=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"red_line.png"]];
        [privacyView addSubview:lineFive];
    
    UILabel * publicSearch=[[UILabel alloc]init];
    publicSearch.text=@"publicSearch";
    publicSearch.font=[UIFont systemFontOfSize:head_label_font];
    publicSearch.backgroundColor=[UIColor clearColor];
    publicSearch.textColor=[UIColor blackColor];
    [privacyView addSubview:publicSearch];
    
    UIImageView * lineSix=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"red_line.png"]];
    
    [privacyView addSubview:lineSix];
    
    UILabel * find=[[UILabel alloc]init];
    find.text=@"Find";
    find.font=[UIFont systemFontOfSize:head_label_font];
    find.backgroundColor=[UIColor clearColor];
    find.textColor=[UIColor blackColor];
    [privacyView addSubview:find];
    
    
    
    //Show online status
    
    
    self.radioButtonStatusY=[UIButton buttonWithType:UIButtonTypeCustom];
    self.radioButtonStatusY.tag=0;
    
    
    [self.radioButtonStatusY addTarget:self action:@selector(radioButtonStatusAction:) forControlEvents:UIControlEventTouchUpInside];
    [privacyView addSubview:self.radioButtonStatusY];
    
    UILabel * yesLabel=[[UILabel alloc]init];
    yesLabel.text=@"YES";
    yesLabel.font=[UIFont systemFontOfSize:choise_font];
    yesLabel.textColor=[UIColor grayColor];
    [privacyView addSubview:yesLabel];
    
    UILabel * noLabel=[[UILabel alloc]init];
    noLabel.text=@"NO";
    noLabel.font=[UIFont systemFontOfSize:choise_font];
    noLabel.textColor=[UIColor grayColor];
    [privacyView addSubview:noLabel];
    
    self.radioButtonStatusN=[UIButton buttonWithType:UIButtonTypeCustom];
    self.radioButtonStatusN.tag=1;
    
    [self.radioButtonStatusN addTarget:self action:@selector(radioButtonStatusAction:) forControlEvents:UIControlEventTouchUpInside];
    [privacyView addSubview:self.radioButtonStatusN];
    
    if ([[SingletonClass shareSingleton].onlineStatus isEqualToString:@"Y"]) {
        [self.radioButtonStatusY setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
        [self.radioButtonStatusN setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
        [self.radioButtonStatusY setSelected:YES];
    }
    else{
        [self.radioButtonStatusY setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
         [self.radioButtonStatusN setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
        [self.radioButtonStatusN setSelected:YES];
    }
    
    
    //Show distance
    
    self.radioButtonDisY=[UIButton buttonWithType:UIButtonTypeCustom];
    
        self.radioButtonDisY.tag=0;
   
    [self.radioButtonDisY addTarget:self action:@selector(radioButtonDisAction:) forControlEvents:UIControlEventTouchUpInside];
    [privacyView addSubview:self.radioButtonDisY];
    
    UILabel * yesDisLabel=[[UILabel alloc]init];
    yesDisLabel.text=@"YES";
    yesDisLabel.font=[UIFont systemFontOfSize:choise_font];
    yesDisLabel.textColor=[UIColor grayColor];
    [privacyView addSubview:yesDisLabel];
    
    UILabel * noDisLabel=[[UILabel alloc]init];
    noDisLabel.text=@"NO";
    noDisLabel.font=[UIFont systemFontOfSize:choise_font];
    noDisLabel.textColor=[UIColor grayColor];
    [privacyView addSubview:noDisLabel];
    
    
    self.radioButtonDisN=[UIButton buttonWithType:UIButtonTypeCustom];
    self.radioButtonDisN.tag=1;
    
    [self.radioButtonDisN addTarget:self action:@selector(radioButtonDisAction:) forControlEvents:UIControlEventTouchUpInside];
    [privacyView addSubview:self.radioButtonDisN];
    
    if ([[SingletonClass shareSingleton].distance isEqualToString:@"Y"]) {
      [self.radioButtonDisN setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
        [self.radioButtonDisY setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
        [self.radioButtonDisY setSelected:YES];
        
    }
    else{
         [self.radioButtonDisN setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
        [self.radioButtonDisY setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
        [self.radioButtonDisN setSelected:YES];

    }
  
   

    
    
    //View Profile
    
    self.radioButtonViewY=[UIButton buttonWithType:UIButtonTypeCustom];
   // [self.radioButtonViewY setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
    self.radioButtonViewY.tag=0;
   // [self.radioButtonViewY setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
    [self.radioButtonViewY addTarget:self action:@selector(radioButtonViewAction:) forControlEvents:UIControlEventTouchUpInside];
    [privacyView addSubview:self.radioButtonViewY];
    
    UILabel * yesViewLabel=[[UILabel alloc]init];
    
    yesViewLabel.text=@"ANYONE";
    yesViewLabel.font=[UIFont systemFontOfSize:choise_font];
    yesViewLabel.textColor=[UIColor grayColor];
    [privacyView addSubview:yesViewLabel];
    
    UILabel * noViewLabel=[[UILabel alloc]init];
    noViewLabel.text=@"ONLY MEMBERS";
    noViewLabel.font=[UIFont systemFontOfSize:choise_font];
    noViewLabel.textColor=[UIColor grayColor];
    [privacyView addSubview:noViewLabel];
    
    
    self.radioButtonViewN=[UIButton buttonWithType:UIButtonTypeCustom];
       // [self.radioButtonViewN setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
    self.radioButtonViewN.tag=1;
   // [self.radioButtonViewN setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
    [self.radioButtonViewN addTarget:self action:@selector(radioButtonViewAction:) forControlEvents:UIControlEventTouchUpInside];
    [privacyView addSubview:self.radioButtonViewN];
    
    
    if ([[SingletonClass shareSingleton].viewProfile isEqualToString:@"A"]) {
        [self.radioButtonViewN setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
        [self.radioButtonViewY setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
        [self.radioButtonViewY setSelected:YES];
    }
    else{
        [self.radioButtonViewN setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
        [self.radioButtonViewY setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
        [self.radioButtonViewN setSelected:YES];
        
    }

    
    
    //Securiyt Level
    
    
    self.radioButtonSecurityY=[UIButton buttonWithType:UIButtonTypeCustom];
    //
    self.radioButtonSecurityY.tag=0;
  //
    [self.radioButtonSecurityY addTarget:self action:@selector(radioButtonSecurityAction:) forControlEvents:UIControlEventTouchUpInside];
    [privacyView addSubview:self.radioButtonSecurityY];
    
    UILabel * HighLabel=[[UILabel alloc]init];
    HighLabel.text=@"HIGH";
    HighLabel.font=[UIFont systemFontOfSize:choise_font];
    HighLabel.textColor=[UIColor grayColor];
    [privacyView addSubview:HighLabel];
    
    UILabel * LowLabel=[[UILabel alloc]init];
    LowLabel.text=@"LOW";
    LowLabel.font=[UIFont systemFontOfSize:choise_font];
    LowLabel.textColor=[UIColor grayColor];
    [privacyView addSubview:LowLabel];
    
    
    self.radioButtonSecurityN=[UIButton buttonWithType:UIButtonTypeCustom];
    self.radioButtonSecurityN.tag=1;
    
    [self.radioButtonSecurityN addTarget:self action:@selector(radioButtonSecurityAction:) forControlEvents:UIControlEventTouchUpInside];
    [privacyView addSubview:self.radioButtonSecurityN];
    
    
    self.radioButtonSecurityM=[UIButton buttonWithType:UIButtonTypeCustom];
    self.radioButtonSecurityM.tag=2;
    
    [self.radioButtonSecurityM addTarget:self action:@selector(radioButtonSecurityAction:) forControlEvents:UIControlEventTouchUpInside];
    [privacyView addSubview:self.radioButtonSecurityM];
    
    UILabel * mediumLabel=[[UILabel alloc]init];
    mediumLabel.text=@"MEDIUM";
    mediumLabel.font=[UIFont systemFontOfSize:choise_font];
    mediumLabel.textColor=[UIColor grayColor];
    [privacyView addSubview:mediumLabel];
    
    if ([[SingletonClass shareSingleton].securityLevel isEqualToString:@"H"]) {
        
        [self.radioButtonSecurityY setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
        [self.radioButtonSecurityN setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
         [self.radioButtonSecurityM setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
        [self.radioButtonSecurityY setSelected:YES];
    }
    else if([[SingletonClass shareSingleton].securityLevel isEqualToString:@"M"]){
        [self.radioButtonSecurityY setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
        [self.radioButtonSecurityN setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
        [self.radioButtonSecurityM setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
        [self.radioButtonSecurityM setSelected:YES];
    }
    else{
        [self.radioButtonSecurityY setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
        [self.radioButtonSecurityN setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
         [self.radioButtonSecurityM setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
        [self.radioButtonSecurityN setSelected:YES];
        
    }
    
        //Show borwsing
    
    self.radioButtonbrowY=[UIButton buttonWithType:UIButtonTypeCustom];
   
    [self.radioButtonbrowY setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
    self.radioButtonbrowY.tag=0;
   // [self.radioButtonbrowY setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
    [self.radioButtonbrowY addTarget:self action:@selector(radioButtonBrowAction:) forControlEvents:UIControlEventTouchUpInside];
    [privacyView addSubview:self.radioButtonbrowY];
    
    UILabel * yesBrowLabel=[[UILabel alloc]init];
    yesBrowLabel.text=@"YES";
    yesBrowLabel.font=[UIFont systemFontOfSize:choise_font];
    yesBrowLabel.textColor=[UIColor grayColor];
    [privacyView addSubview:yesBrowLabel];
    
    UILabel * noBrowLabel=[[UILabel alloc]init];
    noBrowLabel.text=@"NO";
    noBrowLabel.font=[UIFont systemFontOfSize:choise_font];
    noBrowLabel.textColor=[UIColor grayColor];
    [privacyView addSubview:noBrowLabel];
    
    
    self.radioButtonbrowN=[UIButton buttonWithType:UIButtonTypeCustom];
   // [self.radioButtonbrowN setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
    self.radioButtonbrowN.tag=1;
 //   [self.radioButtonbrowN setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
    [self.radioButtonbrowN addTarget:self action:@selector(radioButtonBrowAction:) forControlEvents:UIControlEventTouchUpInside];
    [privacyView addSubview:self.radioButtonbrowN];
    
    
    if ([[SingletonClass shareSingleton].browsing isEqualToString:@"Y"]) {
        [self.radioButtonbrowN setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
        [self.radioButtonbrowY setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
        [self.radioButtonbrowY setSelected:YES];
        
    }
    else{
        [self.radioButtonbrowN setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
        [self.radioButtonbrowY setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
        [self.radioButtonbrowN setSelected:YES];
        
    }

    
    //Show public search
    
    self.radioButtonSrchY=[UIButton buttonWithType:UIButtonTypeCustom];

   // [self.radioButtonSrchY setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
    self.radioButtonSrchY.tag=0;
  //  [self.radioButtonSrchY setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
    [self.radioButtonSrchY addTarget:self action:@selector(radioButtonSrchAction:) forControlEvents:UIControlEventTouchUpInside];
    [privacyView addSubview:self.radioButtonSrchY];
    
    UILabel * yesSrchLabel=[[UILabel alloc]init];
    yesSrchLabel.text=@"YES";
    yesSrchLabel.font=[UIFont systemFontOfSize:choise_font];
    yesSrchLabel.textColor=[UIColor grayColor];
    [privacyView addSubview:yesSrchLabel];
    
    UILabel * noSrchLabel=[[UILabel alloc]init];
    noSrchLabel.text=@"NO";
    noSrchLabel.font=[UIFont systemFontOfSize:choise_font];
    noSrchLabel.textColor=[UIColor grayColor];
    [privacyView addSubview:noSrchLabel];
    
    
    self.radioButtonSrchN=[UIButton buttonWithType:UIButtonTypeCustom];
  //  [self.radioButtonSrchN setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
    self.radioButtonSrchN.tag=1;
   // [self.radioButtonSrchN setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
    [self.radioButtonSrchN addTarget:self action:@selector(radioButtonSrchAction:) forControlEvents:UIControlEventTouchUpInside];
    [privacyView addSubview:self.radioButtonSrchN];
    if ([[SingletonClass shareSingleton].publicSearch isEqualToString:@"Y"]) {
        [self.radioButtonSrchN setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
        [self.radioButtonSrchY setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
        [self.radioButtonSrchY setSelected:YES];
        
    }
    else{
        [self.radioButtonSrchN setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
        [self.radioButtonSrchY setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
        [self.radioButtonSrchN setSelected:YES];
        
    }
    
    
    //Show Find
    
    self.radioButtonFindY=[UIButton buttonWithType:UIButtonTypeCustom];
   // [self.radioButtonFindY setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
    self.radioButtonFindY.tag=0;
   // [self.radioButtonFindY setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
    [self.radioButtonFindY addTarget:self action:@selector(radioButtonFindAction:) forControlEvents:UIControlEventTouchUpInside];
    [privacyView addSubview:self.radioButtonFindY];
    
    UILabel * yesFindLabel=[[UILabel alloc]init];
    yesFindLabel.text=@"YES";
    yesFindLabel.font=[UIFont systemFontOfSize:choise_font];
    yesFindLabel.textColor=[UIColor grayColor];
    [privacyView addSubview:yesFindLabel];
    
    UILabel * noFindLabel=[[UILabel alloc]init];
    noFindLabel.text=@"NO";
    noFindLabel.font=[UIFont systemFontOfSize:choise_font];
    noFindLabel.textColor=[UIColor grayColor];
    [privacyView addSubview:noFindLabel];
    
    
    self.radioButtonFindN=[UIButton buttonWithType:UIButtonTypeCustom];
   
   // [self.radioButtonFindN setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
    self.radioButtonFindN.tag=1;
   // [self.radioButtonFindN setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
    [self.radioButtonFindN addTarget:self action:@selector(radioButtonFindAction:) forControlEvents:UIControlEventTouchUpInside];
    [privacyView addSubview:self.radioButtonFindN];

    if ([[SingletonClass shareSingleton].find isEqualToString:@"Y"]) {
        [self.radioButtonFindN setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
        [self.radioButtonFindY setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
        [self.radioButtonFindY setSelected:YES];
        
    }
    else{
        [self.radioButtonFindN setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
        [self.radioButtonFindY setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
        [self.radioButtonFindN setSelected:YES];
        
    }

    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        scroll.frame=CGRectMake(0,150,w.width,w.height/2+200);
        privacyView.frame=CGRectMake(0, 0, w.width, w.height);
        
        
        onlineStatus.frame=CGRectMake(15, w.height/2-500, w.width, 50);
        self.radioButtonStatusY.frame=CGRectMake(15, w.height/2-440, 40, 40);
        self.radioButtonStatusN.frame=CGRectMake(140, w.height/2-440, 40, 40);
        noLabel.frame=CGRectMake(180, w.height/2-440, 40, 40);
        yesLabel.frame=CGRectMake(60, w.height/2-440, 40, 40);
        lineOne.frame=CGRectMake(15, w.height/2-400, w.width, 1);
        
        
        self.radioButtonDisN.frame=CGRectMake(140, w.height/2-350, 40, 40);
        noDisLabel.frame=CGRectMake(180, w.height/2-350, 40, 40);
        yesDisLabel.frame=CGRectMake(60, w.height/2-350, 40, 40);
        self.radioButtonDisY.frame=CGRectMake(15, w.height/2-350, 40, 40);
        distance.frame=CGRectMake(15, w.height/2-400, w.width, 50);
        
        viewProfile.frame=CGRectMake(15, w.height/2-300, w.width, 50);
        noViewLabel.frame=CGRectMake(180, w.height/2-250, 150, 40);
        self.radioButtonViewN.frame=CGRectMake(140, w.height/2-250, 40, 40);
        yesViewLabel.frame=CGRectMake(60, w.height/2-250, 80, 40);
        self.radioButtonViewY.frame=CGRectMake(15, w.height/2-250, 40, 40);
        
        lineTwo.frame=CGRectMake(15, w.height/2-300, w.width, 1);
       
        
        
        linethree.frame=CGRectMake(15, w.height/2-200, w.width, 1);
        
        
        lineFour.frame=CGRectMake(15, w.height/2-100, w.width, 1);
       
        lineFive.frame=CGRectMake(15, w.height/2, w.width, 1);
        
        lineSix.frame=CGRectMake(15, w.height/2+100, w.width, 1);
        
        
        securityLevel.frame=CGRectMake(15, w.height/2-200, w.width, 50);
        self.radioButtonSecurityY.frame=CGRectMake(15, w.height/2-150, 40, 40);
        self.radioButtonSecurityM.frame=CGRectMake(140, w.height/2-150, 40, 40);
        self.radioButtonSecurityN.frame=CGRectMake(290, w.height/2-150, 40, 40);
        HighLabel.frame=CGRectMake(60, w.height/2-150, 50, 40);
        mediumLabel.frame=CGRectMake(180, w.height/2-150, 90, 40);
        LowLabel.frame=CGRectMake(330, w.height/2-150, 50, 40);
       
        

        browsing.frame=CGRectMake(15, w.height/2-100, w.width, 50);
        self.radioButtonbrowY.frame=CGRectMake(15, w.height/2-50, 40, 40);
        yesBrowLabel.frame=CGRectMake(60, w.height/2-50, 40, 40);
        noBrowLabel.frame=CGRectMake(180, w.height/2-50, 40, 40);
        self.radioButtonbrowN.frame=CGRectMake(140, w.height/2-50, 40, 40);
        
        publicSearch.frame=CGRectMake(15, w.height/2, w.width, 50);
        self.radioButtonSrchY.frame=CGRectMake(15, w.height/2+50, 40, 40);
        yesSrchLabel.frame=CGRectMake(60, w.height/2+50, 40, 40);
        noSrchLabel.frame=CGRectMake(180, w.height/2+50, 40, 40);
        self.radioButtonSrchN.frame=CGRectMake(140, w.height/2+50, 40, 40);
        
        find.frame=CGRectMake(15, w.height/2+100, w.width, 50);
        self.radioButtonFindY.frame=CGRectMake(15, w.height/2+150, 40, 40);
        yesFindLabel.frame=CGRectMake(60, w.height/2+150, 40, 40);
        noFindLabel.frame=CGRectMake(180, w.height/2+150, 40, 40);
        self.radioButtonFindN.frame=CGRectMake(140, w.height/2+150, 40, 40);
        
    }
    else{
        if (w.height>500) {
            scroll.frame=CGRectMake(0,60,w.width,w.height);
            privacyView.frame=CGRectMake(0, 0, w.width, w.height-50);
            onlineStatus.frame=CGRectMake(15, w.height-540, w.width, 30);
            lineOne.frame=CGRectMake(15, w.height-480, w.width, 1);
            distance.frame=CGRectMake(15, w.height-480, w.width, 30);
            lineTwo.frame=CGRectMake(15, w.height-410, w.width, 1);
            viewProfile.frame=CGRectMake(15, w.height-410, w.width, 30);
            linethree.frame=CGRectMake(15, w.height-340, w.width, 1);
            securityLevel.frame=CGRectMake(15, w.height-340, w.width, 30);
            lineFour.frame=CGRectMake(15, w.height-270, w.width, 1);
            browsing.frame=CGRectMake(15, w.height-270, w.width, 30);
            lineFive.frame=CGRectMake(15, w.height-200, w.width, 1);
            publicSearch.frame=CGRectMake(15, w.height-200, w.width, 30);
            lineSix.frame=CGRectMake(15, w.height-130, w.width, 1);
            find.frame=CGRectMake(15, w.height-130, w.width, 30);
            self.radioButtonStatusY.frame=CGRectMake(15, w.height-510, 20, 20);
            self.radioButtonStatusN.frame=CGRectMake(70, w.height-510, 20, 20);
            noLabel.frame=CGRectMake(90, w.height-510, 20, 20);
            yesLabel.frame=CGRectMake(35, w.height-510, 30, 20);
            
            noViewLabel.frame=CGRectMake(110, w.height-380, 110, 20);
            self.radioButtonViewN.frame=CGRectMake(90, w.height-380, 20, 20);
            yesViewLabel.frame=CGRectMake(35, w.height-380, 110, 20);
            self.radioButtonViewY.frame=CGRectMake(15, w.height-380, 20, 20);
            
            yesDisLabel.frame=CGRectMake(35, w.height-450, 30, 20);
            self.radioButtonDisN.frame=CGRectMake(70, w.height-450, 20, 20);
            noDisLabel.frame=CGRectMake(90, w.height-450, 20, 20);
            self.radioButtonDisY.frame=CGRectMake(15, w.height-450, 20, 20);
            
            self.radioButtonSecurityY.frame=CGRectMake(15, w.height-300, 20, 20);
            HighLabel.frame=CGRectMake(35, w.height-300, 50, 20);
            LowLabel.frame=CGRectMake(190, w.height-300, 50, 20);
            self.radioButtonSecurityN.frame=CGRectMake(170, w.height-300, 20, 20);
            self.radioButtonSecurityM.frame=CGRectMake(90, w.height-300, 20, 20);
            mediumLabel.frame=CGRectMake(110, w.height-300, 90, 20);
            
            self.radioButtonbrowY.frame=CGRectMake(15, w.height-230, 20, 20);
            yesBrowLabel.frame=CGRectMake(35, w.height-230, 30, 20);
            noBrowLabel.frame=CGRectMake(90, w.height-230, 20, 20);
            self.radioButtonbrowN.frame=CGRectMake(70, w.height-230, 20, 20);
            
            self.radioButtonSrchY.frame=CGRectMake(15, w.height-160, 20, 20);
            yesSrchLabel.frame=CGRectMake(35, w.height-160, 30, 20);
            noSrchLabel.frame=CGRectMake(90, w.height-160, 20, 20);
            self.radioButtonSrchN.frame=CGRectMake(70, w.height-160, 20, 20);
            
            self.radioButtonFindY.frame=CGRectMake(15, w.height-110, 20, 20);
            yesFindLabel.frame=CGRectMake(35, w.height-110, 30, 20);
            noFindLabel.frame=CGRectMake(90, w.height-110, 20, 20);
            self.radioButtonFindN.frame=CGRectMake(70, w.height-110, 20, 20);
        }
        else{
        
        scroll.frame=CGRectMake(0,60,w.width,w.height);
        privacyView.frame=CGRectMake(0, 0, w.width, w.height);
        onlineStatus.frame=CGRectMake(15, w.height-480, w.width, 30);
        lineOne.frame=CGRectMake(15, w.height-420, w.width, 1);
        distance.frame=CGRectMake(15, w.height-420, w.width, 30);
        lineTwo.frame=CGRectMake(15, w.height-350, w.width, 1);
        viewProfile.frame=CGRectMake(15, w.height-350, w.width, 30);
        linethree.frame=CGRectMake(15, w.height-280, w.width, 1);
        securityLevel.frame=CGRectMake(15, w.height-280, w.width, 30);
        lineFour.frame=CGRectMake(15, w.height-210, w.width, 1);
        browsing.frame=CGRectMake(15, w.height-210, w.width, 30);
        lineFive.frame=CGRectMake(15, w.height-140, w.width, 1);
        publicSearch.frame=CGRectMake(15, w.height-140, w.width, 30);
        lineSix.frame=CGRectMake(15, w.height-70, w.width, 1);
        find.frame=CGRectMake(15, w.height-70, w.width, 30);
        self.radioButtonStatusY.frame=CGRectMake(15, w.height-450, 20, 20);
        self.radioButtonStatusN.frame=CGRectMake(70, w.height-450, 20, 20);
        noLabel.frame=CGRectMake(90, w.height-450, 20, 20);
        yesLabel.frame=CGRectMake(35, w.height-450, 30, 20);
        
        noViewLabel.frame=CGRectMake(110, w.height-320, 110, 20);
        self.radioButtonViewN.frame=CGRectMake(90, w.height-320, 20, 20);
        yesViewLabel.frame=CGRectMake(35, w.height-320, 110, 20);
        self.radioButtonViewY.frame=CGRectMake(15, w.height-320, 20, 20);
        
        yesDisLabel.frame=CGRectMake(35, w.height-390, 30, 20);
        self.radioButtonDisN.frame=CGRectMake(70, w.height-390, 20, 20);
        noDisLabel.frame=CGRectMake(90, w.height-390, 20, 20);
        self.radioButtonDisY.frame=CGRectMake(15, w.height-390, 20, 20);
        
        self.radioButtonSecurityY.frame=CGRectMake(15, w.height-240, 20, 20);
        HighLabel.frame=CGRectMake(35, w.height-240, 50, 20);
        LowLabel.frame=CGRectMake(190, w.height-240, 50, 20);
        self.radioButtonSecurityN.frame=CGRectMake(170, w.height-240, 20, 20);
        self.radioButtonSecurityM.frame=CGRectMake(90, w.height-240, 20, 20);
        mediumLabel.frame=CGRectMake(110, w.height-240, 90, 20);
        
        self.radioButtonbrowY.frame=CGRectMake(15, w.height-170, 20, 20);
        yesBrowLabel.frame=CGRectMake(35, w.height-170, 30, 20);
        noBrowLabel.frame=CGRectMake(90, w.height-170, 20, 20);
        self.radioButtonbrowN.frame=CGRectMake(70, w.height-170, 20, 20);
        
        self.radioButtonSrchY.frame=CGRectMake(15, w.height-100, 20, 20);
        yesSrchLabel.frame=CGRectMake(35, w.height-100, 30, 20);
        noSrchLabel.frame=CGRectMake(90, w.height-100, 20, 20);
        self.radioButtonSrchN.frame=CGRectMake(70, w.height-100, 20, 20);
        
        self.radioButtonFindY.frame=CGRectMake(15, w.height-50, 20, 20);
        yesFindLabel.frame=CGRectMake(35, w.height-50, 30, 20);
        noFindLabel.frame=CGRectMake(90, w.height-50, 20, 20);
        self.radioButtonFindN.frame=CGRectMake(70, w.height-50, 20, 20);
        }
    }
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Radio Button Method
-(void)radioButtonStatusAction:(id)sender{
    
    //self.radio_Select=YES;
    switch ([sender tag]) {
        case 0:
            if([self.radioButtonStatusY isSelected]==YES)
            {
                // [self.radioButtonGirl setSelected:NO];
                // [self.radioButtonBoy setSelected:YES];
            }
            else{
                [self.radioButtonStatusY setSelected:YES];
                [self.radioButtonStatusN setSelected:NO];
                [self.radioButtonStatusY setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
                [self.radioButtonStatusN setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
                [self.radioButtonStatusY setSelected:YES];
                radiobutton=@"Y";
                [SingletonClass shareSingleton].onlineStatus=@"Y";
                
            }
            
            break;
            
        case 1:
            if([self.radioButtonStatusN isSelected]==YES)
            {
                //  [self.radioButtonBoy setSelected:NO];
                // [self.radioButtonGirl setSelected:YES];
            }
            else{
                [self.radioButtonStatusN setSelected:YES];
                [self.radioButtonStatusY setSelected:NO];
                [self.radioButtonStatusY setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
                [self.radioButtonStatusN setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
                [self.radioButtonStatusN setSelected:YES];
                radiobutton=@"N";
                 [SingletonClass shareSingleton].onlineStatus=@"N";
                
            }
            
            break;
            
        default:
            break;
    }
    
    
}

-(void)radioButtonDisAction:(id)sender{
    
    //self.radio_Select=YES;
    switch ([sender tag]) {
        case 0:
            if([self.radioButtonDisY isSelected]==YES)
            {
                // [self.radioButtonGirl setSelected:NO];
                // [self.radioButtonBoy setSelected:YES];
            }
            else{
                [self.radioButtonDisY setSelected:YES];
                [self.radioButtonDisN setSelected:NO];
                [self.radioButtonDisN setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
                [self.radioButtonDisY setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
                [self.radioButtonDisY setSelected:YES];

                radiobuttonDis=@"Y";
                 [SingletonClass shareSingleton].distance=@"Y";
                
            }
            
            break;
            
        case 1:
            if([self.radioButtonDisN isSelected]==YES)
            {
                //  [self.radioButtonBoy setSelected:NO];
                // [self.radioButtonGirl setSelected:YES];
            }
            else{
                [self.radioButtonDisN setSelected:YES];
                [self.radioButtonDisY setSelected:NO];
                [self.radioButtonDisN setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
                [self.radioButtonDisY setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
                [self.radioButtonDisN setSelected:YES];
                radiobuttonDis=@"N";
                 [SingletonClass shareSingleton].distance=@"N";
            }
            
            break;
            
        default:
            break;
    }
    
    
}

-(void)radioButtonViewAction:(id)sender{
    
    //self.radio_Select=YES;
    switch ([sender tag]) {
        case 0:
            if([self.radioButtonViewY isSelected]==YES)
            {
                // [self.radioButtonGirl setSelected:NO];
                // [self.radioButtonBoy setSelected:YES];
            }
            else{
                [self.radioButtonViewY setSelected:YES];
                [self.radioButtonViewN setSelected:NO];
                [self.radioButtonViewN setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
                [self.radioButtonViewY setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
                [self.radioButtonViewY setSelected:YES];
                radiobuttonView=@"A";
                 [SingletonClass shareSingleton].viewProfile=@"A";
                
            }
            
            break;
            
        case 1:
            if([self.radioButtonViewN isSelected]==YES)
            {
                //  [self.radioButtonBoy setSelected:NO];
                // [self.radioButtonGirl setSelected:YES];
            }
            else{
                [self.radioButtonViewN setSelected:YES];
                [self.radioButtonViewY setSelected:NO];
                [self.radioButtonViewN setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
                [self.radioButtonViewY setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
                [self.radioButtonViewN setSelected:YES];
                radiobuttonView=@"M";
                 [SingletonClass shareSingleton].viewProfile=@"M";
                
            }
            
            break;
            
        default:
            break;
    }
    
    
}

-(void)radioButtonSecurityAction:(id)sender{
    
    //self.radio_Select=YES;
    switch ([sender tag]) {
        case 0:
            if([self.radioButtonSecurityY isSelected]==YES)
            {
                // [self.radioButtonGirl setSelected:NO];
                // [self.radioButtonBoy setSelected:YES];
            }
            else{
                [self.radioButtonSecurityY setSelected:YES];
                [self.radioButtonSecurityN setSelected:NO];
                [self.radioButtonSecurityM setSelected:NO];
                
                [self.radioButtonSecurityY setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
                [self.radioButtonSecurityN setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
                [self.radioButtonSecurityM setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
                [self.radioButtonSecurityY setSelected:YES];
                radioButtonSecurity=@"H";
                 [SingletonClass shareSingleton].securityLevel=@"H";
                
            }
            
            break;
            
        case 1:
            if([self.radioButtonSecurityN isSelected]==YES)
            {
                //  [self.radioButtonBoy setSelected:NO];
                // [self.radioButtonGirl setSelected:YES];
            }
            else{
                [self.radioButtonSecurityN setSelected:YES];
                [self.radioButtonSecurityY setSelected:NO];
                [self.radioButtonSecurityM setSelected:NO];
                [self.radioButtonSecurityY setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
                [self.radioButtonSecurityN setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
                [self.radioButtonSecurityM setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
                [self.radioButtonSecurityN setEnabled:YES];
                radioButtonSecurity=@"L";
                [SingletonClass shareSingleton].securityLevel=@"L";
                
            }
            
            break;
            
            
        case 2:
            if([self.radioButtonSecurityM isSelected]==YES)
            {
                //  [self.radioButtonBoy setSelected:NO];
                // [self.radioButtonGirl setSelected:YES];
            }
            else{
                [self.radioButtonSecurityM setSelected:YES];
                [self.radioButtonSecurityY setSelected:NO];
                [self.radioButtonSecurityN setSelected:NO];
                [self.radioButtonSecurityY setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
                [self.radioButtonSecurityN setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
                [self.radioButtonSecurityM setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
                 [self.radioButtonSecurityM setSelected:YES];
                radioButtonSecurity=@"M";
                [SingletonClass shareSingleton].securityLevel=@"Ms";
                
            }
            
            break;
        default:
            break;
    }
    
    
}

-(void)radioButtonBrowAction:(id)sender{
    
    //self.radio_Select=YES;
    switch ([sender tag]) {
        case 0:
            if([self.radioButtonbrowY isSelected]==YES)
            {
                // [self.radioButtonGirl setSelected:NO];
                // [self.radioButtonBoy setSelected:YES];
            }
            else{
                [self.radioButtonbrowY setSelected:YES];
                [self.radioButtonbrowN setSelected:NO];
                [self.radioButtonbrowN setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
                [self.radioButtonbrowY setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
                [self.radioButtonbrowY setSelected:YES];
                radiobuttonBrowsing=@"Y";
                [SingletonClass shareSingleton].browsing=@"Y";
                
            }
            
            break;
            
        case 1:
            if([self.radioButtonbrowN isSelected]==YES)
            {
                //  [self.radioButtonBoy setSelected:NO];
                // [self.radioButtonGirl setSelected:YES];
            }
            else{
                [self.radioButtonbrowN setSelected:YES];
                [self.radioButtonbrowY setSelected:NO];
                [self.radioButtonbrowN setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
                [self.radioButtonbrowY setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
                [self.radioButtonbrowN setSelected:YES];
                radiobuttonBrowsing=@"N";
                [SingletonClass shareSingleton].browsing=@"N";
                
            }
            
            break;
        default:
            break;
    }
    
    
}


-(void)radioButtonSrchAction:(id)sender{
    
    //self.radio_Select=YES;
    switch ([sender tag]) {
        case 0:
            if([self.radioButtonSrchY isSelected]==YES)
            {
                // [self.radioButtonGirl setSelected:NO];
                // [self.radioButtonBoy setSelected:YES];
            }
            else{
                [self.radioButtonSrchY setSelected:YES];
                [self.radioButtonSrchN setSelected:NO];
                [self.radioButtonSrchN setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
                [self.radioButtonSrchY setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
                [self.radioButtonSrchY setSelected:YES];
                radioButtonSrch=@"Y";
                [SingletonClass shareSingleton].publicSearch=@"Y";
                
            }
            
            break;
            
        case 1:
            if([self.radioButtonSrchN isSelected]==YES)
            {
                
            }
            else{
                [self.radioButtonSrchN setSelected:YES];
                [self.radioButtonSrchY setSelected:NO];
                [self.radioButtonSrchN setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
                [self.radioButtonSrchY setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
                [self.radioButtonSrchN setSelected:YES];
                radioButtonSrch=@"N";
                [SingletonClass shareSingleton].publicSearch=@"N";
                
            }
            
            break;
        default:
            break;
    }
    
    
}

-(void)radioButtonFindAction:(id)sender{
    
    //self.radio_Select=YES;
    switch ([sender tag]) {
        case 0:
            if([self.radioButtonFindY isSelected]==YES)
            {
                // [self.radioButtonGirl setSelected:NO];
                // [self.radioButtonBoy setSelected:YES];
            }
            else{
                [self.radioButtonFindY setSelected:YES];
                [self.radioButtonFindN setSelected:NO];
                [self.radioButtonFindN setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
                [self.radioButtonFindY setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
                [self.radioButtonFindY setSelected:YES];
                radiobuttonFind=@"Y";
                [SingletonClass shareSingleton].find=@"Y";
                
            }
            
            break;
            
        case 1:
            if([self.radioButtonFindN isSelected]==YES)
            {
                //  [self.radioButtonBoy setSelected:NO];
                // [self.radioButtonGirl setSelected:YES];
            }
            else{
                [self.radioButtonFindN setSelected:YES];
                [self.radioButtonFindY setSelected:NO];
                [self.radioButtonFindN setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
                [self.radioButtonFindY setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
                [self.radioButtonFindN setSelected:YES];
                radiobuttonFind=@"N";
                [SingletonClass shareSingleton].find=@"Y";
                
            }
            
            break;
        default:
            break;
    }
    
    
}

-(void)editButtonMethod{
    scroll.userInteractionEnabled=YES;
    self.cancelButton.hidden=YES;
    self.saveButton.hidden=NO;
    self.editButton.hidden=YES;
}

#pragma mark-
-(void)saveButtonAction:(id)sender{
    scroll.userInteractionEnabled=NO;
    self.cancelButton.hidden=NO;
    self.saveButton.hidden=YES;
    self.editButton.hidden=NO;
    NSError * error;
    NSURLResponse * urlResponse;
   /* NSString * urlStr=[NSString stringWithFormat:@"http://taka.dating/privacy/update/%@/%@/%@/%@/%@/%@/%@/%@",[SingletonClass shareSingleton].userID,[SingletonClass shareSingleton].onlineStatus,[SingletonClass shareSingleton].distance,[SingletonClass shareSingleton].viewProfile,[SingletonClass shareSingleton].securityLevel,[SingletonClass shareSingleton].browsing,[SingletonClass shareSingleton].publicSearch,[SingletonClass shareSingleton].find];*/
    NSURL * url=[NSURL URLWithString:@"http://23.238.24.26/settings/privacy/"];
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSString * body=[NSString stringWithFormat:@"userId=%@&onlineStatus=%@&distance=%@&viewProfile=%@&securityLevel=%@&browsing=%@&publicSearch=%@&find=%@",[SingletonClass shareSingleton].userID,[SingletonClass shareSingleton].onlineStatus,[SingletonClass shareSingleton].distance,[SingletonClass shareSingleton].viewProfile,[SingletonClass shareSingleton].securityLevel,[SingletonClass shareSingleton].browsing,[SingletonClass shareSingleton].publicSearch,[SingletonClass shareSingleton].find];
    
    
    [request setHTTPBody:[body dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
     NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (!data) {
        NSLog(@"No data available");
        return;
        
    }
    id parse=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"privacy parse %@",parse);
   
}
-(void)cancelButtonAction:(id)sender{
      //[[[[[UIApplication sharedApplication]keyWindow]subviews]lastObject]removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
