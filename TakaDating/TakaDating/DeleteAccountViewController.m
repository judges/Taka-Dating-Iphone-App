//
//  DeleteAccountViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 02/12/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "DeleteAccountViewController.h"

@interface DeleteAccountViewController ()
{
    NSArray * deleteArr;
}

@end

@implementation DeleteAccountViewController

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
    
    deleteArr=[NSArray arrayWithObjects:@"I receive too many emails",@"I'm in a relationship",@"I don't understand howt to use Taka",@"Taka  Dating is just not what I thought it would be",@"I don't find Taka useful"@"I don't want to pay for Taka",@"Other",nil];
    
    self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    
    UIView * headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 55)];
    [self.view addSubview:headerView];
    
    
     CAGradientLayer * layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, self.view.frame.size.width, 55);
    UIColor *firstColor = [UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
    UIColor *secColor = [UIColor colorWithRed:(CGFloat)121/255 green:(CGFloat)2/255 blue:(CGFloat)0/255 alpha:1.0];
    layer.colors = [NSArray arrayWithObjects:(id)[firstColor CGColor],(id)[secColor CGColor], nil];
    [headerView.layer insertSublayer:layer atIndex:0];
    
    //Adding title Label
    self.titleLabel=[[UILabel alloc]init];
    self.titleLabel.frame=CGRectMake(120, 25, 150, 25);
    self.titleLabel.text=@"Delete Account";
    self.titleLabel.textColor=[UIColor whiteColor];
    self.titleLabel.font=[UIFont boldSystemFontOfSize:20];
    [headerView addSubview:self.titleLabel];
    
    //Add Cancel Button
    self.cancelButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.frame=CGRectMake(15, 25, 60, 25);
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    self.cancelButton.layer.borderColor=[[UIColor redColor]CGColor];
    self.cancelButton.titleLabel.font=[UIFont systemFontOfSize:15];
    self.cancelButton.layer.cornerRadius=4;
    self.cancelButton.clipsToBounds=YES;
    self.cancelButton.layer.borderWidth=0.7;
    [self.cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:self.cancelButton];
    
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark- createUI

-(void)createUI{
      scroll=[[UIScrollView alloc]init];
    if ([UIScreen mainScreen].bounds.size.height<500) {
        scroll.frame=CGRectMake(0, 55, self.view.frame.size.width, self.view.frame.size.height-100);
    }
    else{
        scroll.frame=CGRectMake(0, 55, self.view.frame.size.width, self.view.frame.size.height);
    }
    [self.view addSubview:scroll];
    scroll.contentSize=CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    if (!self.deleteTable) {
        self.deleteTable=[[UITableView alloc]init];
    if ([UIScreen mainScreen].bounds.size.height>500) {
        self.deleteTable.frame=CGRectMake(0, 100, self.view.frame.size.width, 300);
    }
    else{
        self.deleteTable.frame=CGRectMake(0, 70, self.view.frame.size.width, 300);
    }
}
    self.deleteTable.scrollEnabled=NO;
    self.deleteTable.delegate=self;
    self.deleteTable.dataSource=self;
    self.deleteTable.backgroundColor=[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    self.deleteTable.separatorColor=[UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)165/255 blue:(CGFloat)165/255 alpha:1.0];
    
    [scroll addSubview:self.deleteTable];
    
    UILabel * label=[[UILabel alloc]init];
    label.frame=CGRectMake(10, 30, 300, 30);
    label.text=@"Sorry to see you go,please tell us your reason for leaving.";
    label.font=[UIFont systemFontOfSize:12];
    label.textAlignment=NSTextAlignmentCenter;
    label.lineBreakMode=NSLineBreakByCharWrapping;
    label.numberOfLines=0;
    
    [scroll addSubview:label];
    
    UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(20, 420, 280, 30);
    button.backgroundColor=[UIColor blueColor];
    [button setTitle:@"Delete Account" forState:UIControlStateNormal];
    
    [scroll addSubview:button];
    
     option=[[UITextField alloc]init];
    option.frame=CGRectMake(20, 380, 280, 30);
    option.placeholder=@"Your comment (Optional)";
    option.font=[UIFont systemFontOfSize:13];
    option.textAlignment=NSTextAlignmentCenter;
    option.backgroundColor=[UIColor whiteColor];
    option.layer.borderColor=[UIColor lightGrayColor].CGColor;
    option.layer.borderWidth=0.7;
    option.layer.cornerRadius=4;
    option.clipsToBounds=YES;
    option.delegate=self;
    [option setEnabled:NO];
    [scroll addSubview:option];
    

}
#pragma mark- Texfield Delegate method

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.5 animations:^{
        scroll.frame=CGRectMake(0, 55, self.view.frame.size.width, self.view.frame.size.height-250);
    } completion:^(BOOL finished) {
        
    }];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    

    [UIView animateWithDuration:0.5 animations:^{
        
        if ([UIScreen mainScreen].bounds.size.height<500) {
            scroll.frame=CGRectMake(0, 55, self.view.frame.size.width, self.view.frame.size.height-100);
        }
        else{
            scroll.frame=CGRectMake(0, 55, self.view.frame.size.width, self.view.frame.size.height);
        }
        
    } completion:^(BOOL finished) {
        
    }];
    return  YES;
}


#pragma mark-table delegate methods


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section!=0) {
        return 0;
    }
    return 6;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell=[tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.font=[UIFont boldSystemFontOfSize:10];
    cell.textLabel.lineBreakMode=NSLineBreakByCharWrapping;
    cell.textLabel.numberOfLines=0;
    cell.textLabel.text=[deleteArr objectAtIndex:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==5) {
        [option setEnabled:YES];
        option.placeholder=@"Your comment (required)";
    }
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (selectedIndex==indexPath)
    {
        return;
    }
    
    UITableViewCell *old = [tableView cellForRowAtIndexPath:selectedIndex];
    old.accessoryType = UITableViewCellAccessoryNone;
    [old setSelected:FALSE animated:TRUE];
    
    
    
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    [cell setSelected:TRUE animated:TRUE];
    
    
    selectedIndex = indexPath;
}

#pragma mark- Cancel Button clicked

-(void)cancelButtonAction:(id)sender{
    [[[[[UIApplication sharedApplication]keyWindow]subviews]lastObject]removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
