//
//  RelationshipViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 28/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "RelationshipViewController.h"
#import "AppDelegate.h"
#import "SingletonClass.h"

@interface RelationshipViewController ()

@end

@implementation RelationshipViewController

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
    
    relationArray=[NSArray arrayWithObjects:@"Unfilled yet",@"Single",@"Taken",@"Open", nil];
    sexualityArr=[NSArray arrayWithObjects:@"Unfilled yet",@"Straight",@"Open Minded",@"Bisexual",@"Gay",@"Lesbian", nil];
    livingArr=[NSArray arrayWithObjects:@"Unfilled yet",@"With Parents",@"With Roommate",@"Student Residence",@"With Partner",@"Alone", nil];
     kidsArr=[NSArray arrayWithObjects:@"Unfilled yet",@"No, Never",@"Someday",@"Already Have",@"Empty nest", nil];
    smokingArr=[NSArray arrayWithObjects:@"Unfilled yet",@"No",@"No, Never",@"Yes",@"Social",@"Chain Smoker, Oxygen is overrated", nil];
    drinkingArr=[NSArray arrayWithObjects:@"Unfilled yet",@"No",@"No, Never",@"Yes, Please",@"With Company", nil];
    educationArr=[NSArray arrayWithObjects:@"Unfilled yet",@"School only",@"Trade/Technical",@"College/University",@"Advanced Degree", nil];
    
    self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, windowSize.width, 55);
    UIColor *firstColor = [UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
    UIColor *secColor = [UIColor colorWithRed:(CGFloat)121/255 green:(CGFloat)2/255 blue:(CGFloat)0/255 alpha:1.0];
    layer.colors = [NSArray arrayWithObjects:(id)[firstColor CGColor],(id)[secColor CGColor], nil];
    [self.view.layer insertSublayer:layer atIndex:0];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.frame=CGRectMake(windowSize.width/2-60, 20, windowSize.width-200, 35);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.text = self.titleStr;
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

    self.saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saveButton.frame = CGRectMake(windowSize.width-70, 25, 60, 25);
    [self.saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.saveButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.saveButton setTitle:@"Save" forState:UIControlStateNormal];
    self.saveButton.layer.borderColor = [UIColor redColor].CGColor;
    self.saveButton.layer.borderWidth = 0.7;
    self.saveButton.layer.cornerRadius = 4;
    self.saveButton.clipsToBounds = YES;
    [self.saveButton addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.saveButton];
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
       
        layer.frame = CGRectMake(0, 0, windowSize.width, 75);
        self.titleLabel.frame=CGRectMake(windowSize.width/2-270, 25, windowSize.width-200, 35);
        self.cancelButton.frame = CGRectMake(windowSize.width/2-350, 25, 120, 40);
        self.saveButton.frame = CGRectMake(windowSize.width-150, 25, 120, 40);
        self.saveButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:30];
        height_frm_top=75;
        row_hh=85;
        cell_font=25;
    }
    else{
        height_frm_top=55;
        row_hh=40;
        cell_font=12;
    }
    
    [self createUI];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)createUI{
    if (!self.relationTable) {
        self.relationTable=[[UITableView alloc]init];
        //if ([UIScreen mainScreen].bounds.size.height>500) {
        
       /* }
        else{
            self.relationTable.frame=CGRectMake(0,55, self.view.frame.size.width, self.view.frame.size.height-50);
        }*/
     
            self.relationTable.frame=CGRectMake(0, height_frm_top, windowSize.width, windowSize.height-50);
        }
    self.relationTable.delegate=self;
    self.relationTable.dataSource=self;
    self.relationTable.backgroundColor=[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    self.relationTable.separatorColor=[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    self.relationTable.scrollEnabled=NO;
    [self.view addSubview:self.relationTable];
}

#pragma mark- Table Delegate methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.index==3) {
        return  relationArray.count;
    }
    else if (self.index==4)
    {
        return sexualityArr.count;
    }
    else if (self.index==6)
    {
        return livingArr.count;
    }
    else if (self.index==7)
    {
        return kidsArr.count;
    }
    else if (self.index==8)
    {
        return smokingArr.count;
    }
    else if (self.index==9)
    {
        return  drinkingArr.count;
    }
    else if (self.index==10)
    {
        return educationArr.count;
    }
    else {
        return  0;
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return row_hh+20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return row_hh;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell=[tableView cellForRowAtIndexPath:indexPath];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        imgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"checkmark_ipad.png"]];
    }
    cell.textLabel.font=[UIFont systemFontOfSize:cell_font];
    if (self.index==3) {
        cell.textLabel.text=[relationArray objectAtIndex:indexPath.row];
        NSString * relation=[[SingletonClass shareSingleton].relation stringByReplacingOccurrencesOfString:@"Relationship:" withString:@""];
        relation=[relation stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        if ([relation isEqualToString:cell.textLabel.text]) {
             if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
                 cell.accessoryView=imgView;
             }
             else{
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
             }
            [cell setSelected:TRUE animated:TRUE];
            selectedIndex=indexPath;
            selectedRow=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
        }
    }
    else if (self.index==4)
    {
         cell.textLabel.text=[sexualityArr objectAtIndex:indexPath.row];
        NSString * sexuality=[[SingletonClass shareSingleton].sexuality stringByReplacingOccurrencesOfString:@"sexuality:" withString:@""];
        sexuality=[sexuality stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        if ([sexuality isEqualToString:cell.textLabel.text]) {
            if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
                cell.accessoryView=imgView;
            }
            else{
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            [cell setSelected:TRUE animated:TRUE];
            selectedIndex=indexPath;
            selectedRow=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
        }
    }
    else if (self.index==6)
    {
        cell.textLabel.text=[livingArr objectAtIndex:indexPath.row];
        NSString * Living=[[SingletonClass shareSingleton].Living stringByReplacingOccurrencesOfString:@"Living:" withString:@""];
        Living=[Living stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        if ([Living isEqualToString:cell.textLabel.text]) {
            if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
                cell.accessoryView=imgView;
            }
            else{
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            [cell setSelected:TRUE animated:TRUE];
            selectedIndex=indexPath;
            selectedRow=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
        }
    }
    else if (self.index==7)
    {
        cell.textLabel.text=[kidsArr objectAtIndex:indexPath.row];
        NSString * children=[[SingletonClass shareSingleton].children stringByReplacingOccurrencesOfString:@"Kids:" withString:@""];
        children=[children stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        if ([children isEqualToString:cell.textLabel.text]) {
            if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
                cell.accessoryView=imgView;
            }
            else{
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            [cell setSelected:TRUE animated:TRUE];
            selectedIndex=indexPath;
            selectedRow=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
        }
    }
    else if (self.index==8)
    {
        cell.textLabel.text=[smokingArr objectAtIndex:indexPath.row];
        NSString * smoking=[[SingletonClass shareSingleton].smoking stringByReplacingOccurrencesOfString:@"Smoking:" withString:@""];
        smoking=[smoking stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        if ([smoking isEqualToString:cell.textLabel.text]) {
            if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
                cell.accessoryView=imgView;
            }
            else{
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }            [cell setSelected:TRUE animated:TRUE];
            selectedIndex=indexPath;
            selectedRow=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
        }
    }
    else if (self.index==9)
    {
        cell.textLabel.text=[drinkingArr objectAtIndex:indexPath.row];
        NSString * dirinking=[[SingletonClass shareSingleton].dirinking stringByReplacingOccurrencesOfString:@"Drinking:" withString:@""];
        dirinking=[dirinking stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        if ([dirinking isEqualToString:cell.textLabel.text]) {
            if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
                cell.accessoryView=imgView;
            }
            else{
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            [cell setSelected:TRUE animated:TRUE];
            selectedIndex=indexPath;
            selectedRow=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
        }
    }
    else if (self.index==10)
    {
        cell.textLabel.text=[educationArr objectAtIndex:indexPath.row];
        NSString * education=[[SingletonClass shareSingleton].education stringByReplacingOccurrencesOfString:@"Education:" withString:@""];
        education=[education stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        if ([education isEqualToString:cell.textLabel.text]) {
            if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
                cell.accessoryView=imgView;
            }
            else{
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            [cell setSelected:TRUE animated:TRUE];
            selectedIndex=indexPath;
            selectedRow=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
            
        }

    }
    
    return  cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (selectedIndex==indexPath)
        {
            return;
        }
        
        UITableViewCell *old = [tableView cellForRowAtIndexPath:selectedIndex];
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            imgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"checkmark_ipad.png"]];
            old.accessoryView=nil;
        }
        else{
            old.accessoryType = UITableViewCellAccessoryNone;
        }
        [old setSelected:FALSE animated:TRUE];
        
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            imgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"checkmark_ipad.png"]];
            cell.accessoryView=imgView;
        }
        else{
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
                [cell setSelected:TRUE animated:TRUE];
        
        
        selectedIndex = indexPath;
        if (self.index==3) {
            [SingletonClass shareSingleton].relation=[relationArray objectAtIndex:indexPath.row];
            selectedRow=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
        }
        else if (self.index==4)
        {
            [SingletonClass shareSingleton].sexuality=[sexualityArr objectAtIndex:indexPath.row];
            selectedRow=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
        }
        else if (self.index==6)
        {
           [SingletonClass shareSingleton].Living=[livingArr objectAtIndex:indexPath.row];
            selectedRow=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
        }
        else if (self.index==7)
        {
            [SingletonClass shareSingleton].children=[kidsArr objectAtIndex:indexPath.row];
            selectedRow=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
        }
        else if (self.index==8)
        {
            [SingletonClass shareSingleton].smoking=[smokingArr objectAtIndex:indexPath.row];
            selectedRow=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
        }
        else if (self.index==9)
        {
            [SingletonClass shareSingleton].dirinking=[drinkingArr objectAtIndex:indexPath.row];
            selectedRow=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
        }
        else if (self.index==10)
        {
            [SingletonClass shareSingleton].education=[educationArr objectAtIndex:indexPath.row];
            selectedRow=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
        }
    }
}

