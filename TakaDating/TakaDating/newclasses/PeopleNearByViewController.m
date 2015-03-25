//
//  PeopleNearByViewController.m
//  TakaDating
//
//  Created by GBS-ios on 11/10/14.
//  Copyright (c) 2014 Globussoft. All rights reserved.
//

#import "PeopleNearByViewController.h"
#import "CollectionHeaderTitleLabel.h"
#import "CustomCellView.h"
#import "CustomProfileView.h"
#import  "PromoteyourselfViewController.h"
#import "SingletonClass.h"
#import "UIImageView+WebCache.h"
#import "UserProfileViewController.h"

@interface PeopleNearByViewController ()
{
    //UITableView *tempTable;
    //UICollectionReusableView *reuseableView;
    UILabel *textLabel;
    CollectionHeaderTitleLabel *reuseableView;
    PromoteyourselfViewController * promote;
}
@end

@implementation PeopleNearByViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadCollectionView) name:@"reloadCollectionView" object:nil];
}

-(void)reloadCollectionView{
    
    [self.mainCollectionView reloadData];
}

- (void)viewDidLoad
{
    //[NSThread detachNewThreadSelector:@selector(callServiceForPeopleNearby) toTarget:self withObject:nil];
    // [self callServiceForPeopleNearby];
    
     self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    
    [super viewDidLoad];
   
    [self createUI];
    CGRect  frame;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        frame=CGRectMake(windowSize.width/2, 150, 40, 40);
    }
    else{
        frame=CGRectMake(140, 150, 40, 40);
    }
    self.refreshActivityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:frame];
        self.refreshActivityIndicator.alpha = 1.0;
    self.refreshActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    self.refreshActivityIndicator.color = [UIColor blackColor];
    [self.view addSubview:self.refreshActivityIndicator];
    [self.view bringSubviewToFront:self.refreshActivityIndicator];
    [self.refreshActivityIndicator startAnimating];

    
  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(createUIOnServiceLoad) name:@"peopleNearby" object:nil];
  

    
}

