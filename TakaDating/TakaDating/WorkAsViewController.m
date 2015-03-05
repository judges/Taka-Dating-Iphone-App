//
//  WorkAsViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 03/12/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "WorkAsViewController.h"
#import "SingletonClass.h"

@interface WorkAsViewController ()

@end

@implementation WorkAsViewController

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
    
    WindowSize=[UIScreen mainScreen].bounds.size;
    
    incomeArr=[NSArray arrayWithObjects:@"Unfilled yet",@"Low",@"Average",@"High", nil];
    
    self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, self.view.frame.size.width, 55);
    UIColor *firstColor = [UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
    UIColor *secColor = [UIColor colorWithRed:(CGFloat)121/255 green:(CGFloat)2/255 blue:(CGFloat)0/255 alpha:1.0];
    layer.colors = [NSArray arrayWithObjects:(id)[firstColor CGColor],(id)[secColor CGColor], nil];
    [self.view.layer insertSublayer:layer atIndex:0];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.frame=CGRectMake(WindowSize.width/2-60, 20, WindowSize.width-200, 35);
    //self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.text = @"I Work as";
    [self.view addSubview:self.titleLabel];
    //Add Cancel BUTTON
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.frame = CGRectMake(WindowSize.width/2-145, 25, 60, 25);
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
    self.saveButton.frame = CGRectMake(WindowSize.width-70, 25, 60, 25);
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
        layer.frame = CGRectMake(0, 0, WindowSize.width, 75);
        self.titleLabel.frame=CGRectMake(WindowSize.width/2-50, 25, WindowSize.width-200, 40);
        self.cancelButton.frame = CGRectMake(WindowSize.width/2-350, 25, 120, 40);
        self.saveButton.frame = CGRectMake(WindowSize.width-150, 25, 120, 40);
        
        self.titleLabel.font = [UIFont boldSystemFontOfSize:30];
        self.cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.saveButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        height=75;
        cell_font=25;
        row_hh=80;
        }
    else{
        height=55;
        cell_font=12;
        row_hh=40;
    }
    
    
    [self createUI];

    
    // Do any additional setup after loading the view from its nib.
}

#pragma mark-CreateUI

-(void)createUI{
    if (!self.workTable) {
        self.workTable=[[UITableView alloc]init];
       // if ([UIScreen mainScreen].bounds.size.height>500) {
            self.workTable.frame=CGRectMake(0, height, WindowSize.width, WindowSize.height-50);
//        }
//        else{
//            self.workTable.frame=CGRectMake(0,height, WindowSize.width, WindowSize.height-50);
//        }

    }
    self.workTable.delegate=self;
    self.workTable.dataSource=self;
    self.workTable.scrollEnabled=NO;
    self.workTable.separatorColor=[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    self.workTable.backgroundColor=[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    [self.view addSubview:self.workTable];
}

#pragma mark textfield

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField!=nil) {
        [SingletonClass shareSingleton].profession=textField.text;
    }
    [textField resignFirstResponder];
    return  YES;
}

#pragma mark-TableDeleagte methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  row_hh;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    else if(section==1){
        return 4;
    }
    return 0;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section==0)
    {
        return @"Job";
    }
    else if(section==1)
    {
        return @"Income";
    }
    else{
        return @"";
    }
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell=[tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.section==0) {
        UITextField * jobText=[[UITextField alloc]init];
        jobText.frame=CGRectMake(10, 0, WindowSize.width, row_hh);
        jobText.font=[UIFont systemFontOfSize:cell_font];
        jobText.delegate=self;
        if ([SingletonClass shareSingleton].profession!=NULL) {
             jobText.text=[SingletonClass shareSingleton].profession;
        }
       
        [cell.contentView addSubview:jobText];
    }
    
    if (indexPath.section==1) {
        NSLog(@"%@",[SingletonClass shareSingleton].income);
        NSString * value=[NSString stringWithString:[SingletonClass shareSingleton].income];
        value=[value stringByReplacingOccurrencesOfString:@"Income:" withString:@""];
        cell.textLabel.text=[incomeArr objectAtIndex:indexPath.row];
         cell.textLabel.font=[UIFont boldSystemFontOfSize:cell_font];
        if ([value isEqualToString:cell.textLabel.text]) {
            if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
                access_image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"checkmark_ipad.png"]];
                    cell.accessoryView=access_image;
            }
            else{
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
           
            selectedIndex=indexPath;
            selectedRow=[NSString stringWithFormat:@"%d",indexPath.row];
        }
        
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        
        if (selectedIndex==indexPath)
        {
            return;
        }
        
        
        
        UITableViewCell *old = [tableView cellForRowAtIndexPath:selectedIndex];
//        old.accessoryType = UITableViewCellAccessoryNone;
//        [old setSelected:FALSE animated:TRUE];
        
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            old.accessoryView=nil;
        }
        else{
            old.accessoryType = UITableViewCellAccessoryNone;
        }
        [old setSelected:FALSE animated:TRUE];
        
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
             access_image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"checkmark_ipad"]];;
            cell.accessoryView=access_image;
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        [cell setSelected:TRUE animated:TRUE];
        

        
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//        [cell setSelected:TRUE animated:TRUE];
        
        
        selectedIndex = indexPath;
        [SingletonClass shareSingleton].income=[incomeArr objectAtIndex:selectedIndex.row];
        selectedRow=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    }
   

    
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if (section==2) {
//        return  150.0;
//    }
//    return 0.0;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==2) {
        return  row_hh+350;
    }
    return row_hh-10;
}

#pragma mark- Cancel button

-(void)cancelButtonAction:(id)sender{
    
     [[NSNotificationCenter defaultCenter]postNotificationName:@"AboutMe" object:nil userInfo:nil];
    //[[[[[UIApplication sharedApplication]keyWindow]subviews]lastObject]removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
   
}

-(void)saveButtonAction:(id)sender{

    NSError * error=nil;
    NSURLResponse * urlResponse=nil;
    
    NSString * value=[NSString stringWithString:[SingletonClass shareSingleton].profession];
    value=[value stringByReplacingOccurrencesOfString:@"Profession:" withString:@""];
    
   /* NSString * urlStr=[NSString stringWithFormat:@"http://taka.dating/work-update/mobile/%@/%@/%@",[SingletonClass shareSingleton].userID,value,selectedRow];
    
    urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];*/
    NSString * urlStr=@"http://23.238.24.26/mobi/work-update";
    NSURL * url=[NSURL URLWithString:urlStr];
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSString * body=[NSString stringWithFormat:@"userId=%@&job=%@&income=%@",[SingletonClass shareSingleton].userID,value,selectedRow];
    [request setHTTPBody:[body dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (data==nil) {
        NSLog(@"No data available");
        return;
    }
    
    id parse=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if ([[parse objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
        NSLog(@"Successfull");
    }
    else{
        NSLog(@"Unuccessfull");
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