#pragma mark-cancelButton

-(void)cancelButtonAction:(id)sender{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"AboutMe" object:nil userInfo:nil];
    [self.navigationController popViewControllerAnimated:YES];
    // [[[[[UIApplication sharedApplication] keyWindow] subviews] lastObject] removeFromSuperview];
    
}
-(void)saveButtonAction:(id)sender{
    
    if (self.index==3) {
//        NSString * urlStr=[NSString stringWithFormat:@"http://taka.dating/relationship-update/mobile/%@/%@",[SingletonClass shareSingleton].userID,selectedRow];
//        [NSThread detachNewThreadSelector:@selector(callServiceToUpdate:) toTarget:self withObject:urlStr];
        NSString * bodyStr=[NSString stringWithFormat:@"userId=%@&relationship=%@",[SingletonClass shareSingleton].userID,selectedRow];
        
        NSString * postUrl=@"http://23.238.24.26/mobi/relationship-update";
        [self performSelector:@selector(callServiceToUpdate: body:) withObject:postUrl withObject:bodyStr];
    }
    else if (self.index==4)
    {
        /*NSString * urlStr=[NSString stringWithFormat:@"http://taka.dating/sexuality-update/mobile/%@/%@",[SingletonClass shareSingleton].userID,selectedRow];
        [NSThread detachNewThreadSelector:@selector(callServiceToUpdate:) toTarget:self withObject:urlStr];*/
        
        NSString * bodyStr=[NSString stringWithFormat:@"userId=%@&sexuality=%@",[SingletonClass shareSingleton].userID,selectedRow];
        
        NSString * postUrl=@"http://23.238.24.26/mobi/sexuality-update";
        [self performSelector:@selector(callServiceToUpdate: body:) withObject:postUrl withObject:bodyStr];
    }
    else if (self.index==6)
    {
        /*NSString * urlStr=[NSString stringWithFormat:@"http://taka.dating/living-update/mobile/%@/%@",[SingletonClass shareSingleton].userID,selectedRow];
        [NSThread detachNewThreadSelector:@selector(callServiceToUpdate:) toTarget:self withObject:urlStr];*/
        NSString * bodyStr=[NSString stringWithFormat:@"userId=%@&living=%@",[SingletonClass shareSingleton].userID,selectedRow];
        
        NSString * postUrl=@"http://23.238.24.26/mobi/living-update";
        [self performSelector:@selector(callServiceToUpdate: body:) withObject:postUrl withObject:bodyStr];
    }
    else if (self.index==7)
    {
       /* NSString * urlStr=[NSString stringWithFormat:@"http://taka.dating/children-update/mobile/%@/%@",[SingletonClass shareSingleton].userID,selectedRow];
        [NSThread detachNewThreadSelector:@selector(callServiceToUpdate:) toTarget:self withObject:urlStr];*/
        
        NSString * bodyStr=[NSString stringWithFormat:@"userId=%@&children=%@",[SingletonClass shareSingleton].userID,selectedRow];
        
        NSString * postUrl=@"http://23.238.24.26/mobi/children-update";
        [self performSelector:@selector(callServiceToUpdate: body:) withObject:postUrl withObject:bodyStr];
    }
    else if (self.index==8)
    {
       /* NSString * urlStr=[NSString stringWithFormat:@"http://taka.dating/smoking-update/mobile/%@/%@",[SingletonClass shareSingleton].userID,selectedRow];
        [NSThread detachNewThreadSelector:@selector(callServiceToUpdate:) toTarget:self withObject:urlStr];*/
        
        NSString * bodyStr=[NSString stringWithFormat:@"userId=%@&smoking=%@",[SingletonClass shareSingleton].userID,selectedRow];
        
        NSString * postUrl=@"http://23.238.24.26/mobi/smoking-update";
        [self performSelector:@selector(callServiceToUpdate: body:) withObject:postUrl withObject:bodyStr];
    }
    else if (self.index==9)
    {
       /* NSString * urlStr=[NSString stringWithFormat:@"http://taka.dating/drinking-update/mobile/%@/%@",[SingletonClass shareSingleton].userID,selectedRow];
        [NSThread detachNewThreadSelector:@selector(callServiceToUpdate:) toTarget:self withObject:urlStr];*/
        NSString * bodyStr=[NSString stringWithFormat:@"userId=%@&drinking=%@",[SingletonClass shareSingleton].userID,selectedRow];
        
        NSString * postUrl=@"http://23.238.24.26/mobi/drinking-update";
        [self performSelector:@selector(callServiceToUpdate: body:) withObject:postUrl withObject:bodyStr];
    }
    else if (self.index==10)
    {
       /* NSString * urlStr=[NSString stringWithFormat:@"http://taka.dating/education-update/mobile/%@/%@",[SingletonClass shareSingleton].userID,selectedRow];
        [NSThread detachNewThreadSelector:@selector(callServiceToUpdate:) toTarget:self withObject:urlStr];*/
        
        
        NSString * bodyStr=[NSString stringWithFormat:@"userId=%@&education=%@",[SingletonClass shareSingleton].userID,selectedRow];
        
        NSString * postUrl=@"http://23.238.24.26/mobi/education-update";
        [self performSelector:@selector(callServiceToUpdate: body:) withObject:postUrl withObject:bodyStr];
    }

}


-(void)callServiceToUpdate:(NSString *)urlStr body:(NSString*)msgBody{
    NSError * error=nil;
    NSURLResponse * urlResponse=nil;
   /* urlStr=[urlStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url=[NSURL URLWithString:urlStr];*/
    
    NSURL * url=[NSURL URLWithString:urlStr];
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[msgBody dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    
    if (data==nil) {
        NSLog(@"no data avilable");
        return;
    }
    id parse=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if ([[parse objectForKey:@"code"]isEqualToNumber:[NSNumber numberWithInt:200]]) {
        NSLog(@" Successfull");
    }
    else{
        NSLog(@"Unsuccessfull");
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