-(void)createUIOnServiceLoad{
      dispatch_async(dispatch_get_global_queue(0, 0), ^{
    
         [self callServiceForPeopleNearby];
    
      dispatch_async(dispatch_get_main_queue(), ^{
          [self.refreshActivityIndicator stopAnimating];
          [self createCollectionView];
      });
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)createUI{
    firstTime=YES;
    [SingletonClass shareSingleton].viewerName=[[NSMutableArray alloc]init];
    [SingletonClass shareSingleton].imgCount=[[NSMutableArray alloc]init];
    [SingletonClass shareSingleton].isOnline=[[NSMutableArray alloc]init];
    [SingletonClass shareSingleton].viewerImage=[[NSMutableArray alloc]init];
    [SingletonClass shareSingleton].viewerID=[[NSMutableArray alloc]init];
    currentPage=1;
    addNewRows=YES;
    
    
    
    
   
    // Do any additional setup after loading the view from its nib.
    
    
    
}
#pragma mark-

-(void) createCollectionView{
    
   // [self.refreshActivityIndicator stopAnimating];
     self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    windowSize=[UIScreen mainScreen].bounds.size;
    self.topCollectionArray = @[@"Abc",@"Bcd",@"Cde",@"Def",@"Efg"];
    //---------
    UICollectionViewFlowLayout *flowLayOut= [[UICollectionViewFlowLayout alloc] init];
    flowLayOut.minimumInteritemSpacing = (CGFloat)2.0;
    flowLayOut.minimumLineSpacing = (CGFloat)2.0;
    flowLayOut.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        self.mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, windowSize.width, windowSize.height-55) collectionViewLayout:flowLayOut];

    }else{
        self.mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, windowSize.width, windowSize.height-55) collectionViewLayout:flowLayOut];

    }
    
       self.automaticallyAdjustsScrollViewInsets = NO;
    //self.mainCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    [self.mainCollectionView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    self.mainCollectionView.dataSource = self;
    self.mainCollectionView.delegate = self;
    //self.mainCollectionView.backgroundColor = [UIColor colorWithRed:(CGFloat)59/255 green:(CGFloat)97/255 blue:(CGFloat)107/255 alpha:1];
    self.mainCollectionView.backgroundColor = [UIColor blackColor];
    [self.mainCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CustomCollectionCell"];
    
    [self.view addSubview:self.mainCollectionView];
    //self.mainCollectionView.scrollEnabled = NO;
    [self.mainCollectionView registerClass:[CollectionHeaderTitleLabel class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [self.mainCollectionView registerClass:[CollectionHeaderTitleLabel class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderViewSectionTwo"];
    
    
    
    //-------------------------------------------
}
#pragma mark-
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   // NSLog(@"count ---====--- %d",[SingletonClass shareSingleton].viewerID.count);
    return [SingletonClass shareSingleton].viewerID.count;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"CustomCollectionCell" forIndexPath:indexPath];
    //NSString *name = @"";
    
    
    CustomCellView *customCellView = [[CustomCellView alloc] initWithFrame:cell.bounds];
    //customCellView.profileImageView.image = [UIImage imageNamed:name];
   // customCellView.nameLabel.text = @"Xyz";
    NSString * imageName=[NSString stringWithFormat:@"http://taka.dating/%@",[[SingletonClass shareSingleton].viewerImage objectAtIndex:indexPath.row]];
    NSURL * imageUrl=[NSURL URLWithString:imageName];
    [customCellView.profileImageView setImageWithURL:imageUrl];
    customCellView.nameLabel.text=[[SingletonClass shareSingleton].viewerName objectAtIndex:indexPath.row];
    if ([[SingletonClass shareSingleton].isOnline[indexPath.row]  isEqualToString:@"0"]) {
        customCellView.isOnlne.image=[UIImage imageNamed:@"offline_icon.png"];
    }
    else{
         customCellView.isOnlne.image=[UIImage imageNamed:@"online_icon.png"];
    }
    NSString *totalCount=[[[SingletonClass shareSingleton].imgCount objectAtIndex:indexPath.row]stringValue];
   // [NSString stringWithFormat:@"%d",(int)indexPath.row];
    CGFloat h = 25 + ([totalCount length]*5);
    if (h>70) {
        h = 70;
        customCellView.customImageCounterView.frame = CGRectMake(70-h, 55, h, 16);
        [customCellView.customImageCounterView.totalImageCountLabel sizeToFit];
    }
    else{
        customCellView.customImageCounterView.frame = CGRectMake(70-h, 55, h, 16);
    }
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        
        customCellView.customImageCounterView.frame = CGRectMake(100, 120, 50, 30);
    }
    
    customCellView.customImageCounterView.totalImageCountLabel.text =totalCount ;
    cell.backgroundColor = [UIColor clearColor];
    [cell addSubview:customCellView];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        return  CGSizeMake(150, 150);
    }
    return CGSizeMake(73, 73);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        CGSize size = CGSizeMake(self.view.frame.size.width, 25);
        return size;
   }
        CGSize size = CGSizeMake(self.view.frame.size.width, 25);
        return size;
    
}



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionHeader){
        
        reuseableView = nil;
        
        if (indexPath.section==0) {
            reuseableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
            
          // [self createFirstSectionHeader:reuseableView];
        }
        else{
            reuseableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderViewSectionTwo" forIndexPath:indexPath];
        }
        
        
        reuseableView.backgroundColor = [UIColor whiteColor];
        if (indexPath.section==0) {
            //textLabel.frame = CGRectMake(0, 100, self.view.frame.size.width, 25);
            reuseableView.headerTitleLabel.text = @"   Near";
        }
        else{
           // textLabel.frame = CGRectMake(0, 0, self.view.frame.size.width, 25);
            reuseableView.headerTitleLabel.text = @"   India";
        }
        
        return reuseableView;
        
    }//End Header Kind Check
    return nil;
}






