//
//  VisitorsViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 30/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "VisitorsViewController.h"
#import "CollectionHeaderTitleLabel.h"
#import "CustomCellView.h"
#import "CustomProfileView.h"
#import  "PromoteyourselfViewController.h"
#import "SingletonClass.h"
#import "UIImageView+WebCache.h"
#import "UserProfileViewController.h"
#import "customCollectionCiewCell.h"


@interface VisitorsViewController ()
{
    //UITableView *tempTable;
    //UICollectionReusableView *reuseableView;
    UILabel *textLabel;
    //CustomCellView *customCellView ;
    CollectionHeaderTitleLabel *reuseableView;
}
@property(nonatomic,strong)PromoteyourselfViewController * promoteVC;
@end

@implementation VisitorsViewController

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
    if (cellSelectedArr ) {
        cellSelectedArr=nil;
    }
    cellSelectedArr=[[NSMutableArray alloc]init];
    windowSize=[UIScreen mainScreen].bounds.size;
   // self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    self.view.backgroundColor= [UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)148/255 blue:(CGFloat)214/255 alpha:1.0];
    
   // [self profileVisitorsWebservice];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(createUI) name:@"visitorsUI" object:nil];
    
    
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(editVisitorsButtonAction) name:@"editVisitorsButtonAction" object:nil];
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cancelButtonAction) name:@"cancelVisitorsButtonAction" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectButtonAction:) name:@"selectVisitorsButtonAction" object:nil];
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deselectButtonAction) name:@"deselectVisitorsButtonAction" object:nil];
    
    CGRect frame;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        frame=CGRectMake(windowSize.width/2-20, 150, 40, 40);
    }
    else{
        frame= CGRectMake(140, 150, 40, 40);
    }
    
    self.refreshActivityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:frame];
    self.refreshActivityIndicator.alpha = 1.0;
    self.refreshActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    self.refreshActivityIndicator.color = [UIColor blackColor];
    [self.view addSubview:self.refreshActivityIndicator];
    [self.view bringSubviewToFront:self.refreshActivityIndicator];
    [self.refreshActivityIndicator startAnimating];
    
    viewerID=[[NSMutableArray alloc]init];
    viewerImage=[[NSMutableArray alloc]init];
    viewerName=[[NSMutableArray alloc]init];
    imgCount=[[NSMutableArray alloc]init];
    
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)createUI{
    dispatch_async(dispatch_get_global_queue(0, 0),^{
        [self callWebService];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.refreshActivityIndicator stopAnimating];
            if (viewerID.count<1) {
                [self createUIIfNovisitors];
            }
            else{
                [self createCollectionView];
            }
        });
    });
}

-(void)createUIIfNovisitors{
    
    
    UILabel * label=[[UILabel alloc]init];
    label.frame=CGRectMake(windowSize.width/2-130, 135, windowSize.width-60, 40);
    label.text=@"You haven't had any visitors yet. Promote yourself and be seen by pepople near you.";
    label.lineBreakMode=NSLineBreakByCharWrapping;
    label.numberOfLines=0;
    label.textColor=[UIColor blackColor];
    label.font=[UIFont boldSystemFontOfSize:13];
    [self.view addSubview:label];
    
    
    UIButton * promoteButton=[UIButton buttonWithType:UIButtonTypeCustom];
    promoteButton.frame=CGRectMake(windowSize.width/2-80, 200, 167, 32);
    [promoteButton setTintColor:[UIColor whiteColor]];
    [promoteButton setTitle:@"Promote yourself" forState:UIControlStateNormal];
    [promoteButton setBackgroundImage:[UIImage imageNamed:@"setting_btn_bg.png"] forState:UIControlStateNormal];
    [promoteButton addTarget:self action:@selector(addMeHereButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:promoteButton];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        promoteButton.frame=CGRectMake(windowSize.width/2-100, windowSize.height/2-200,167, 32);
        label.frame=CGRectMake(windowSize.width/2-250, windowSize.height/2-140, windowSize.width/2+100, 50);
        label.font=[UIFont boldSystemFontOfSize:20];
        [promoteButton setBackgroundImage:[UIImage imageNamed:@"setting_btn_bg_ipad.png"] forState:UIControlStateNormal];
        
    }
}



