//
//  ProfileViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 13/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "ProfileViewController.h"
#import "SettingViewController.h"

@interface ProfileViewController ()
@property(nonatomic,strong)SettingViewController * settingVC;

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


- (void)viewDidLoad
{
    [super viewDidLoad];
    // [[self navigationController] setNavigationBarHidden:YES animated:YES];
  
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, self.view.frame.size.width, 55);
    UIColor *firstColor = [UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
    UIColor *secColor = [UIColor colorWithRed:(CGFloat)121/255 green:(CGFloat)2/255 blue:(CGFloat)0/255 alpha:1.0];
    layer.colors = [NSArray arrayWithObjects:(id)[firstColor CGColor],(id)[secColor CGColor], nil];
    [self.view.layer insertSublayer:layer atIndex:0];
    
    self.settingButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.settingButton.frame=CGRectMake(230, 25, 70, 25);
    self.settingButton.layer.borderColor=[[UIColor redColor]CGColor];
    self.settingButton.layer.borderWidth=0.7;
    self.settingButton.clipsToBounds=YES;
    self.settingButton.layer.cornerRadius=4;
    [self.settingButton setTitle:@"Settings" forState:UIControlStateNormal];
    [self.settingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.settingButton.titleLabel.font=[UIFont systemFontOfSize:15];
    [self.settingButton addTarget:self action:@selector(settingButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.settingButton];
    
    
    self.titleLabel=[[UILabel alloc]init];
    self.titleLabel.frame=CGRectMake(100, 25, 100, 25);
    self.titleLabel.text=@"Manjunath";
    self.titleLabel.font=[UIFont systemFontOfSize:17];
    self.titleLabel.textColor=[UIColor whiteColor];
    [self.view addSubview:self.titleLabel];
   
    
    
    [self createUI];

    
    // Do any additional setup after loading the view from its nib.
}

-(void)createUI{
    /*CAGradientLayer *layerView = [CAGradientLayer layer];
    layerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    UIColor *firstClr = [UIColor colorWithRed:(CGFloat)203/255 green:(CGFloat)93/255 blue:(CGFloat)92/255 alpha:1.0];
    UIColor *secClr = [UIColor colorWithRed:(CGFloat)129/255 green:(CGFloat)3/255 blue:(CGFloat)4/255 alpha:1.0];
    UIColor *thirdClr = [UIColor colorWithRed:(CGFloat)203/255 green:(CGFloat)93/255 blue:(CGFloat)92/255 alpha:1.0];
    layerView.colors = [NSArray arrayWithObjects:(id)[firstClr CGColor],(id)[secClr CGColor], (id)[thirdClr CGColor],nil];
    [self.view.layer insertSublayer:layerView atIndex:0];*/
    
    if(!self.parentView)
    {
        self.parentView=[[UIView alloc]init];
        if([UIScreen mainScreen].bounds.size.height>500)
        {
            self.parentView.frame=CGRectMake(0, 55, self.view.frame.size.width, 510);
        }
        else{
             self.parentView.frame=CGRectMake(0, 55, self.view.frame.size.width, 380);
        }
        self.parentView.backgroundColor=[UIColor colorWithRed:(CGFloat)129/255 green:(CGFloat)3/255 blue:(CGFloat)4/255 alpha:1.0];
        [self.view addSubview:self.parentView];

    }
    self.parentView.hidden=NO;
    
    
    UISwipeGestureRecognizer * gestureUp=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(GestureHandlerUp:)];
    gestureUp.direction=UISwipeGestureRecognizerDirectionUp;
   
    [self.parentView addGestureRecognizer:gestureUp];
    
    UISwipeGestureRecognizer * gestureDown=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(GestureHandlerDown:)];
    gestureDown.direction=UISwipeGestureRecognizerDirectionDown;
    
    [self.parentView addGestureRecognizer:gestureDown];
    
    if(!self.tabView)
    {
        self.tabView=[[UIView alloc]init];
        
        if([UIScreen mainScreen].bounds.size.height>500)
        {
            self.tabView.frame = CGRectMake(0, self.parentView.frame.size.height-40, 320, 45);
        }
        else{
            self.tabView.frame = CGRectMake(0, 380, 320, 45);
        }
        self.tabView.backgroundColor=[UIColor blackColor];
        [self.parentView addSubview:self.tabView];
        
        UIButton * profile=[UIButton buttonWithType:UIButtonTypeCustom];
        [profile setTitle:@"profile" forState:UIControlStateNormal];
        profile.frame=CGRectMake(5, 10, 50, 20);
        profile.titleLabel.font=[UIFont boldSystemFontOfSize:9];
        profile.backgroundColor=[UIColor redColor];
        profile.tag=1;
        [profile addTarget:self action:@selector(profileButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.tabView addSubview:profile];
        
        
        UIButton * photosBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [photosBtn setTitle:@"photos" forState:UIControlStateNormal];
        photosBtn.frame=CGRectMake(95, 10, 50, 20);
        photosBtn.titleLabel.font=[UIFont boldSystemFontOfSize:9];
        photosBtn.backgroundColor=[UIColor redColor];
        //[photosBtn addTarget:self action:@selector(photoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabView addSubview:photosBtn];
        
        UIButton * CreditsBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [CreditsBtn setTitle:@"Credits" forState:UIControlStateNormal];
        CreditsBtn.frame=CGRectMake(185, 10, 50, 20);
        CreditsBtn.titleLabel.font=[UIFont boldSystemFontOfSize:9];
        CreditsBtn.backgroundColor=[UIColor redColor];
        CreditsBtn.tag=3;
        [CreditsBtn addTarget:self action:@selector(creditsButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.tabView addSubview:CreditsBtn];
        
        UIButton * OffBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [OffBtn setTitle:@"Off" forState:UIControlStateNormal];
        OffBtn.frame=CGRectMake(265, 10, 50, 20);
        OffBtn.titleLabel.font=[UIFont boldSystemFontOfSize:9];
        OffBtn.backgroundColor=[UIColor redColor];
        OffBtn.tag=4;
        [OffBtn addTarget:self action:@selector(superPowerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabView addSubview:OffBtn];
        
    }
    
    self.tabView.hidden=NO;
}

-(void)settingButtonAction:(id)sender{
    
    if (!self.settingVC) {
        self.settingVC=[[SettingViewController alloc]initWithNibName:@"SettingViewController" bundle:nil];
    }
    
    [self.navigationController pushViewController:self.settingVC animated:YES];
    
}



#pragma mark-gesture handler

-(void)GestureHandlerUp:(UISwipeGestureRecognizer *)swipe{
   
    /*[UIView animateWithDuration:0.5 animations:^{
        self.parentView.frame=CGRectMake(0, -300, self.view.frame.size.width, 380);
        self.navigationController.navigationBarHidden=NO;
        self.bottomView.hidden=NO;
        
    }];*/
    [[NSUserDefaults standardUserDefaults]setInteger:1 forKey:@"tag"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    self.state=YES;
    [UIView animateWithDuration:0.5 animations:^{
        if([UIScreen mainScreen].bounds.size.height>500)
        {
            
            self.parentView.frame = CGRectMake(0, 55, 320, 250);
           self.tabView.frame=CGRectMake(0, 115, self.parentView.frame.size.width, 45);
        }
        else{
            self.parentView.frame = CGRectMake(0, 55, 320, 380);
        }
      ///  self.parentView.frame=CGRectMake(0, -300, self.view.frame.size.width, 380);
        self.navigationController.navigationBarHidden=NO;
        
        
    } completion:^(BOOL finished) {
        [self createUIForProfileTableView];
        self.state=YES;
        
    }];
    
    
}

-(void)GestureHandlerDown:(UISwipeGestureRecognizer *)swipe{
    self.bottomView.hidden=YES;
    self.state=NO;
    [UIView animateWithDuration:0.5 animations:^{
        if([UIScreen mainScreen].bounds.size.height>500)
        {
            
            self.parentView.frame = CGRectMake(0, 55, 320, 510);
            self.tabView.frame=CGRectMake(0, self.parentView.frame.size.height-40, self.parentView.frame.size.width, 45);
            
        }
        else{
            self.parentView.frame = CGRectMake(0, 55, 320, 380);
        }
        self.state=NO;
    }];
    
}

#pragma mark- create UI for TableView

-(void)createUIBottomView{
    if (!self.bottomView) {
        self.bottomView=[[UIView alloc]init];
        if ([UIScreen mainScreen].bounds.size.height>500) {
            self.bottomView.frame=CGRectMake(0, 215 , self.view.frame.size.width, 510);
        }
        else{
            self.bottomView.frame=CGRectMake(0, 150, self.view.frame.size.width, 380);
        }
        self.bottomView.backgroundColor=[UIColor grayColor];
        [self.view addSubview:self.bottomView];
    }
    self.bottomView.hidden=NO;
}

-(void)createUIForProfileTableView{
    
    [self createUIBottomView];
    self.creditsTableView.hidden=YES;
    self.superPowerTableView.hidden=YES;
    if(!self.profileTableView)
    {
        self.profileTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.bottomView.frame.size.width, self.bottomView.frame.size.height)];
        self.profileTableView.delegate=self;
        self.profileTableView.dataSource=self;
        [self.bottomView addSubview:self.profileTableView];
    }
    self.profileTableView.hidden=NO;
}

-(void)createUIForCreditsTableView{
    
    [self createUIBottomView];
    self.profileTableView.hidden=YES;
    self.superPowerTableView.hidden=YES;
    if(!self.creditsTableView)
    {
    self.creditsTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.bottomView.frame.size.width, self.bottomView.frame.size.height)];
    self.creditsTableView.delegate=self;
    self.creditsTableView.dataSource=self;
    [self.bottomView addSubview:self.creditsTableView];
    }
    self.creditsTableView.hidden=NO;
}
-(void)createUIForSuperPowerView{
    [self createUIBottomView];
    self.profileTableView.hidden=YES;
    self.creditsTableView.hidden=YES;
    if(!self.superPowerTableView)
    {
        self.superPowerTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.bottomView.frame.size.width, self.bottomView.frame.size.height)];
        self.superPowerTableView.delegate=self;
        self.superPowerTableView.dataSource=self;
        [self.bottomView addSubview:self.superPowerTableView];
    }
    self.superPowerTableView.hidden=NO;

}


