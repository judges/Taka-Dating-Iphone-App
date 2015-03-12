//
//  AccountInfoViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 11/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "AccountInfoViewController.h"
#import "AppDelegate.h"
#import "SettingViewController.h"

@interface AccountInfoViewController ()
@property(nonatomic,strong)SettingViewController * settingVC;

@end

@implementation AccountInfoViewController

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

#pragma mark-

-(void)createUI{
    
    self.scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 55, self.view.frame.size.width, self.view.frame.size.height)];
    
    [self.view addSubview:self.scrollView];
    self.scrollView.scrollEnabled=NO;
    
    self.scrollView.contentSize=CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    
    CAGradientLayer *layerView = [CAGradientLayer layer];
    layerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    UIColor *firstClr = [UIColor colorWithRed:(CGFloat)203/255 green:(CGFloat)93/255 blue:(CGFloat)92/255 alpha:1.0];
    UIColor *secClr = [UIColor colorWithRed:(CGFloat)129/255 green:(CGFloat)3/255 blue:(CGFloat)4/255 alpha:1.0];
    UIColor *thirdClr = [UIColor colorWithRed:(CGFloat)203/255 green:(CGFloat)93/255 blue:(CGFloat)92/255 alpha:1.0];
    layerView.colors = [NSArray arrayWithObjects:(id)[firstClr CGColor],(id)[secClr CGColor], (id)[thirdClr CGColor],nil];
    [self.scrollView.layer insertSublayer:layerView atIndex:0];
    
    
    
    
    //Adding AddPhoto Label
    
    self.addPhotoLabel=[[UILabel alloc]init];
    self.addPhotoLabel.frame=CGRectMake(60, self.view.frame.size.height/2, self.view.frame.size.width-70, 30);
    self.addPhotoLabel.text=@"Add photos of yourself";
    self.addPhotoLabel.textColor=[UIColor whiteColor];
    self.addPhotoLabel.font=[UIFont systemFontOfSize:22];
    [self.addPhotoLabel sizeToFit];
    [self.scrollView addSubview:self.addPhotoLabel];
    
    
    //Adding TabBarController
    
   // if(!self.tabBarController)
   // {
       // self.tabBarController=[[UITabBarController alloc]init];
    
  // self.tabBarController.view.frame = CGRectMake(0, self.scrollView.frame.size.height-95, 320, 40);
  //  self.tabBarController.view.backgroundColor=[UIColor blackColor];
   // [self.scrollView addSubview:self.tabBarController.view];
  //  self.tabBarController.view.hidden=NO;

       if(!self.tabView)
       {
       self.tabView=[[UIView alloc]init];
           
        self.tabView.frame = CGRectMake(0, self.scrollView.frame.size.height-95, 320, 40);
        self.tabView.backgroundColor=[UIColor blackColor];
            [self.scrollView addSubview:self.tabView];
    
    UIButton * profile=[UIButton buttonWithType:UIButtonTypeCustom];
    [profile setTitle:@"profile" forState:UIControlStateNormal];
    profile.frame=CGRectMake(5, 10, 50, 20);
    profile.titleLabel.font=[UIFont boldSystemFontOfSize:9];
    profile.backgroundColor=[UIColor redColor];
    profile.tag=1;
    [profile addTarget:self action:@selector(selectIndexOfTabbar:) forControlEvents:UIControlEventTouchUpInside];
    
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
    [CreditsBtn addTarget:self action:@selector(selectIndexOfTabbar:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tabView addSubview:CreditsBtn];
    
    UIButton * OffBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [OffBtn setTitle:@"Off" forState:UIControlStateNormal];
    OffBtn.frame=CGRectMake(265, 10, 50, 20);
    OffBtn.titleLabel.font=[UIFont boldSystemFontOfSize:9];
    OffBtn.backgroundColor=[UIColor redColor];
    //[OffBtn addTarget:self action:@selector(OffButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabView addSubview:OffBtn];
    
    }
    
   self.tabView.hidden=NO;

}

#pragma mark-tabbarindex selection
-(void)selectIndexOfTabbar:(UIButton*)sender
{
   self.tabView.hidden=NO;
    if ([sender tag]==1) {
     //   if(self.scrollView.scrollEnabled==NO)
      ///  {
      //      self.scrollView.scrollEnabled=YES;
      //  }
       // else{
        //    self.scrollView.scrollEnabled=NO;
       // }
        self.tabView.hidden=NO;
         //self.tabBarController.view.hidden=NO;
        [self animationFunction];
        [self createProfileView];
       
    }
    else if([sender tag]==3)
    {
        //if(self.scrollView.scrollEnabled==NO)
       // {
           // self.scrollView.scrollEnabled=YES;
       // }
      //  else{
      //      self.scrollView.scrollEnabled=NO;
      //  }
         self.tabView.hidden=NO;
        //self.tabBarController.view.hidden=NO;
        [self animationFunction];
        [self createCreditsView];
    }
    
}


    