#pragma mark-

-(void) createCollectionView{
    self.topCollectionArray = @[@"Abc",@"Bcd",@"Cde",@"Def",@"Efg"];
    //---------
    UICollectionViewFlowLayout *flowLayOut= [[UICollectionViewFlowLayout alloc] init];
    flowLayOut.minimumInteritemSpacing = (CGFloat)2.0;
    flowLayOut.minimumLineSpacing = (CGFloat)2.0;
    flowLayOut.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        self.mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, windowSize.width, windowSize.height) collectionViewLayout:flowLayOut];
        flowLayOut.minimumInteritemSpacing = (CGFloat)2.0;
        flowLayOut.minimumLineSpacing = (CGFloat)10.0;

        
    }else{
        self.mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, windowSize.width, windowSize.height+90) collectionViewLayout:flowLayOut];
        
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    //self.mainCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    [self.mainCollectionView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    self.mainCollectionView.dataSource = self;
    self.mainCollectionView.delegate = self;
    //self.mainCollectionView.backgroundColor = [UIColor colorWithRed:(CGFloat)59/255 green:(CGFloat)97/255 blue:(CGFloat)107/255 alpha:1];
    self.mainCollectionView.backgroundColor = [UIColor blackColor];
    [self.mainCollectionView registerClass:[customCollectionCiewCell class] forCellWithReuseIdentifier:@"CustomCollectionCell"];
    
    [self.view addSubview:self.mainCollectionView];
    //self.mainCollectionView.scrollEnabled = NO;
    [self.mainCollectionView registerClass:[CollectionHeaderTitleLabel class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [self.mainCollectionView registerClass:[CollectionHeaderTitleLabel class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderViewSectionTwo"];
      [self.mainCollectionView registerClass:[CollectionHeaderTitleLabel class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderViewSectionThree"];
    
    //-------------------------------------------
}
#pragma mark-
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@" viewr count in  visitors %lu",(unsigned long)viewerID.count);
        return viewerID.count;
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    customCollectionCiewCell *customCellView=[collectionView dequeueReusableCellWithReuseIdentifier:@"CustomCollectionCell" forIndexPath:indexPath];
   // UICollectionViewCell * cell=[collectionView cellForItemAtIndexPath:indexPath];
   
         //customCellView = [[CustomCellView alloc] initWithFrame:cell.bounds];
    
    
    
    if (indexPath.section==0) {
        
        
        if (imgCount.count>0) {
  

        if(editAll==YES)
        {
            toggleButton=[UIButton buttonWithType:UIButtonTypeCustom];
            toggleButton.frame=CGRectMake(60,5, 15, 15);
            [toggleButton setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
            [toggleButton setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
           // [customCellView addSubview:toggleButton];
            
            
            if (selectAll==NO) {
                
                // [customCellView.togglebutton setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
                [toggleButton setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
                [toggleButton setSelected:NO];
                toggleButton.tag=indexPath.row;
                NSNumber * index=[NSNumber numberWithInteger:indexPath.row];
                [cellSelectedArr removeObject:index];
            }
            else{
                [toggleButton setSelected:YES];
                [toggleButton setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
                toggleButton.tag=indexPath.row;
                NSNumber * index=[NSNumber numberWithInteger:indexPath.row];
                [cellSelectedArr addObject:index];
                //[customCellView.togglebutton setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
            }
            //customCellView.togglebutton.tag=indexPath.row;
            //[customCellView.togglebutton addTarget:self action:@selector(toggleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [toggleButton addTarget:self action:@selector(toggleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        else {
            toggleButton.hidden=YES;
            // customCellView.togglebutton.hidden=YES;
        }
    customCellView.customImageCounterView.hidden=NO;
            NSURL * imageUrl;
           // *************** This is for super power adding ************
           // if ([SingletonClass shareSingleton].superPower==0) {
               //  customCellView.profileImageView .image= [UIImage imageNamed:@"Blur.jpg"];
           // }
           // else{
             imageUrl=[NSURL URLWithString:[NSString stringWithFormat:@"%@",[viewerImage objectAtIndex:indexPath.row]]];
                 [customCellView.profileImageView setImageWithURL:imageUrl];
           // }
           
   
    customCellView.nameLabel.text =[viewerName objectAtIndex:indexPath.row];
            NSString *offline,*online;
            if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
                online=@"online_icon_ipad.png";
                offline=@"offline_icon_ipad.png";
            }
            else{
                online=@"online_icon.png";
                offline=@"offline_icon.png";
            }
            
       if ([isOnline[indexPath.row] isEqualToNumber:[NSNumber numberWithInt:0]]) {
           customCellView.isOnlne.image=[UIImage imageNamed:offline];
       }
       else{
           customCellView.isOnlne.image=[UIImage imageNamed:online];
         
       }
    NSString *totalCount= [NSString stringWithFormat:@"%d",(int)indexPath.row];
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
            };
    
    //customCellView.customImageCounterView.totalImageCountLabel.text = [SingletonClass shareSingleton].imgCount[indexPath.row];
       customCellView.customImageCounterView.totalImageCountLabel.text = imgCount[indexPath.row];
        
   }
   // }
      /*  else
        {
            customCellView.customImageCounterView.hidden=NO;
            customCellView.profileImageView.image = [UIImage imageNamed:[viewerImage objectAtIndex:indexPath.row]];
            customCellView.nameLabel.text =[viewerName objectAtIndex:indexPath.row];
            if ([[SingletonClass shareSingleton].isOnline[indexPath.row] isEqualToNumber:[NSNumber numberWithInt:0]]) {
                customCellView.isOnlne.image=[UIImage imageNamed:@"offline_icon.png"];
                //[customCellView.toggleButton setSelected:YES];
                //[customCellView.toggleButton setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
            }
            else{
                customCellView.isOnlne.image=[UIImage imageNamed:@"online_icon.png"];

                //[customCellView.toggleButton setSelected:NO];
                //[customCellView.toggleButton setImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateSelected];
            }
            
            
            NSString *totalCount= [NSString stringWithFormat:@"%d",(int)indexPath.row];
            CGFloat h = 25 + ([totalCount length]*5);
            if (h>70) {
                h = 70;
                customCellView.customImageCounterView.frame = CGRectMake(70-h, 55, h, 16);
                [customCellView.customImageCounterView.totalImageCountLabel sizeToFit];
            }
            else{
                customCellView.customImageCounterView.frame = CGRectMake(70-h, 55, h, 16);
            }
            
            customCellView.customImageCounterView.totalImageCountLabel.text =imgCount[ indexPath.row];
            

        }*/
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        
        customCellView.customImageCounterView.frame = CGRectMake(100, 120, 50, 30);
    }
    }
    //cell.backgroundColor = [UIColor clearColor];
   // [cell addSubview:customCellView];
    return customCellView;
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
            
            //[self createFirstSectionHeader:reuseableView];
        }
        else if(indexPath.section==1){
            reuseableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderViewSectionTwo" forIndexPath:indexPath];
        }
        else{
            reuseableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderViewSectionThree" forIndexPath:indexPath];
        }
        
        
        reuseableView.backgroundColor = [UIColor whiteColor];
        if (indexPath.section==0) {
            //textLabel.frame = CGRectMake(0, 100, self.view.frame.size.width, 25);
            reuseableView.headerTitleLabel.text = @"   Visitors ";
        }
        else if(indexPath.section==1){
            // textLabel.frame = CGRectMake(0, 0, self.view.frame.size.width, 25);
            reuseableView.headerTitleLabel.text = @"   Visitors this week";
        }
        else{
            reuseableView.headerTitleLabel.text = @"   Visitors this month";
        }
        
        return reuseableView;
        
    }//End Header Kind Check
    return nil;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   /* if (indexPath.section==0) {
        if (indexPath.row==0) {
            if (!self.promoteVC) {
                self.promoteVC=[[PromoteyourselfViewController alloc]initWithNibName:@"PromoteyourselfViewController" bundle:nil];
            }
            [self.navigationController pushViewController:self.promoteVC animated:YES];
        }
    }*/
    
   // if ([SingletonClass shareSingleton].superPower==0) {
        return;
   // }
     [SingletonClass shareSingleton].fromChat=NO;
        UserProfileViewController * userDataVC=[[UserProfileViewController alloc]initWithNibName:@"UserProfileViewController" bundle:nil];
        
        userDataVC.index=[viewerID objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:userDataVC animated:YES];
    }



-(void)toggleButtonAction:(id)sender{
    
    NSInteger  tag=[sender tag];
    NSNumber * indexPath=[NSNumber numberWithInteger:tag];
    
    if ([toggleButton isSelected]==YES) {
        
        
        if ([cellSelectedArr containsObject:indexPath]) {
            [cellSelectedArr removeObject:indexPath];
            [toggleButton setImage:[UIImage imageNamed:@"select_normal.png"]forState:UIControlStateSelected];
            [toggleButton setSelected:NO];
        }
        else{
            [toggleButton setImage:[UIImage imageNamed:@"select_active.png"]forState:UIControlStateSelected];
            [toggleButton setSelected:YES];
            [cellSelectedArr addObject:indexPath];
        }
    }
    else{
        
        [toggleButton setImage:[UIImage imageNamed:@"select_active.png"]forState:UIControlStateSelected];
        [toggleButton setSelected:YES];
        [cellSelectedArr addObject:indexPath];
        
        
    }
}

#pragma mark-Web service for delete
-(void)callDeleteWebService{
    NSError *error;
    NSURLResponse * urlResponse;
    NSMutableString * multipleId=[[NSMutableString alloc]init];
    for (int i=0; i<cellSelectedArr.count; i++) {
        
        
        if (i==0) {
            
            [multipleId appendFormat:[NSMutableString stringWithFormat:@"%@",viewerID[i]]];
        }
        else
        {
            [multipleId appendFormat:[NSString stringWithFormat:@",%@",viewerID[i]]];
        }
    }
    NSString * urlStr=[NSString stringWithFormat:@"http://taka.dating/mobile/multideletevisitors/%@/%@",[SingletonClass shareSingleton].userID,multipleId];
    urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url=[NSURL URLWithString:urlStr];
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (data==nil) {
        NSLog(@"No data available");
        return;
    }
    id parse=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@" delete parse of favorite %@",parse);
    if ([[parse objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:198]]) {
        NSLog(@"deletion is not successfull");
    }
    else{
        NSLog(@"deletion is  successfull");
        [self.refreshActivityIndicator startAnimating];
        [self callWebService];
        [self.refreshActivityIndicator stopAnimating];
    }
}

-(void) createFirstSectionHeader:(CollectionHeaderTitleLabel *)areuseableView{
    
    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    backView.backgroundColor = [UIColor blackColor];
    [areuseableView addSubview:backView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(12, 14, 73, 73);
   // button.backgroundColor = [UIColor colorWithRed:(CGFloat)88/255 green:(CGFloat)95/255 blue:(CGFloat)107/255 alpha:1];
    button.titleLabel.numberOfLines = 0;
    button.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
   //[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     [button setBackgroundImage:[UIImage imageNamed:@"add_me_icon.png"] forState:UIControlStateNormal];
    [button setTitle:@"Add me here!" forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:12];
//    button.layer.borderWidth = 5;
//    button.layer.borderColor = [UIColor blueColor].CGColor;
//    button.layer.cornerRadius = 5.0;
//    button.clipsToBounds = YES;
      [button addTarget:self action:@selector(addMeHereButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:button];
    //------------------------------------
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(92, 0, self.view.frame.size.width-92, 100)];
    self.scrollView.backgroundColor = [UIColor blackColor];
    [areuseableView addSubview:self.scrollView];
    [self addHeaderDetails];
}
-(void)addHeaderDetails{
    for (UIView *v in self.scrollView.subviews) {
        v.hidden = YES;
    }
    CGFloat x = 0;
    for (int i = 0; i<self.topCollectionArray.count; i++) {
        
        CustomProfileView *customProfileView = (CustomProfileView*)[self.scrollView viewWithTag:1000+i];
        if (customProfileView==nil) {
            customProfileView = [[CustomProfileView alloc]initWithFrame:CGRectMake(x, 14, 73, 73)];
            customProfileView.tag = 1000+i;
            [self.scrollView addSubview:customProfileView];
        }
        else{
            customProfileView.hidden = NO;
        }
        customProfileView.profileImageView.image = [UIImage imageNamed:@""];
        customProfileView.nameLabel.text = [NSString stringWithFormat:@"%@",[self.topCollectionArray objectAtIndex:i]];
        x = x+76;
    }//End For Loop
    [self.scrollView setContentSize:CGSizeMake(x, 100)];
}
#pragma mark-editButtonAction

-(void)editVisitorsButtonAction{
    editAll=YES;
    [self.mainCollectionView reloadData];
    NSLog(@"edit button clicked in visitors");
}
-(void)cancelButtonAction{
    editAll=NO;
    selectAll=NO;
    [self.mainCollectionView reloadData];
    NSLog(@"Visitors cancel clicked");
}

-(void)selectButtonAction:(id)sender{
    selectAll=YES;
    [self.mainCollectionView reloadData];
    UIActionSheet * actionsheet=[[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"" otherButtonTitles:@"Delete", nil];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        
        [actionsheet showFromRect:[(UIButton *)sender frame] inView:self.view animated:YES ];
        
        
    }
    else{
        [actionsheet showInView:self.view];
    }

    NSLog(@"select Button clicked");
    
}
-(void)deselectButtonAction{
    selectAll=NO;
    
    [self.mainCollectionView reloadData];

    NSLog(@"select Button clicked");
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        NSLog(@"Button action sheet ");
        [self callDeleteWebService];
    }
}
#pragma mark- Web service function for visistors

-(void)callWebService
{
    [viewerID removeAllObjects];
    [viewerImage removeAllObjects];
    [isOnline removeAllObjects];
    [viewerName removeAllObjects];
    [imgCount removeAllObjects];
    NSError * error;
    NSURLResponse * urlRespaonse;
    
    NSString * postUrl=@"http://23.238.24.26/mobi/profile-visitors";
  
    NSMutableDictionary * dict=[[NSMutableDictionary alloc]init];
    [dict setObject:[SingletonClass shareSingleton].userID forKey:@"userId"];
    
    NSURL * url=[NSURL URLWithString:postUrl];
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSString * body=[NSString stringWithFormat:@"userId=%@",[SingletonClass shareSingleton].userID];
    [request setHTTPBody:[body dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlRespaonse error:&error];
    if (data==nil) {
        return;
    }
    id response=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    
        NSLog(@"%@",response);
        if ([[response objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
            
            NSMutableArray * visitorsArr=[response objectForKey:@"visitors"];
            for (int i=0; i<visitorsArr.count; i++) {
                NSMutableDictionary * dict=[visitorsArr objectAtIndex:i];
                [viewerID addObject:[dict objectForKey:@"userId"]];
                NSString * viewerProfilePic=[NSString stringWithFormat:@"http://taka.dating%@",[dict objectForKey:@"thumbanailUrl"]];
                [viewerImage addObject:viewerProfilePic];
                [viewerName addObject:[dict objectForKey:@"displayName"]];
                [isOnline addObject:[dict objectForKey:@"isOnline"]];
                [imgCount addObject:[dict objectForKey:@"imagecount"]];
            }
            NSLog(@"viewer ID %@",[SingletonClass shareSingleton].viewerID);
        }
    if (awardSanction==NO) {
        
    
    if ([SingletonClass shareSingleton].visitorAward==NO &&  viewerID.count>50) {
        NSURL * postUrl=[NSURL URLWithString:@"http://23.238.24.26/award/grant-award/"];
        
        NSMutableURLRequest *  request=[[NSMutableURLRequest alloc]initWithURL:postUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
        [request setHTTPMethod:@"POST"];
        [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        
        NSString * body=[NSString stringWithFormat:@"userId=%@&awardId=%@",[SingletonClass shareSingleton].userID,@"4"];
        
        [request setHTTPBody:[body dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
        
        NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlRespaonse error:&error];
        
        if(data==nil){
            return;
        }
        
        id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"grnated award %@",json);
        awardSanction=YES;
        [SingletonClass shareSingleton].visitorAward=YES;
    }
    }
   }


     
#pragma mark- Add button action
-(void)addMeHereButtonAction:(id)sender{
         if (!self.promoteVC) {
             self.promoteVC=[[PromoteyourselfViewController alloc]initWithNibName:@"PromoteyourselfViewController" bundle:nil];
         }
         [self.navigationController pushViewController:self.promoteVC animated:YES];

    }


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
