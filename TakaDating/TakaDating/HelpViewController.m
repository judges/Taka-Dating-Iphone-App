//
//  HelpViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 20/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "HelpViewController.h"
#import "QuestionsViewController.h"

@interface HelpViewController ()
@property(nonatomic,strong)QuestionsViewController *  questionVC;
@end

@implementation HelpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.title=@"Help";
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 1);
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:                                                                [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,                                                                                                         shadow, NSShadowAttributeName,                                                                                                         [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil]];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem * barButton=[[UIBarButtonItem alloc]initWithCustomView:self.cancelButton];
    self.navigationItem.leftBarButtonItem=barButton;
    
    i=0;
    currentSelection=-1;
    self.tableData=[NSArray arrayWithObjects:@"Popular Questions",@"About Taka",@"Profile",@"Photos and Videos",@"People Nearby and Search",@"Encounters",@"Credist",@"Super Powers",@"Settings",@"Privacy",@"Awards",@"Reporting Optins", nil];
    self.secTblData=[NSArray arrayWithObjects:@"One",@"Two",@"Three",@"Four",@"Five", nil];
   
    
    self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    
    layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, self.view.frame.size.width, 55);
    UIColor *firstColor = [UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
    UIColor *secColor = [UIColor colorWithRed:(CGFloat)121/255 green:(CGFloat)2/255 blue:(CGFloat)0/255 alpha:1.0];
    layer.colors = [NSArray arrayWithObjects:(id)[firstColor CGColor],(id)[secColor CGColor], nil];
    [self.view.layer insertSublayer:layer atIndex:0];
    
    //Adding title Label
    self.titleLabel=[[UILabel alloc]init];
    self.titleLabel.frame=CGRectMake(120, 25, 100, 25);
    self.titleLabel.text=@"Help";
    self.titleLabel.textColor=[UIColor whiteColor];
    self.titleLabel.font=[UIFont boldSystemFontOfSize:20];
    [self.view addSubview:self.titleLabel];
    
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
    [self.view addSubview:self.cancelButton];
    
    [self createUI];

    // Do any additional setup after loading the view from its nib.
}

#pragma mark- CreatUI

-(void)createUI{
    if(!self.helpTableView)
    {
        self.helpTableView=[[UITableView alloc]init];
        if ([UIScreen mainScreen].bounds.size.height>500) {
            self.helpTableView.frame=CGRectMake(0, 55, self.view.frame.size.width, self.view.frame.size.height-55);
        }
        else{
            self.helpTableView.frame=CGRectMake(0, 55, self.view.frame.size.width, 435);
        }
        self.helpTableView.delegate=self;
        self.helpTableView.dataSource=self;
        self.helpTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        self.helpTableView.backgroundColor=[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
        self.helpTableView.separatorColor=[UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)165/255 blue:(CGFloat)165/255 alpha:1.0];
        
        [self.view addSubview:self.helpTableView];
        //-------
        UIView * sectionView=[[UIView alloc]init];
        sectionView.frame=CGRectMake(0, 0, 320, 60);
        sectionView.backgroundColor=[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
        
        UILabel * sectionLabel=[[UILabel alloc]init];
        sectionLabel.frame=CGRectMake(10, 5, 300, 30);
        sectionLabel.text=@"What can we help you with?";
        sectionLabel.textColor=[UIColor blackColor];
        sectionLabel.textAlignment=NSTextAlignmentCenter;
        sectionLabel.font=[UIFont boldSystemFontOfSize:13];
        [sectionView addSubview: sectionLabel];
        
        self.searchbar =[[UISearchBar alloc]initWithFrame:CGRectMake(10, 30, 300, 20)];
        self.searchbar.layer.cornerRadius=7;
        self.searchbar.placeholder=@"Search";
        self.searchbar.clipsToBounds=YES;
        self.searchbar.delegate=self;
        
        self.searchbar.backgroundColor=[UIColor whiteColor];
        self.searchbar.searchBarStyle=UISearchBarStyleProminent;
        [sectionView addSubview:self.searchbar];
        self.helpTableView.tableHeaderView=sectionView ;
        //---------
    }
}

#pragma mark- TableView Deleagte methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==currentSelection)
    {
        return self.secTblData.count;
    }
    else
    {
    return 1;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
        return self.tableData.count;
    
    //return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HelpCustomTableViewCell * cell=(HelpCustomTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(cell==nil)
    {
        cell=[[HelpCustomTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
        cell.containerView.frame=CGRectMake(0, 0, self.view.frame.size.width, 50);
        cell.cellLabel.font=[UIFont systemFontOfSize:15];
        cell.cellLabel.textColor=[UIColor blackColor];
        cell.cellLabel.frame=CGRectMake(15, 0, 200, cell.frame.size.height);
    
   

    if(indexPath.row==0){
        
            cell.containerView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Cellheader.png"]];
                   cell.cellLabel.text=[self.tableData objectAtIndex:indexPath.section];

     
}
    else
    {
        if (currentSelection==indexPath.section) {
            cell.cellLabel.text=[self.secTblData objectAtIndex:indexPath.row-1];
             cell.containerView.backgroundColor=[UIColor whiteColor];
        }
        else{
      cell.cellLabel.text=[self.tableData objectAtIndex:indexPath.row];
        }
    }
    
    
    
  
   // cell.cellLabel.text=[self.tableData objectAtIndex:indexPath.row];
    
    NSLog(@"text %@",cell.cellLabel.text);
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = [[self.tableData objectAtIndex:indexPath.row] sizeWithAttributes:
                   @{NSFontAttributeName:
                         [UIFont systemFontOfSize:17.0f]}];
    
    // Values are fractional -- you should take the ceilf to get equivalent values
    size.height = ceilf(size.height);
    size.width = ceilf(size.width);
    return 48.5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
        return 0.0;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
   }
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (currentSelection == indexPath.section) {
        if (indexPath.row) {
            NSLog(@"index path selected %ld",(long)indexPath.row);
            if (self.questionVC) {
                self.questionVC=nil;
            }
            self.questionVC=[[QuestionsViewController alloc]initWithNibName:@"QuestionsViewController" bundle:nil];
            self.questionVC.titleStr=[self.secTblData objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:self.questionVC animated:YES];
        }
        else{
        currentSelection = -1;
        [tableView reloadData];
        }
        return;
    }
    NSInteger section = [indexPath section];
    currentSelection = section;
    
    [UIView animateWithDuration:1 animations:^{
        [tableView reloadData];
    }];
}
#pragma mark-searchBar Delegate methods


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cancelButtonAction:(id)sender
{
    [self.helpTableView reloadData];
    [self.searchbar resignFirstResponder];
    [[[[[UIApplication sharedApplication]keyWindow]subviews]lastObject]removeFromSuperview];
    //[self.navigationController popViewControllerAnimated:YES];
}
@end
