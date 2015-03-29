//
//  InterestViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 26/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "InterestViewController.h"
#import "AppDelegate.h"
#import "SingletonClass.h"

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
    if (UI_USER_INTERFACE_IDIOM()!=UIUserInterfaceIdiomPad) {
        interests_iphone=[NSArray arrayWithObjects:@"interest_icon.png",@"music_icon.png",@"movie_tv_shows.png",@"fashion_beauty.png",@"sports.png",@"food_drink_icon.png",@"profession_icon.png",@"books_culture_icon.png",@"travel_icon.png", nil];
    }
    else{
    interests_iphone=[NSArray arrayWithObjects:@"interest_icon_ipad.png",@"music_icon_ipad.png",@"movie_tv_shows.png",@"fashion_beauty_ipad.png",@"sports_ipad.png",@"food_drink_icon_ipad.png",@"profession_icon_ipad.png",@"books_culture_icon_ipad.png",@"travel_icon_ipad.png", nil];
    }
//    self.browseByCat=[NSArray arrayWithObjects:@"Food & Drink",@"Music",@"Movies & TV Shows",@"Fashion & Beauty",@"Sports",@"Travel",@"Profession",@"Games",@"Hobbies",@"Books & Culture",@"Other", nil];
    
    windowSize=[UIScreen mainScreen].bounds.size;
    //self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)148/255 blue:(CGFloat)214/255 alpha:1.0];
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, windowSize.width, 55);
   // UIColor *firstColor = [UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
  //  UIColor *secColor = [UIColor colorWithRed:(CGFloat)121/255 green:(CGFloat)2/255 blue:(CGFloat)0/255 alpha:1.0];
    UIColor *firstColor = [UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)88/255 blue:(CGFloat)211/255 alpha:1.0];
    UIColor *secColor = [UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)0/255 blue:(CGFloat)155/255 alpha:1.0];
    layer.colors = [NSArray arrayWithObjects:(id)[firstColor CGColor],(id)[secColor CGColor], nil];
    [self.view.layer insertSublayer:layer atIndex:0];
    
    self.titleLabel = [[UILabel alloc] init];
self.titleLabel.frame=CGRectMake(windowSize.width/2-60, 20, windowSize.width-200, 35);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.text = @"Interests";
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
    
    
    UIButton * saveButton=[UIButton buttonWithType:UIButtonTypeCustom];
    saveButton.frame=CGRectMake(windowSize.width-70, 25, 60, 25);
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveButton setTitle:@"Update" forState:UIControlStateNormal];
    saveButton.titleLabel.font = [UIFont systemFontOfSize:15];
    saveButton.layer.borderColor = [UIColor redColor].CGColor;
    saveButton.layer.borderWidth = 0.7;
    saveButton.layer.cornerRadius = 4;
    saveButton.clipsToBounds = YES;
    [saveButton addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];

    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        layer.frame = CGRectMake(0, 0, windowSize.width, 75);
        self.titleLabel.frame=CGRectMake(windowSize.width/2-270, 20, windowSize.width-200, 35);
        self.cancelButton.frame = CGRectMake(windowSize.width/2-350, 25, 120, 40);
         saveButton.frame=CGRectMake(windowSize.width-150, 25, 120, 40);
        
         self.titleLabel.font = [UIFont boldSystemFontOfSize:30];
        self.cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        saveButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        height=75;
        row_hight=85;
    }
    else{
        height=55;
        row_hight=50;
    }
    
    
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}
-(void)createUI{
    
    
    self.intersetTable=[[UITableView alloc]init];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        self.intersetTable.frame=CGRectMake(0, height, windowSize.width, windowSize.height);
    }
    else{
        if ([UIScreen mainScreen].bounds.size.height>500) {
        self.intersetTable.frame=CGRectMake(0, height, windowSize.width, windowSize.height);
    }
    else{
        self.intersetTable.frame=CGRectMake(0, height, windowSize.width, windowSize.height-145);
    }
    }
    self.intersetTable.backgroundColor=[UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)148/255 blue:(CGFloat)214/255 alpha:1.0];
    self.intersetTable.separatorColor=[UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)148/255 blue:(CGFloat)214/255 alpha:1.0];
    self.intersetTable.delegate=self;
    self.intersetTable.dataSource=self;
    [self.view addSubview:self.intersetTable];
    
    
    UIView * sectionView=[[UIView alloc]init];
    sectionView.frame=CGRectMake(0, 0, windowSize.width, 60);
    sectionView.backgroundColor=[UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)148/255 blue:(CGFloat)214/255 alpha:1.0];
    if (UIUserInterfaceIdiomPad==UI_USER_INTERFACE_IDIOM()) {
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
    self.intersetTable.tableHeaderView=sectionView ;
    //---------

}