#pragma mark- Profile View

-(void)createProfileView{

    self.creditsTableView .hidden=YES;
    self.profileTableView.hidden=NO;
    self.tabView.hidden=NO;
    
    //self.tabBarController.view.hidden=NO;
    if(!self.profileTableView)
    {
    self.profileTableView=[[UITableView alloc]init];
    self.profileTableView.frame=CGRectMake(0, 245, self.scrollView.frame.size.width, 320);
    }
    self.profileTableView.delegate=self;
    self.profileTableView.dataSource=self;
    self.profileTableView.backgroundColor=[UIColor darkGrayColor];
    [self.view addSubview:self.profileTableView];
    
}


#pragma mark- animation of UI
-(void)animationFunction{
    self.tabView.hidden=NO;
    //self.tabBarController.view.hidden=NO;
    if(self.scrollView.scrollEnabled==NO)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.0];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.scrollView.frame = CGRectMake(self.scrollView.frame.origin.x, (self.scrollView.frame.origin.y-320 ), self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        //self.scrollView.contentOffset=CGPointMake(self.scrollView.frame.origin.x, (self.tabView.frame.origin.y));
        self.scrollView.backgroundColor=[UIColor blueColor];
        [UIView commitAnimations];
        self.scrollView.scrollEnabled=YES;
        self.tabBarController.view.hidden=NO;
        self.tabView.hidden=NO;
        
    }
    else{
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.0];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.scrollView.frame=CGRectMake(0, 55, self.view.bounds.size.width,self.view.bounds.size.height);
        self.scrollView.scrollEnabled=NO;
        //self.tabBarController.view.hidden=NO;
         self.tabView.hidden=NO;
    }
    

}

#pragma mark- Credits View
-(void)createCreditsView
{
    self.tabView.hidden=NO;
    self.creditsTableView .hidden=NO;
    self.profileTableView.hidden=YES;
    //self.tabBarController.view.hidden=NO;
    if(!self.creditsTableView)
    {
        self.creditsTableView=[[UITableView alloc]init];
        self.creditsTableView.frame=CGRectMake(0, 245, self.scrollView.frame.size.width, 320);
    }
    self.creditsTableView.delegate=self;
    self.creditsTableView.dataSource=self;
    self.creditsTableView.backgroundColor=[UIColor darkGrayColor];
    [self.view addSubview:self.creditsTableView];

}





#pragma mark- tableView Delegate methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    int sectins=0;
    if(tableView==self.profileTableView)
    {
        sectins=3;
    return sectins;
    }
    else if(tableView==self.creditsTableView)
    {
        sectins=1;
        return sectins;
    }
    return sectins;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int rows;
    if(tableView==self.profileTableView)
    {
        NSLog(@"section %ld",(long)section);
        if (section ==0 || section==1) {
            rows=1;
            return rows;
        }
        else{
            rows =5;
          return rows;
        }
    }
    if(tableView==self.creditsTableView)
    {
        rows =1;
        return rows;
    }
    return rows;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *    cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }

    if (tableView==self.profileTableView) {
             return cell;
    }
    else if (tableView==self.creditsTableView)
    {
        if(indexPath.row==0)
        {
            UILabel * topLabel=[[UILabel alloc]init];
            topLabel.frame=CGRectMake(25, 10, cell.frame.size.width-50, 60);
            topLabel.text=@"Boosting your popularity just got really easy! Refill your Taka credits and meet new people faster than ever.";
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
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString * str;
    if (tableView==self.profileTableView) {
    if(section==0)
    {
        str=@"Awards";
    }
    else if(section==1)
    {
        str=@" ";
    }else{
       str =@"Profile";
    }
}
    return str;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView==self.creditsTableView)
    {
        return 340;
    }
    return 45;
}


#pragma mark-

-(void)settingButtonAction:(id)sender{
    
    if (!self.settingVC) {
        self.settingVC=[[SettingViewController alloc]initWithNibName:@"SettingViewController" bundle:nil];
    }
    
    [self.navigationController pushViewController:self.settingVC animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