-(void) createFirstSectionHeader:(CollectionHeaderTitleLabel *)areuseableView{
   
    UIView *backView=[[UIView alloc]init];
    backView.frame=CGRectMake(0, 0, 100, 100);
    backView.backgroundColor = [UIColor blackColor];
    [areuseableView addSubview:backView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(12, 14, 73, 73);
  //  button.backgroundColor = [UIColor colorWithRed:(CGFloat)88/255 green:(CGFloat)95/255 blue:(CGFloat)107/255 alpha:1];
    button.titleLabel.numberOfLines = 0;
    button.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"add_me_icon.png"] forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:12];
    [button setTitle:@"Add me here!" forState:UIControlStateNormal];
   // button.layer.borderWidth = 5;
   // button.layer.borderColor = [UIColor blueColor].CGColor;
   // button.layer.cornerRadius = 5.0;
   // button.clipsToBounds = YES;
    
    
    
    [button addTarget:self action:@selector(addMeHereButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [backView addSubview:button];
    //------------------------------------
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.frame=CGRectMake(92, 0, windowSize.width-92, 100);
    self.scrollView.backgroundColor = [UIColor blackColor];
    [areuseableView addSubview:self.scrollView];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        backView.frame=CGRectMake(0, 0, 110, 100);
        button.frame = CGRectMake(12, 14, 100, 85);
        self.scrollView.frame=CGRectMake(110, 0, windowSize.width-92, 100);
    }
    
    [self addHeaderDetails];
}
-(void)addHeaderDetails{
    for (UIView *v in self.scrollView.subviews) {
        v.hidden = YES;
    }
    CGFloat x = 0;
    CGFloat  scrol_hh=0;
    for (int i = 0; i<self.topCollectionArray.count; i++) {
     
        CustomProfileView *customProfileView = (CustomProfileView*)[self.scrollView viewWithTag:1000+i];
        if (customProfileView==nil) {
            customProfileView = [[CustomProfileView alloc]init];
            customProfileView.tag = 1000+i;
            [self.scrollView addSubview:customProfileView];
        }
        else{
            customProfileView.hidden = NO;
        }
        customProfileView.profileImageView.image = [UIImage imageNamed:@""];
       
        customProfileView.nameLabel.text = [NSString stringWithFormat:@"%@",[self.topCollectionArray objectAtIndex:i]];
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            customProfileView.frame=CGRectMake(x, 14, 85, 85);
            x = x+90;
            scrol_hh=100;
        }
        else{
            customProfileView.frame=CGRectMake(x, 14, 73, 73);
            x = x+76;
            scrol_hh=100;
        }
    }//End For Loop
    [self.scrollView setContentSize:CGSizeMake(x,scrol_hh)];
}
#pragma mark-
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [SingletonClass shareSingleton].fromChat=NO;
    UserProfileViewController * userDataVC=[[UserProfileViewController alloc]initWithNibName:@"UserProfileViewController" bundle:nil];
    
    userDataVC.index=[[SingletonClass shareSingleton].viewerID objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:userDataVC animated:YES];
}


#pragma mark- scroll view delegate.


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.bounds;
    CGSize size = scrollView.contentSize;
    UIEdgeInsets inset = scrollView.contentInset;
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;
    
    if (y > h+50) {
        if (addNewRows==YES) {
            [self.refreshActivityIndicator startAnimating];
             currentPage = currentPage +1;
            [self addMoreRows];
        }
        
    }
   
}

-(void)addMoreRows{
    addNewRows=NO;
   
    if (currentPage>0 && currentPage <= 87) {
        
        NSLog(@"currnt page cpunt %d",currentPage);
        [self.mainCollectionView setContentInset:(UIEdgeInsetsMake(0, 0, 0, 0))];
        [NSThread detachNewThreadSelector:@selector(callServiceForPeopleNearby) toTarget:self withObject:nil];
    }
    else
    {
        [self.refreshActivityIndicator stopAnimating];
    }
    
}