#pragma mark- table view delegate methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int rows=1;
    if (tableView==self.profileTableView) {
        if (section==0|| section==1) {
            rows=1;
            return rows;
        }
        else if(section==2)
        {
            rows=5;
            return rows;
        }
        else{
            return rows;
        }
    }
    if (tableView==self.superPowerTableView) {
        rows=1;
        return rows;
    }
    return rows;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if(tableView==self.profileTableView)
    {
        return  cell;
    }
    if (tableView==self.creditsTableView) {
        
        if(indexPath.row==0)
        {
            UILabel * topLabel=[[UILabel alloc]init];
            topLabel.frame=CGRectMake(25, 10, cell.frame.size.width-50, 60);
            topLabel.text=@"Boosting your popularity just got really easy! Refill your Taka Dating credits and meet new people faster than ever.";
            topLabel.font=[UIFont systemFontOfSize:11];
            topLabel.textColor=[UIColor blackColor];
            topLabel.lineBreakMode=NSLineBreakByCharWrapping;
            topLabel.numberOfLines=0;
            [topLabel sizeToFit];
            [cell.contentView addSubview:topLabel];
            
            UILabel * bottomLabel=[[UILabel alloc]init];
            bottomLabel.frame=CGRectMake(80, 70, 200, 60);
            bottomLabel.text=@"Your credit balance";
            bottomLabel.font=[UIFont boldSystemFontOfSize:12];
            bottomLabel.textColor=[UIColor blackColor];
            bottomLabel.lineBreakMode=NSLineBreakByCharWrapping;
            bottomLabel.numberOfLines=0;
            [bottomLabel sizeToFit];
            [cell.contentView addSubview:bottomLabel];
            
            UIButton * refillCredits=[UIButton buttonWithType:UIButtonTypeCustom];
            refillCredits.frame=CGRectMake(50, 200, 200, 25);
            [refillCredits setTitle:@"Refill credits" forState:UIControlStateNormal];
            refillCredits.backgroundColor=[UIColor blueColor];
            refillCredits.layer.cornerRadius=4;
            refillCredits.clipsToBounds=YES;
            refillCredits.titleLabel.textColor=[UIColor whiteColor];
            [cell.contentView addSubview:refillCredits];
            return cell;
        }
    
    
        return cell;
    }
    if(tableView==self.superPowerTableView)
    {
        return  cell;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView==self.creditsTableView)
    {
        return 250;
    }
    return 45;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    int sections;
    if (tableView==self.profileTableView) {
        sections=3;
        return sections;
    }
    if(tableView==self.creditsTableView)
    {
        sections =1;
        return sections;
    }
    if(tableView==self.superPowerTableView)
    {
        sections=3;
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
    if (tableView==self.creditsTableView) {
        
        str=@"";
       return str;
    }
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
    }
    return str;
}

