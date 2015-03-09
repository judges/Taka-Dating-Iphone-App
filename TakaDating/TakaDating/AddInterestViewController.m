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
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, windowSize.width-200, 35)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.text = @"Add interests";
    [self.view addSubview:self.titleLabel];
    //Add Cancel BUTTON
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.frame = CGRectMake(15, 25, 60, 25);
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
    saveButton.frame=CGRectMake(windowSize.width-80, 25, 60, 25);
    [saveButton setTitle:@"Save" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveButton.layer.borderColor = [UIColor redColor].CGColor;
    saveButton.titleLabel.font = [UIFont systemFontOfSize:15];
    saveButton.layer.borderWidth = 0.7;
    saveButton.layer.cornerRadius = 4;
    saveButton.clipsToBounds = YES;
    [saveButton addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];

    
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
    self.addInterestTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 55, windowSize.width, windowSize.height-50)];
    self.addInterestTable.delegate=self;
    self.addInterestTable.dataSource=self;
    self.addInterestTable.separatorColor=[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    [self.view addSubview:self.addInterestTable];
    
    UIView * sectionView=[[UIView alloc]init];
    sectionView.frame=CGRectMake(0, 0, 320, 60);
    sectionView.backgroundColor=[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    
    self.searchbar =[[UISearchBar alloc]initWithFrame:CGRectMake(10, 30, 300, 20)];
    self.searchbar.layer.cornerRadius=7;
    self.searchbar.placeholder=@"Search";
    self.searchbar.clipsToBounds=YES;
    self.searchbar.delegate=self;
    
    self.searchbar.backgroundColor=[UIColor whiteColor];
    self.searchbar.searchBarStyle=UISearchBarStyleProminent;
    [sectionView addSubview:self.searchbar];
    self.addInterestTable.tableHeaderView=sectionView ;
    
}
#pragma mark-table delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return subData.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddInterestTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell==nil)
    {
        cell=[[AddInterestTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
                [cell.cellButton addTarget:self action:@selector(cellButtonAction:) forControlEvents:UIControlEventTouchDragInside];
    }
    
    
    cell.cellLabel.text=[subData objectAtIndex:indexPath.row];
    
    cell.containerView.frame=CGRectMake(0, 0, self.view.frame.size.width, 50);
    cell.cellLabel.textColor=[UIColor blackColor];
    cell.cellLabel.frame=CGRectMake(60, 10, 200, 30);
    cell.cellButton.frame=CGRectMake(20, 10, 15, 15);
    [cell.cellButton setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
    [cell.cellButton setImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateSelected];
    cell.cellButton.tag=indexPath.row;
    if ([[[SingletonClass  shareSingleton].intr_name objectAtIndex:indexPath.row]isEqualToString:cell.cellLabel.text]) {
        
        [self.selectedArray addObject:indexPath];
        
    }
    
    @try {
        if ([self.selectedArray containsObject:indexPath]) {
            [cell.cellButton setImage:[UIImage imageNamed:@"select.png"]forState:UIControlStateSelected];
            [cell.cellButton setSelected:YES];
           
        }
        else
        {
            
            [cell.cellButton setImage:[UIImage imageNamed:@"select_normal.png"]forState:UIControlStateNormal];
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
    cell.containerView.frame=CGRectMake(0, 0, self.view.frame.size.width, 50);
    cell.cellLabel.textColor=[UIColor blackColor];
    cell.cellLabel.frame=CGRectMake(60, 10, 200, 30);
    cell.cellButton.frame=CGRectMake(20, 10, 15, 15);
    
    
    if ([cell.cellButton isSelected]==YES) {
        [cell.cellButton setImage:[UIImage imageNamed:@"select_normal.png"]forState:UIControlStateNormal];
        [cell.cellButton setSelected:NO];
        [self.selectedArray removeObject:indexPath];
      //  for (int i=0;subData.count; i++) {
            for (int j=0; j<[SingletonClass shareSingleton].intr_name.count; j++) {
                if ([[[SingletonClass shareSingleton].intr_name objectAtIndex:j]isEqualToString:[subData objectAtIndex:indexPath.row]]) {
                    [[SingletonClass shareSingleton].intr_name removeObjectAtIndex:indexPath.row];
                }
            }
       // }
        NSLog(@" %@",[subData objectAtIndex:indexPath.row]);
    }
    else{
        [cell.cellButton setImage:[UIImage imageNamed:@"select.png"]forState:UIControlStateSelected];
        [cell.cellButton setSelected:YES];
        [self.selectedArray addObject:indexPath];
        [[SingletonClass shareSingleton].intr_name addObject:[subData objectAtIndex:indexPath.row]];
        NSLog(@" %@",[subData objectAtIndex:indexPath.row]);
        
        
    }
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