#pragma mark- Add button action

-(void)addMeHereButtonAction:(id)sender{
    if (promote) {
        promote=nil;
    }
    promote=[[PromoteyourselfViewController alloc]initWithNibName:@"PromoteyourselfViewController" bundle:nil];
    [self.navigationController pushViewController:promote animated:YES];
}


-(void)dealloc{
    NSLog(@"nsnotification dealloc");
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"peopleNearby" object:nil];
}

#pragma mark-callServiceForPeopleNearby
-(void)callServiceForPeopleNearby{
    
    
    
    
    NSError * error;
    NSURLResponse * urlResponse;
    
    //int count=1;
    // NSString * urlStr=[NSString stringWithFormat:@"http://taka.dating/user/people-nearby/location/%@/%d",[SingletonClass shareSingleton].emailID,currentPage];
    
    
    NSString * urlStr;
    /*urlStr=[NSString stringWithFormat:@"http://taka.dating/user/people-nearby/location/%@/%d",[SingletonClass shareSingleton].emailID,currentPage];
    
    
    urlStr =[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];*/
    urlStr =@"http://23.238.24.26/mobi/people-nearby";
    NSURL * url=[NSURL URLWithString:urlStr];
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSString * body=[NSString stringWithFormat:@"userEmail=%@&count=%d",[SingletonClass shareSingleton].emailID,currentPage];
    [request setHTTPBody:[body dataUsingEncoding:NSASCIIStringEncoding  allowLossyConversion:YES]];

    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (data==nil) {
        NSLog(@"No data available");
        return;
    }
    NSArray * parse=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"people near by %@",parse);
    
    NSMutableDictionary * dict=[[NSMutableDictionary alloc]init];
    for (int i=0; i<parse.count; i++) {
        dict=[parse objectAtIndex:i];
        [ [SingletonClass shareSingleton].viewerName addObject:[dict objectForKey:@"displayName"]];
        [[SingletonClass shareSingleton].imgCount addObject:[dict objectForKey:@"imagecount"]];
        [[SingletonClass shareSingleton].isOnline addObject:[dict objectForKey:@"isOnline"]];
        [[SingletonClass shareSingleton].viewerImage addObject:[dict objectForKey:@"thumbanailUrl"]];
        [[SingletonClass shareSingleton].viewerID addObject:[dict objectForKey:@"userId"]];
    }
    
    //dispatch_async(dispatch_get_main_queue(), ^{
        [self.refreshActivityIndicator stopAnimating];
        [self.mainCollectionView reloadData];
        addNewRows=YES;
   // });
}



/*
-(void)createTable{
    tempTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.bounds.size.height-50) style:UITableViewStylePlain];
    tempTable.dataSource = self;
    tempTable.delegate = self;
    tempTable.scrollEnabled = NO;
    [self.scrollView addSubview:tempTable];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *title = [NSString stringWithFormat:@"Sectoin %ld",section+1];
    return title;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"Cell Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Section %ld, Row %ld",indexPath.section+1,(long)indexPath.row];
    return cell;
}
 
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    NSLog(@"off = %f",offset.y);
    if (scrollView == self.scrollView) {
        if (offset.y>=70) {
            self.mainCollectionView.scrollEnabled = YES;
        }
        else{
            self.mainCollectionView.scrollEnabled = NO;
        }
    }
    else{
        if (offset.y<=1) {
            self.mainCollectionView.scrollEnabled = NO;
        }
        
        CGRect bounds = scrollView.bounds;
        CGSize size = scrollView.contentSize;
        UIEdgeInsets inset = scrollView.contentInset;
        float y = offset.y + bounds.size.height - inset.bottom;
        float h = size.height;
        NSLog(@"h = %f",h);
        if (y > h+50) {
            
            NSLog(@"Add more data");
        }
    }
}
 */
@end