#pragma mark- All Button actions here

-(void)profileButtonAction:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setInteger:[sender tag] forKey:@"tag"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    long senders=(long)[sender tag];
   
    if (self.state==NO||self.selectedIndex==1) {
        if (self.animation==NO) {
        //if(self.tabView.frame.origin.y>150){
            [self animationFunctonUP:senders];
            self.animation=YES;
        }
        else{
            [self animationFunctonDown:senders];
            self.animation=NO;
          
        }
    }
    else{
        [self createUIForProfileTableView];
        self.creditsTableView.hidden=YES;
        self.superPowerTableView.hidden=YES;
        //self.state=NO;
        
    }
    self.selectedIndex=[sender tag];
    
}
-(void)creditsButtonAction:(id)sender{
    [[NSUserDefaults standardUserDefaults]setInteger:[sender tag] forKey:@"tag"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    long senders=(long)[sender tag];
    
    if (self.state==NO||self.selectedIndex==3) {
    if (self.animation==NO) {
        [self animationFunctonUP:senders];
        self.animation=YES;
    }
    else{
        [self animationFunctonDown:senders];
        self.animation=NO;
        
    }
    }
    else
    {
        [self createUIForCreditsTableView];
        self.profileTableView.hidden=YES;
        self.superPowerTableView.hidden=YES;
        //self.state=NO;
    }
    self.selectedIndex=[sender tag];
}

-(void)superPowerButtonAction:(id)sender{
    [[NSUserDefaults standardUserDefaults]setInteger:[sender tag] forKey:@"tag"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    long senders=(long)[sender tag];
    
    if (self.state==NO||self.selectedIndex==4) {
        if (self.animation==NO) {
            [self animationFunctonUP:senders];
            self.animation=YES;
        }
        else{
            [self animationFunctonDown:senders];
            self.animation=NO;
            
        }
    }
    else
    {
        [self createUIForSuperPowerView ];
        self.profileTableView.hidden=YES;
        self.creditsTableView.hidden=YES;
        //self.state=NO;
    }
    self.selectedIndex=[sender tag];
}

#pragma mark-Animation funtion

-(void)animationFunctonUP:(long)sender{
    [UIView animateWithDuration:0.5 animations:^{
        if([UIScreen mainScreen].bounds.size.height>500)
        {
            
            self.parentView.frame = CGRectMake(0, 55, 320, 250);
            self.tabView.frame=CGRectMake(0, 115, self.parentView.frame.size.width, 45);
        }
        else{
            self.parentView.frame = CGRectMake(0, 55, 320, 380);
        }
        ///  self.parentView.frame=CGRectMake(0, -300, self.view.frame.size.width, 380);
        self.navigationController.navigationBarHidden=NO;
        
        
    } completion:^(BOOL finished) {
        long tag=[[NSUserDefaults standardUserDefaults]integerForKey:@"tag"];
        self.state=YES;
        if(tag==1)
        {
            [self createUIForProfileTableView];
        }
        else if (tag==3)
        {
            [self createUIForCreditsTableView];
        }
        else if(tag==4)
        {
            [self createUIForSuperPowerView];
        }
    }];

}

-(void)animationFunctonDown:(long)sender{
    
    self.bottomView.hidden=YES;
    [UIView animateWithDuration:0.5 animations:^{
        if([UIScreen mainScreen].bounds.size.height>500)
        {
            
            self.parentView.frame = CGRectMake(0, 55, 320, 510);
            self.tabView.frame=CGRectMake(0, self.parentView.frame.size.height-40, self.parentView.frame.size.width, 45);
            
        }
        else{
            self.parentView.frame = CGRectMake(0, 55, 320, 380);
        }
        self.state=NO;
    }];

}
    
#pragma mark-Super power View creation
-(void)superPowerFirstViewCreation
{
    self.firstView=[[UIView alloc]init];
    self.firstView.frame=CGRectMake(0, 0, 320, 200);
    self.firstView.backgroundColor=[UIColor clearColor];
   
    UIButton * threeMonthsButton=[UIButton buttonWithType:UIButtonTypeCustom];
    threeMonthsButton.frame=CGRectMake(10, 20, 200, 25);
    [threeMonthsButton setTitle:@"3 months at 450.00 INR/month" forState:UIControlStateNormal];
    
    
    
    [threeMonthsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    threeMonthsButton.backgroundColor=[UIColor greenColor];
    threeMonthsButton.layer.cornerRadius=4;
    threeMonthsButton.clipsToBounds=YES;
    [self.firstView addSubview:threeMonthsButton];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
