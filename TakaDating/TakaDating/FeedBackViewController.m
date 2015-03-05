//
//  FeedBackViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 18/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "FeedBackViewController.h"
#import "AppDelegate.h"

@interface FeedBackViewController ()
{
    AppDelegate * appdelegate;
}
@property(nonatomic,strong)CellSelectionViewController * cellSelectionVC;

@end

@implementation FeedBackViewController

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
        
        self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
        
        CAGradientLayer *layer = [CAGradientLayer layer];
        
        UIColor *firstColor = [UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
        UIColor *secColor = [UIColor colorWithRed:(CGFloat)121/255 green:(CGFloat)2/255 blue:(CGFloat)0/255 alpha:1.0];
        layer.colors = [NSArray arrayWithObjects:(id)[firstColor CGColor],(id)[secColor CGColor], nil];
        [self.view.layer insertSublayer:layer atIndex:0];
        
        //Adding title Label
        self.titleLabel=[[UILabel alloc]init];
        
        self.titleLabel.text=@"Feedback";
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
        
        
    
        
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            layer.frame = CGRectMake(0, 0, windowSize.width, 75);
            self.titleLabel.frame=CGRectMake(windowSize.width/2-40, 25, 150, 40);
            self.cancelButton.frame=CGRectMake(windowSize.width/2-365, 25, 110, 40);
           
            
            self.titleLabel.font=[UIFont boldSystemFontOfSize:25];
            self.cancelButton.titleLabel.font=[UIFont boldSystemFontOfSize:20];
                        
        }
        else{
          
            layer.frame = CGRectMake(0, 0, windowSize.width, 55);
            self.titleLabel.frame=CGRectMake(windowSize.width/2-40, 25, 100, 25);
            self.cancelButton.frame=CGRectMake(windowSize.width-305, 25, 60, 25);
            
            
            self.titleLabel.font=[UIFont boldSystemFontOfSize:20];
            self.cancelButton.titleLabel.font=[UIFont systemFontOfSize:15];
            
        }
        
        
        [self createUI];
        // Do any additional setup after loading the view from its nib.
    }
   


#pragma  mark- tableView UI

-(void)createUI{
    if(!self.feedbackTable)
    {
        self.feedbackTable=[[UITableView alloc]init];
        
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            self.feedbackTable.frame=CGRectMake(0, 75, windowSize.width, windowSize.height) ;
            cell_hh=85.0;
            cell_font=25;
        }
        else{
            cell_hh=50.0;
            cell_font=40.0;
        self.feedbackTable.frame=CGRectMake(0, 55, windowSize.width, windowSize.height) ;
        }
        self.feedbackTable.delegate=self;
        self.feedbackTable.dataSource=self;
        self.feedbackTable.backgroundColor=[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)176/255 blue:(CGFloat)176/255 alpha:1.0];
        
        self.feedbackTable.separatorColor=[UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)165/255 blue:(CGFloat)165/255 alpha:1.0];
        [self.feedbackTable setShowsVerticalScrollIndicator:NO];
        [self.view addSubview:self.feedbackTable];
        
    }
    self.feedbackTable.hidden=NO;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 5;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0)
    {
        return cell_hh+30;
    }
    return 400;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
   
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.font=[UIFont systemFontOfSize:cell_font];
    
    if(indexPath.section==0)
    {
        if(indexPath.row==0)
        {
            cell.textLabel.text=@"Errors/Bugs";
        }
        else if (indexPath.row==1)
        {
            cell.textLabel.text=@"Ideas";
        }
        else if (indexPath.row==2)
        {
            cell.textLabel.text=@"Questions";
        }
        else if (indexPath.row==3)
        {
            cell.textLabel.text=@"Business mattres";
        }
        else if(indexPath.row==4)
        {
            cell.textLabel.text=@"Billing questions";
        }
        else{
            
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.cellSelectionVC)
    {
        self.cellSelectionVC=nil;
    }
    self.cellSelectionVC=[[CellSelectionViewController alloc]initWithNibName:@"CellSelectionViewController" bundle:nil];
     //self.cellSelectionVC.titleStr=nil;
    if(indexPath.row==0)
    {
       
      self.cellSelectionVC.titleStr=@"Error/Bugs";
        self.cellSelectionVC.indexRow=(int)indexPath.row;
        
       // [appdelegate.window addSubview:self.cellSelectionVC.view];
     
    }
    if(indexPath.row==1)
    {
        self.cellSelectionVC.titleStr=@"Ideas";
        self.cellSelectionVC.indexRow=(int)indexPath.row;
        
       // [appdelegate.window addSubview:self.cellSelectionVC.view];
        
    }
    if(indexPath.row==2)
    {
        self.cellSelectionVC.titleStr=@"Questions";
        self.cellSelectionVC.indexRow=(int)indexPath.row;
        
        //[appdelegate.window addSubview:self.cellSelectionVC.view];
    }
    if(indexPath.row==3)
    {
        self.cellSelectionVC.titleStr=@"Business matters";
        self.cellSelectionVC.indexRow=(int)indexPath.row;
       // [appdelegate.window addSubview:self.cellSelectionVC.view];
        
    }
    if(indexPath.row==4)
    {
        self.cellSelectionVC.titleStr=@"Billing questions";
        self.cellSelectionVC.indexRow=(int)indexPath.row;
        
        //[appdelegate.window addSubview:self.cellSelectionVC.view];
    }
       [self.navigationController pushViewController:self.cellSelectionVC animated:YES];
  
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cell_hh;
}


#pragma mark-
-(void)cancelButtonAction:(id)sender{
     // [[[[[UIApplication sharedApplication]keyWindow]subviews]lastObject]removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