#pragma mark-tableView Delegate Methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return row_hight;
}

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
   // NSInteger rows=0;
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
    if (UIUserInterfaceIdiomPad==UI_USER_INTERFACE_IDIOM()) {
        
        cell.containerView.frame=CGRectMake(0, 0, windowSize.width, row_hight);
        cell.cellLabel.font=[UIFont boldSystemFontOfSize:20];
        cell.cellLabel.textColor=[UIColor blackColor];
        cell.cellLabel.frame=CGRectMake(100, 25, windowSize.width/2, 30);
        cell.imgView.frame=CGRectMake(25, 25, 40, 40);
    }
    else{
        cell.containerView.frame=CGRectMake(0, 0, windowSize.width, row_hight);
        cell.cellLabel.font=[UIFont systemFontOfSize:15];
        cell.cellLabel.textColor=[UIColor blackColor];
        cell.cellLabel.frame=CGRectMake(60, 10, 180, 30);
        cell.imgView.frame=CGRectMake(15, 15, 20, 20);
    }
   
    
    
    
    
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
      //  AppDelegate * appdelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
        //[appdelegate.window addSubview:self.addInterestVC.view];
    [self.navigationController pushViewController:self.addInterestVC animated:YES];
    
   
}

#pragma mark-cellButton Action

-(void)cellButtonAction:(id)sender{
    NSLog(@"Cell Button Clicked");
}

-(void)cancelButtonAction:(id)sender{
    [self getUserUpdatedInterests];
    [self.navigationController popViewControllerAnimated:YES];
    //[[[[[UIApplication sharedApplication]keyWindow]subviews]lastObject]removeFromSuperview];
}

#pragma mark- updated results
-(void)getUserUpdatedInterests{
    NSError * error;
    NSURLResponse * urlResponse=nil;
    
    NSURL * postUrl=[NSURL URLWithString:@"http://23.238.24.26/user/get-full-user-interests"];
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:postUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSString * body=[NSString stringWithFormat:@"userId=%@",[SingletonClass shareSingleton].userID];
    [request setHTTPBody:[body dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (data==nil) {
        return;
    }
    id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"User interests %@ ",json);
    NSMutableDictionary * dict=[NSMutableDictionary dictionary];
    if ([[json objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
        NSArray *  interests=[json objectForKey:@"data"];
        for (int i=0; i<interests.count; i++) {
            dict=[interests objectAtIndex:i];
            [[SingletonClass shareSingleton].selectedIntName addObject:[dict objectForKey:@"intr_name"]];
            [[SingletonClass shareSingleton].selectedIntId addObject:[dict objectForKey:@"intr_id"]];
        }
    }

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
    NSString * urlStr=[NSString stringWithFormat:@"http://23.238.24.26/user/get-all-interests"];
    
   // urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url=[NSURL URLWithString:urlStr];
    
    NSMutableURLRequest * request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSString * body=[NSString stringWithFormat:@"userId=%@",[SingletonClass shareSingleton].userID];
    [request setHTTPBody:[body dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&resposne error:&error];
    if (data==nil) {
        NSLog(@"Data is not available");
        return;
    }
    parse=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"getall instrests %@",parse);

    
}

#pragma mark- send Button action
-(void)saveButtonAction:(UIButton*)sender{
    
    NSMutableString * interests=[[NSMutableString alloc]init];
    
    for (int i=0; i<[SingletonClass shareSingleton].selectedIntId.count; i++) {
        if (i==0) {
            [interests  appendString:[NSString stringWithFormat:@"%@",[[SingletonClass shareSingleton].selectedIntId objectAtIndex:i]]];
        }
        else{
            [interests  appendString:[NSString stringWithFormat:@",%@",[[SingletonClass shareSingleton].selectedIntId objectAtIndex:i]]];
        }
    }
    
    
    NSError * error=nil;
    NSURLResponse * urlResponse=nil;
    
    NSURL * postUrl=[NSURL URLWithString:@"http://23.238.24.26/user/interest-update"];
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:postUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSString * body=[NSString stringWithFormat:@"userId=%@&interests=%@",[SingletonClass shareSingleton].userID,interests];
    
    [request setHTTPBody:[body dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    if (data==nil) {
        return;
    }
    id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"Update interests %@",json);
    if ([[json objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
        // Grant award..
        if ([SingletonClass shareSingleton].intr_id.count>15) {
            
        
        NSURL * postUrl=[NSURL URLWithString:@"http://23.238.24.26/award/grant-award/"];
        
        NSMutableURLRequest *  request=[[NSMutableURLRequest alloc]initWithURL:postUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
        [request setHTTPMethod:@"POST"];
        [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
      

        NSString * body=[NSString stringWithFormat:@"userId=%@&awardId=%@",[SingletonClass shareSingleton].userID,@"3"];
        
        [request setHTTPBody:[body dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
        
        NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
        
        if(data==nil){
            return;
        }
        
        id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"grnated award %@",json);
        }
    }
}

@end
