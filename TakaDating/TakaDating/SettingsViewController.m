//
//  SettingsViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 11/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "SettingsViewController.h"
#import "BasicInfoViewController.h"
#import "AccountSignOutViewController.h"
#import "SingletonClass.h"

@interface SettingsViewController ()
@property(nonatomic,strong)BasicInfoViewController * basicInfoVC;
@property(nonatomic,strong)AccountSignOutViewController * signOut;

@end

@implementation SettingsViewController

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
    windowSize =[UIScreen mainScreen].bounds.size;
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, windowSize.width, 55);
    UIColor *firstColor = [UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
    UIColor *secColor = [UIColor colorWithRed:(CGFloat)121/255 green:(CGFloat)2/255 blue:(CGFloat)0/255 alpha:1.0];
    layer.colors = [NSArray arrayWithObjects:(id)[firstColor CGColor],(id)[secColor CGColor], nil];
    [self.view.layer insertSublayer:layer atIndex:0];
    
    //Adding title Label
    self.titleLabel=[[UILabel alloc]init];
    self.titleLabel.frame=CGRectMake(windowSize.width/2-40, 25, 100, 25);
    self.titleLabel.text=@"Settings";
    self.titleLabel.textColor=[UIColor whiteColor];
    self.titleLabel.font=[UIFont boldSystemFontOfSize:20];
    [self.view addSubview:self.titleLabel];
    
    //Add Cancel Button
    self.cancelButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.frame=CGRectMake(windowSize.width/2-145, 25, 60, 25);
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    self.cancelButton.layer.borderColor=[[UIColor redColor]CGColor];
    self.cancelButton.titleLabel.font=[UIFont systemFontOfSize:15];
    self.cancelButton.layer.cornerRadius=4;
    self.cancelButton.clipsToBounds=YES;
    self.cancelButton.layer.borderWidth=0.7;
    [self.cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cancelButton];
    
    [self createUI];
    
    
    // Do any additional setup after loading the view from its nib.
}

#pragma mark-

-(void)createUI{
    
    self.cellValues=[NSArray arrayWithObjects:@"Basic Info",@"Account",@"Account Preferences",@"Help",@"About",@"Blocked Users", nil];
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0.0, 55, windowSize.width, windowSize.height)];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor=[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    self.tableView.scrollEnabled=NO;
    [self.view addSubview:self.tableView];
}


#pragma mark- tableView Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellIdentifier=@"cell";
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.backgroundColor=[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    cell.textLabel.text=[self.cellValues objectAtIndex:indexPath.row];
    cell.textLabel.font=[UIFont systemFontOfSize:12];
    tableView.separatorColor=[UIColor colorWithRed:(CGFloat)257/255 green:(CGFloat)97/255 blue:(CGFloat)97/255 alpha:1.0];
    if(indexPath.row==1)
    {
     NSLog(@"Email ID : %@",[SingletonClass shareSingleton].emailID);
        CGRect  frame1=CGRectMake(20, 50, 200, 30);
        UILabel * accountLabel=[[UILabel alloc]init];
        accountLabel.frame=frame1;
        accountLabel.text=[SingletonClass shareSingleton].emailID;
        accountLabel.font=[UIFont systemFontOfSize:12];
        [cell.contentView addSubview:accountLabel];
        
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0)
    {
        if(!self.basicInfoVC)
        {
            self.basicInfoVC=[[BasicInfoViewController alloc]init];
        }
        [self.navigationController pushViewController:self.basicInfoVC animated:YES];
    }
    else if (indexPath.row==1)
    {
        if(!self.signOut)
        {
            self.signOut=[[AccountSignOutViewController alloc]initWithNibName:@"AccountSignOutViewController" bundle:nil];
        }
        [self.navigationController pushViewController:self.signOut animated:YES];
    }
}

#pragma mark-

-(void)cancelButtonAction:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
