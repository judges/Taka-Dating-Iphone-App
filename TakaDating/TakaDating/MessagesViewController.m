//
//  MessagesViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 30/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "MessagesViewController.h"
#import  "MessageDetailViewController.h"


@interface MessagesViewController ()
@property(nonatomic,strong)MessageDetailViewController * mdVC;

@end

@implementation MessagesViewController

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
    nameArr=[[NSMutableArray alloc]initWithObjects:@"One",@"Two",@"Three",@"Four",@"Five", nil];
    
    windowSize =[UIScreen mainScreen].bounds.size;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(editButtonAction) name:@"editButtonAction" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cancelButtonAction) name:@"cancelButtonAction" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectButtonAction) name:@"selectButtonAction" object:nil];
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deselectButtonAction) name:@"deselectButtonAction" object:nil];
   
    [self createUI];
    
    // Do any additional setup after loading the view from its nib.
}

#pragma mark-editbutton action

-(void)editButtonAction{
    editbuttonSelect =YES;
    [self.messageTable reloadData];
}
-(void)cancelButtonAction{
    editbuttonSelect=NO;
    selectAll=NO;
    [self.messageTable reloadData];
}

-(void)selectButtonAction{
    NSLog(@"Select Button clicked");
    selectAll=YES;
    [self.messageTable reloadData];
   
}

-(void)deselectButtonAction{
    NSLog(@"Select Button clicked");
    selectAll=NO;
    [self.messageTable reloadData];
    
}


-(void)createUI{
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    
    UIView * sectionView=[[UIView alloc]init];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        sectionView.frame=CGRectMake(0, 0, windowSize.width, 150);
    }
    else{
            sectionView.frame=CGRectMake(0, 0, windowSize.width, 60);
    }
    
    sectionView.backgroundColor=[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    CGRect   frame,srchFrame;
    if (!self.messageTable) {
        self.messageTable=[[UITableView alloc]init];
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
           
                self.messageTable.frame=CGRectMake(0, 10, windowSize.width, windowSize.height-50);
            frame=CGRectMake(10, 70, windowSize.width-20, 50);
            srchFrame=CGRectMake(10, 10, windowSize.width-20, 50);
            row_hh=80;
        }
        else{
        //if ([UIScreen mainScreen].bounds.size.height>500) {
            self.messageTable.frame=CGRectMake(0, 10, windowSize.width, windowSize.height-50);
            frame=CGRectMake(10, 35, windowSize.width-20, 20);
            srchFrame=CGRectMake(10, 10, windowSize.width-20, 20);
            row_hh=40;
      //  }
        }
//        else{
//             self.messageTable.frame=CGRectMake(0, 0, 320, self.view.frame.size.height-50);
//        }
        self.messageTable.delegate=self;;
        self.messageTable.dataSource=self;
            self.messageTable.backgroundColor=[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
        self.messageTable.separatorColor=[UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)165/255 blue:(CGFloat)165/255 alpha:1.0];
        
        [self.view addSubview:self.messageTable];
        
        self.searchbar =[[UISearchBar alloc]init];
        self.searchbar.frame=srchFrame;
        self.searchbar.layer.cornerRadius=7;
        self.searchbar.placeholder=@"Search";
        self.searchbar.clipsToBounds=YES;
        self.searchbar.delegate=self;
        
        self.searchbar.backgroundColor=[UIColor whiteColor];
        self.searchbar.searchBarStyle=UISearchBarStyleProminent;
        [sectionView addSubview:self.searchbar];
        
        
         NSArray *arry=[NSArray arrayWithObjects:@"All",@"Unread",@"Online", nil];
        
        self.segment=[[UISegmentedControl alloc]initWithItems:arry];
        
        self.segment.frame=frame;
        [self.segment addTarget:self action:@selector(MySegmentControlAction:) forControlEvents: UIControlEventValueChanged];
        self.segment.selectedSegmentIndex = 0;
        //[self.segment setTintColor:[UIColor colorWithRed:50.0/255.0 green:49.0/255.0 blue:49.0/255.0 alpha:1.0]];
       

        [sectionView addSubview:self.segment];
       for (UIControl *subview in self.segment.subviews) {
            subview.tintColor = [subview isSelected] ? [UIColor colorWithRed:135.0/255.0 green:10.0/255.0 blue:2.0/255.0 alpha:1.0] : [UIColor blackColor];
       }
        self.messageTable.tableHeaderView=sectionView ;
    }
}


#pragma mark-Segment method

-(void)MySegmentControlAction:(UISegmentedControl *)sender{
        for (UIControl *subview in sender.subviews) {
            subview.tintColor = [subview isSelected] ? [UIColor colorWithRed:135.0/255.0 green:10.0/255.0 blue:2.0/255.0 alpha:1.0] : [UIColor blackColor];
        }
    
 
    
    if (sender.selectedSegmentIndex==0) {
        NSLog(@"index one selected");
    }
    else if (sender.selectedSegmentIndex==1)
    {
        NSLog(@"index Two selected");
    }
    else{
        NSLog(@"index three selected");
    }
}

#pragma mark- table delegate methods
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return row_hh;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return nameArr.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageTableViewCell * cell=(MessageTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    if (cell==nil) {
        cell=[[MessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        [cell.deleteButton addTarget:self action:@selector(deleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (editbuttonSelect==YES) {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            cell.imgView.frame=CGRectMake(35, 10, 50, 50);
            cell.deleteButton.frame=CGRectMake(15, 10, 25, 25);
            cell.cellLabel.frame=CGRectMake(100, 15, 200, 30);
            cell.deleteButton.tag=indexPath.row;
        }
        else{
        cell.imgView.frame=CGRectMake(25, 5, 30, 30);
        cell.deleteButton.frame=CGRectMake(5, 10, 15, 15);
        cell.cellLabel.frame=CGRectMake(70, 10, 150, 30);
        cell.deleteButton.tag=indexPath.row;
        }
        if (selectAll==YES) {
            [cell.deleteButton setSelected:YES];
            [cell.deleteButton setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
        }
        else{
            [cell.deleteButton setSelected:NO];
            [cell.deleteButton setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateSelected];
        }
        
    }
    else
    {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            cell.cellLabel.frame=CGRectMake(70, 15, 200, 30);
            cell.imgView.frame=CGRectMake(10, 10, 50, 50);
        }
        else{
                cell.cellLabel.frame=CGRectMake(50, 10, 150, 30);
                cell.imgView.frame=CGRectMake(5, 5, 30, 30);
        }
    }
    
    cell.imgView.image=[UIImage imageNamed:@"imag1.jpg"];
    cell.cellLabel.text=[nameArr objectAtIndex:indexPath.row];
    cell.imgView.tag=indexPath.row;
    
    return  cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editbuttonSelect==NO) {
        
    
      if(self.mdVC)
      {
          self.mdVC=nil;
      }
          self.mdVC=[[MessageDetailViewController alloc]initWithNibName:@"MessageDetailViewController" bundle:nil];
    self.mdVC.titleStr=[nameArr objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:self.mdVC animated:YES];
    }

    else{
        NSLog(@"Delete is selected");
    }
}



-(void)deleteButtonAction:(id)sender{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    
    // Dispose of any resources that can be recreated.
}

@end
