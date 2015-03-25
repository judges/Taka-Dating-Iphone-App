//
//  AddInterestViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 26/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "AddInterestViewController.h"
#import "SingletonClass.h"

@interface AddInterestViewController ()

@end

@implementation AddInterestViewController

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
    [SingletonClass shareSingleton].selectedInterests=[NSMutableArray array];
    [self subCatData];
    NSLog(@"data of this class %@",self.subArray);
    self.selectedArray = [[NSMutableArray alloc] init];
    //self.subArray=[[NSMutableArray alloc]init];
       windowSize=[UIScreen mainScreen].bounds.size;
    
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, windowSize.width, 55);
    UIColor *firstColor = [UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
    UIColor *secColor = [UIColor colorWithRed:(CGFloat)121/255 green:(CGFloat)2/255 blue:(CGFloat)0/255 alpha:1.0];
    layer.colors = [NSArray arrayWithObjects:(id)[firstColor CGColor],(id)[secColor CGColor], nil];
    [self.view.layer insertSublayer:layer atIndex:0];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.frame= CGRectMake(windowSize.width/2-60, 20, windowSize.width-200, 35);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.text = @"Add interests";
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
    
    UIButton * saveButton=[UIButton  buttonWithType:UIButtonTypeCustom];
    saveButton.frame=CGRectMake(windowSize.width-70, 25, 60, 25);
    [saveButton setTitle:@"Save" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveButton.layer.borderColor = [UIColor redColor].CGColor;
    saveButton.titleLabel.font = [UIFont systemFontOfSize:15];
    saveButton.layer.borderWidth = 0.7;
    saveButton.layer.cornerRadius = 4;
    saveButton.clipsToBounds = YES;
    [saveButton addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
   // [self.view addSubview:saveButton];

    if (UIUserInterfaceIdiomPad==UI_USER_INTERFACE_IDIOM()) {
        
        layer.frame = CGRectMake(0, 0, windowSize.width, 75);
        self.titleLabel.frame= CGRectMake(windowSize.width/2-270, 20, windowSize.width-200, 35);
        
        self.cancelButton.frame = CGRectMake(windowSize.width/2-350, 25, 120, 40);
        self.cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        
        self.titleLabel.font = [UIFont boldSystemFontOfSize:30];
        
      saveButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
      saveButton.frame=CGRectMake(windowSize.width-70, 25, 120, 40);
        row_hh=85;
        height=75;
    }
    else
    {
        height=55;
        row_hh=40;
    }
    
    [self createUI] ;
    
}

-(void)saveButtonAction:(id)sender{
    for (int i=0; i<self.selectedArray.count; i++) {
        NSIndexPath * indexPath=[self.selectedArray objectAtIndex:i];
        
    }
}

-(void)subCatData{
    subData=[[NSMutableArray alloc]init];
    
    NSMutableDictionary * dict;
    NSString * intr_id;
    for (int i=0;i<self.subArray.count; i++) {
       
        dict =[self.subArray objectAtIndex:i];
        int k=[[self.intr_id_arr objectAtIndex:i]intValue];
        intr_id =[NSString stringWithFormat:@"%d",k];
        [subData addObject:[dict objectForKey:intr_id]];
    }
   
}

-(void)createUI{
    self.addInterestTable=[[UITableView alloc]init];
   self.addInterestTable.frame= CGRectMake(0, height, windowSize.width, windowSize.height-50);
    self.addInterestTable.delegate=self;
    self.addInterestTable.dataSource=self;
    self.addInterestTable.separatorColor=[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    [self.view addSubview:self.addInterestTable];
    
    UIView * sectionView=[[UIView alloc]init];
    sectionView.frame=CGRectMake(0, 0, windowSize.width, 60);
    sectionView.backgroundColor=[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        self.addInterestTable.frame= CGRectMake(0, height, windowSize.width, windowSize.height-80);
        sectionView.frame=CGRectMake(0, 0, windowSize.width, 120);
    }
    
    
    self.searchbar =[[UISearchBar alloc]initWithFrame:CGRectMake(10, 30, 300, 20)];
    self.searchbar.layer.cornerRadius=7;
    self.searchbar.placeholder=@"Search";
    self.searchbar.clipsToBounds=YES;
    self.searchbar.delegate=self;
    
    self.searchbar.backgroundColor=[UIColor whiteColor];
    self.searchbar.searchBarStyle=UISearchBarStyleProminent;
    //[sectionView addSubview:self.searchbar];
    self.addInterestTable.tableHeaderView=sectionView ;
    
}
#pragma mark-table delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return subData.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return row_hh;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddInterestTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell==nil)
    {
        cell=[[AddInterestTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
                [cell.cellButton addTarget:self action:@selector(cellButtonAction:) forControlEvents:UIControlEventTouchDragInside];
    }
   // NSLog(@"number of interersts %d",[SingletonClass shareSingleton].selectedIntName.count);
    NSString * normal,* select;
    cell.cellLabel.text=[subData objectAtIndex:indexPath.row];
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad){
        cell.containerView.frame=CGRectMake(0, 0, windowSize.width, row_hh);
        cell.cellLabel.textColor=[UIColor blackColor];
        cell.cellLabel.frame=CGRectMake(80, 20, windowSize.width/2, 30);
        cell.cellButton.frame=CGRectMake(20, 10, 25, 25);
        normal=@"select_normal_ipad.png";
        select=@"select_ipad.png";
       

    }
    else{
    cell.containerView.frame=CGRectMake(0, 0, windowSize.width, row_hh);
    cell.cellLabel.textColor=[UIColor blackColor];
    cell.cellLabel.frame=CGRectMake(60, 10, 200, 30);
    cell.cellButton.frame=CGRectMake(20, 10, 15, 15);
        normal=@"select_normal.png";
        select=@"select.png";
        
    }
    [cell.cellButton setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [cell.cellButton setImage:[UIImage imageNamed:select] forState:UIControlStateSelected];
    cell.cellButton.tag=indexPath.row;

    
    
    
    for (int i=0; i<[SingletonClass  shareSingleton].selectedIntName.count; i++) {
        if ([[[SingletonClass  shareSingleton].selectedIntName objectAtIndex:i]isEqualToString:cell.cellLabel.text]) {
            
            [self.selectedArray addObject:indexPath];
            
        }
    }
    
    
    @try {
        if ([self.selectedArray containsObject:indexPath]) {
            [cell.cellButton setImage:[UIImage imageNamed:select]forState:UIControlStateSelected];
            [cell.cellButton setSelected:YES];
           
        }
        else
        {
            
            [cell.cellButton setImage:[UIImage imageNamed:normal]forState:UIControlStateNormal];
            [cell.cellButton setSelected:NO];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Exception %@",[exception name]);
    }

   
    
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AddInterestTableViewCell * cell=(AddInterestTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];

      NSString * normal,* select;
    if (UIUserInterfaceIdiomPad==UI_USER_INTERFACE_IDIOM()) {
        normal=@"select_normal_ipad.png";
        select=@"select_ipad.png";

    }
    else{
        normal=@"select_normal.png";
        select=@"select.png";

    }
    
    if ([cell.cellButton isSelected]==YES) {
        [cell.cellButton setImage:[UIImage imageNamed:normal]forState:UIControlStateNormal];
        [cell.cellButton setSelected:NO];
        [self.selectedArray removeObject:indexPath];
   
            for (int j=0; j<[SingletonClass shareSingleton].selectedIntName.count; j++) {
                if ([[[SingletonClass shareSingleton].selectedIntName objectAtIndex:j]isEqualToString:[subData objectAtIndex:indexPath.row]]) {
                    [[SingletonClass shareSingleton].selectedIntName removeObjectAtIndex:indexPath.row];
                    [[SingletonClass shareSingleton].selectedIntId removeObjectAtIndex:indexPath.row];
                    [self.addInterestTable reloadData];
                }
            }
       
        NSLog(@" %@",[subData objectAtIndex:indexPath.row]);
    }
    else{
        [cell.cellButton setImage:[UIImage imageNamed:select]forState:UIControlStateSelected];
        [cell.cellButton setSelected:YES];
        [self.selectedArray addObject:indexPath];
        [[SingletonClass shareSingleton].selectedIntName addObject:[subData objectAtIndex:indexPath.row]];
        [[SingletonClass shareSingleton].selectedIntId addObject:[self.intr_id_arr objectAtIndex:indexPath.row]];
        NSLog(@" %@",[subData objectAtIndex:indexPath.row]);
      
        
    }
    NSLog(@" ids  %@",[SingletonClass shareSingleton].selectedIntId );
    NSLog(@" names %@",[SingletonClass shareSingleton].selectedIntName);
}


-(void)cancelButtonAction:(id)sender{
//    [[[[[UIApplication sharedApplication]keyWindow]subviews]lastObject]removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)cellButtonAction:(id)sender{
  
    NSLog(@"cell Button action");
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
