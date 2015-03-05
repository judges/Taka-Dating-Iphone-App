//
//  InterestViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 26/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "InterestViewController.h"
#import "AppDelegate.h"


@interface InterestViewController ()
@property(nonatomic,strong)AddInterestViewController * addInterestVC;

@end

@implementation InterestViewController

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
    
   // [SingletonClass shareSingleton].subArray=[[NSMutableArray alloc]init];

    [self getAllInterest];

    //Most Popular array data is from webservice
     //self.mostPopular=[NSArray arrayWithObjects:@"Most Popular",@"Music",@"Movies and TV Shows",@"Fashion and Beauty",@"Sprots",@"Food and Drink",@"Profession",@"Books and Culture",@"Travel", nil];
    interests_iphone=[NSArray arrayWithObjects:@"interest_icon.png",@"music_icon.png",@"movie_tv_shows.png",@"fashion_beauty.png",@"sports.png",@"food_drink_icon.png",@"profession_icon.png",@"books_culture_icon.png",@"travel_icon.png", nil];
    
//    self.browseByCat=[NSArray arrayWithObjects:@"Food & Drink",@"Music",@"Movies & TV Shows",@"Fashion & Beauty",@"Sports",@"Travel",@"Profession",@"Games",@"Hobbies",@"Books & Culture",@"Other", nil];
    
    self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, self.view.frame.size.width, 55);
    UIColor *firstColor = [UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
    UIColor *secColor = [UIColor colorWithRed:(CGFloat)121/255 green:(CGFloat)2/255 blue:(CGFloat)0/255 alpha:1.0];
    layer.colors = [NSArray arrayWithObjects:(id)[firstColor CGColor],(id)[secColor CGColor], nil];
    [self.view.layer insertSublayer:layer atIndex:0];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, self.view.frame.size.width-200, 35)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.text = @"Interests";
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
    
    
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}
-(void)createUI{
    
    
    self.intersetTable=[[UITableView alloc]init];
    if ([UIScreen mainScreen].bounds.size.height>500) {
        self.intersetTable.frame=CGRectMake(0, 55, self.view.frame.size.width, self.view.frame.size.height-55);
    }
    else{
        self.intersetTable.frame=CGRectMake(0, 55, self.view.frame.size.width, self.view.frame.size.height-145);
    }
    
    self.intersetTable.backgroundColor=[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    self.intersetTable.separatorColor=[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    self.intersetTable.delegate=self;
    self.intersetTable.dataSource=self;
    [self.view addSubview:self.intersetTable];
    
    
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
    self.intersetTable.tableHeaderView=sectionView ;
    //---------

}

#pragma mark-tableView Delegate Methods



-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString * str;
    /*if (section==0) {
         str= @"Most Popular";
        return str;
    }
    else if(section==1)
    {
        str=@"Borwse by Category";
        return str;
    }*/
    return  str;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rows=0;
    /*if(section==0)
    {
        rows= self.mostPopular.count;
        return rows;
    }
     if (section==1)
    {
        rows=self.browseByCat.count;
        return  rows;
    }*/
    return 9;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //InterestTableViewCell * cell=(InterestTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    InterestTableViewCell * cell=(InterestTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    if(cell==nil)
    {
        cell=[[InterestTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
         if (indexPath.section==0) {
        [cell.cellButton addTarget:self action:@selector(cellButtonAction:) forControlEvents:UIControlEventTouchDragInside];
         }
    }
    cell.containerView.frame=CGRectMake(0, 0, cell.frame.size.width, 50);
    cell.cellLabel.font=[UIFont systemFontOfSize:15];
    cell.cellLabel.textColor=[UIColor blackColor];
    cell.cellLabel.frame=CGRectMake(60, 10, 180, 30);
    cell.imgView.frame=CGRectMake(15, 15, 20, 20);
   
    
    
    
    
    if (indexPath.section==0) {
       // cell.cellButton.frame=CGRectMake(15, 15, 15, 15);
        //[cell.cellButton setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
       // [cell.cellButton setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
        //cell.cellLabel.text=[self.mostPopular objectAtIndex:indexPath.row];
        cell.imgView.image=[UIImage imageNamed:[interests_iphone objectAtIndex:indexPath.row]];
        
          if (indexPath.row==0)
        {
            cell.cellLabel.text=@"Most Popular";
        }
        else if (indexPath.row==1)
        {
            cell.cellLabel.text=@"Music";
        }
        else if(indexPath.row==2)
        {
            cell.cellLabel.text=@"Movies and TV Shows";
        }
        else if (indexPath.row==3)
        {
            cell.cellLabel.text=@"Fashion and Beauty";
        }
        else if (indexPath.row==4)
        {
            cell.cellLabel.text=@"Sprots";
        }
        else if (indexPath.row==5)
        {
            cell.cellLabel.text=@"Food and Drink";
        }
        else if (indexPath.row==6)
        {
            cell.cellLabel.text=@"Profession";
        }
        else if(indexPath.row==7)
        {
            cell.cellLabel.text=@"Books and Culture";
        }
        else{
            cell.cellLabel.text=@"Travel";
        }
        
       // cell.cellButton.tag=indexPath.row;
        
//        return cell;
    }
    /*if (indexPath.section==1)
    {
        
        cell.imgView.image=[UIImage imageNamed:@"crm.png"];
        cell.cellLabel.text=[self.browseByCat objectAtIndex:indexPath.row];
        cell.imgView.tag=indexPath.row;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        return  cell;
    }*/
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     NSMutableArray * temp=[[NSMutableArray alloc]init];
    NSMutableArray * temp2=[[NSMutableArray alloc]init];
     NSMutableArray * dataArr=[parse objectForKey:@"data"];
    //if (indexPath.section==0) {
    
        if (indexPath.row==0) {
            for (int i=0; i<dataArr.count; i++) {
                
                NSMutableDictionary * dict=[dataArr objectAtIndex:i];
                if ([[dict objectForKey:@"intr_cat_id"] isEqualToString:@"1"] ) {
                    NSMutableDictionary * dict_id=[[NSMutableDictionary alloc]init];
                    
                    [dict_id setObject:[dict objectForKey:@"intr_name"] forKey:[dict objectForKey:@"intr_id"]];
                    
                    [temp addObject:dict_id];
                    [temp2 addObject:[dict objectForKey:@"intr_id"]];
                }
            }
        }
            if (indexPath.row==1) {
                for (int i=0; i<dataArr.count; i++) {
                    
                    NSMutableDictionary * dict=[dataArr objectAtIndex:i];
                    if ([[dict objectForKey:@"intr_cat_id"] isEqualToString:@"2"] ) {
                        NSMutableDictionary * dict_id=[[NSMutableDictionary alloc]init];
                        
                        [dict_id setObject:[dict objectForKey:@"intr_name"] forKey:[dict objectForKey:@"intr_id"]];
                        [temp2 addObject:[dict objectForKey:@"intr_id"]];
                        [temp addObject:dict_id];
                    }
                }

            }
            if (indexPath.row==2) {
                for (int i=0; i<dataArr.count; i++) {
                    
                    NSMutableDictionary * dict=[dataArr objectAtIndex:i];
                    if ([[dict objectForKey:@"intr_cat_id"] isEqualToString:@"3"] ) {
                        NSMutableDictionary * dict_id=[[NSMutableDictionary alloc]init];
                        
                        [dict_id setObject:[dict objectForKey:@"intr_name"] forKey:[dict objectForKey:@"intr_id"]];
                         [temp2 addObject:[dict objectForKey:@"intr_id"]];
                        [temp addObject:dict_id];
                    }
                }
                
            }
            if (indexPath.row==3) {
                for (int i=0; i<dataArr.count; i++) {
                    
                    NSMutableDictionary * dict=[dataArr objectAtIndex:i];
                    if ([[dict objectForKey:@"intr_cat_id"] isEqualToString:@"4"] ) {
                        NSMutableDictionary * dict_id=[[NSMutableDictionary alloc]init];
                        
                        [dict_id setObject:[dict objectForKey:@"intr_name"] forKey:[dict objectForKey:@"intr_id"]];
                        [temp2 addObject:[dict objectForKey:@"intr_id"]];
                        [temp addObject:dict_id];
                    }
                }
                
            }

            if (indexPath.row==4) {
                for (int i=0; i<dataArr.count; i++) {
                    
                    NSMutableDictionary * dict=[dataArr objectAtIndex:i];
                    if ([[dict objectForKey:@"intr_cat_id"] isEqualToString:@"5"] ) {
                        NSMutableDictionary * dict_id=[[NSMutableDictionary alloc]init];
                        
                        [dict_id setObject:[dict objectForKey:@"intr_name"] forKey:[dict objectForKey:@"intr_id"]];
                         [temp2 addObject:[dict objectForKey:@"intr_id"]];
                        [temp addObject:dict_id];
                    }
                }
                
            }

            if (indexPath.row==5) {
                for (int i=0; i<dataArr.count; i++) {
                    
                    NSMutableDictionary * dict=[dataArr objectAtIndex:i];
                    if ([[dict objectForKey:@"intr_cat_id"] isEqualToString:@"6"] ) {
                        NSMutableDictionary * dict_id=[[NSMutableDictionary alloc]init];
                        
                        [dict_id setObject:[dict objectForKey:@"intr_name"] forKey:[dict objectForKey:@"intr_id"]];
                        [temp2 addObject:[dict objectForKey:@"intr_id"]];
                        [temp addObject:dict_id];
                    }
                }
                
            }

            if (indexPath.row==6) {
                
                for (int i=0; i<dataArr.count; i++) {
                    
                    NSMutableDictionary * dict=[dataArr objectAtIndex:i];
                    if ([[dict objectForKey:@"intr_cat_id"] isEqualToString:@"7"] ) {
                        NSMutableDictionary * dict_id=[[NSMutableDictionary alloc]init];
                        
                        [dict_id setObject:[dict objectForKey:@"intr_name"] forKey:[dict objectForKey:@"intr_id"]];
                         [temp2 addObject:[dict objectForKey:@"intr_id"]];
                        [temp addObject:dict_id];
                    }
                }
                
            }

            if (indexPath.row==7) {
                for (int i=0; i<dataArr.count; i++) {
                    
                    NSMutableDictionary * dict=[dataArr objectAtIndex:i];
                    if ([[dict objectForKey:@"intr_cat_id"] isEqualToString:@"8"] ) {
                        NSMutableDictionary * dict_id=[[NSMutableDictionary alloc]init];
                        
                        [dict_id setObject:[dict objectForKey:@"intr_name"] forKey:[dict objectForKey:@"intr_id"]];
                         [temp2 addObject:[dict objectForKey:@"intr_id"]];
                        [temp addObject:dict_id];
                    }
                }
                
            }

            if (indexPath.row==8) {
                for (int i=0; i<dataArr.count; i++) {
                    
                    NSMutableDictionary * dict=[dataArr objectAtIndex:i];
                    if ([[dict objectForKey:@"intr_cat_id"] isEqualToString:@"9"] ) {
                        NSMutableDictionary * dict_id=[[NSMutableDictionary alloc]init];
                        
                        [dict_id setObject:[dict objectForKey:@"intr_name"] forKey:[dict objectForKey:@"intr_id"]];
                         [temp2 addObject:[dict objectForKey:@"intr_id"]];
                        [temp addObject:dict_id];
                    }
                }
                
            }


        
             subArray=[NSMutableArray arrayWithArray:temp];
    
            NSLog(@"array %@",subArray);
    
        
        
        
    if (self.addInterestVC) {
        
        self.addInterestVC=nil;
    }self.addInterestVC=[[AddInterestViewController alloc]initWithNibName:@"AddInterestViewController" bundle:nil];
    self.addInterestVC.subArray=subArray;
    self.addInterestVC.intr_id_arr=temp2;
        AppDelegate * appdelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
        //[appdelegate.window addSubview:self.addInterestVC.view];
    [self.navigationController pushViewController:self.addInterestVC animated:YES];
    
   
}

#pragma mark-cellButton Action

-(void)cellButtonAction:(id)sender{
    NSLog(@"Cell Button Clicked");
}

-(void)cancelButtonAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    //[[[[[UIApplication sharedApplication]keyWindow]subviews]lastObject]removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- getAllInterest

-(void)getAllInterest{
    NSError * error;
    NSURLResponse * resposne;
    NSString * urlStr=[NSString stringWithFormat:@"http://taka.dating//user/getAllInterests/%@",[SingletonClass shareSingleton].userID];
    
    urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url=[NSURL URLWithString:urlStr];
    
    NSMutableURLRequest * request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&resposne error:&error];
    if (data==nil) {
        NSLog(@"Data is not available");
        return;
    }
    parse=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"getall instrests %@",parse);
    
    
}


@end
