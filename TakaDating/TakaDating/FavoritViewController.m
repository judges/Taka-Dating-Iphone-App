//
//  FavoritViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 04/12/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "FavoritViewController.h"
#import "CollectionCellView.h"
#import "PromoteyourselfViewController.h"
#import "CollectionCellView.h"
#import "AddphotosViewController.h"
#import "PeopleNearByViewController.h"
#import "FavoriteCustomCell.h"
#import "SingletonClass.h"
#import "UIImageView+WebCache.h"


@interface FavoritViewController ()

@property(nonatomic,strong)PromoteyourselfViewController *promoteVC;
@property(nonatomic,strong)AddphotosViewController * addPhoto;
@property(nonatomic,strong)PeopleNearByViewController * pnbVC;
@end

@implementation FavoritViewController

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
   
    windowSize=[UIScreen mainScreen].bounds.size;
    isProfilePic=YES;//if yes display all details, else display add phot button
    self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    if (cellSelectedArr ) {
        cellSelectedArr=nil;
    }
    cellSelectedArr=[[NSMutableArray alloc]init];

    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(editVisitorsButtonAction) name:@"editFavoriteButtonAction" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cancelButtonAction) name:@"cancelFavoriteButtonAction" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectFavoriteButtonAction:) name:@"selectFavoriteButtonAction" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deselectButtonAction) name:@"deselectFavoriteButtonAction" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(creatUI) name:@"FavouriteUI" object:nil];
    
    
    self.refreshActivityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(140, 150, 40, 40)];
    
    self.refreshActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    
    self.refreshActivityIndicator.color = [UIColor blackColor];
    
    [self.view addSubview:self.refreshActivityIndicator];
    [self.view bringSubviewToFront:self.refreshActivityIndicator];
    self.refreshActivityIndicator.alpha = 1.0;
    
    useriId =[[NSMutableArray alloc]init];
    displayName=[[NSMutableArray alloc]init];
    imageCount=[[NSMutableArray alloc]init];
    sex=[[NSMutableArray alloc]init];
    thumbanailUrl=[[NSMutableArray alloc]init];
    isOnline=[[NSMutableArray alloc]init];
    
    useriIdUser =[[NSMutableArray alloc]init];
    displayNameUser=[[NSMutableArray alloc]init];
    imageCountUser=[[NSMutableArray alloc]init];
    sexUser=[[NSMutableArray alloc]init];
    thumbanailUrlUser=[[NSMutableArray alloc]init];
    isOnlineUser=[[NSMutableArray alloc]init];
    
    
    //[self createCollectionView];
    // Do any additional setup after loading the view from its nib.
}

-(void)creatUI{
    [self.refreshActivityIndicator startAnimating];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [self callWebServicesForFavorite];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.refreshActivityIndicator stopAnimating];
            
            [self createCollectionView];
        });
    });
    

    
}

#pragma  mark- createUI
#pragma mark-

-(void) createCollectionView{
    self.topCollectionArray = @[@"Abc",@"Bcd",@"Cde",@"Def",@"Efg"];
    //---------
    UICollectionViewFlowLayout *flowLayOut= [[UICollectionViewFlowLayout alloc] init];
    flowLayOut.minimumInteritemSpacing = (CGFloat)2.0;
    flowLayOut.minimumLineSpacing = (CGFloat)2.0;
    flowLayOut.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.bounds.size.height) collectionViewLayout:flowLayOut];
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
    [self.mainCollectionView registerClass:[CollectionHeaderTitleLabel class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderViewSectionThree"];
    // [self.mainCollectionView registerClass:[CollectionHeaderTitleLabel class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderViewSectionFour"];
    
    //-------------------------------------------
}
#pragma mark-
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==1) {
        if (isProfilePic==NO) {
            return 0;
        }
        else if (thumbanailUrlUser.count>0){
            return thumbanailUrlUser.count;
        }
    }
    if (section==0) {
        if (isProfilePic==NO) {
            return 0;
        }
       else if (thumbanailUrl.count>0) {
            return  thumbanailUrl.count;
        }
    }
    return 0;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"CustomCollectionCell" forIndexPath:indexPath];
  
     //UICollectionViewCell * cell=[collectionView cellForItemAtIndexPath:indexPath];
  CollectionCellView * customCellView=[[CollectionCellView alloc] initWithFrame:cell.bounds];
    
    isProfilePic=YES;
         if(indexPath.section==0)
         {
             if (thumbanailUrl.count>0) {
                 
            
             if (isProfilePic!=NO) {
        
              
            if(editAll==YES)
            {
                toggleButton=[UIButton buttonWithType:UIButtonTypeCustom];
                toggleButton.frame=CGRectMake(60,5, 15, 15);
                [toggleButton setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
                [toggleButton setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
                [customCellView addSubview:toggleButton];
                
                
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
           
            if ([[isOnline objectAtIndex:indexPath.row]isEqualToString:@"1"]) {
                customCellView.isOnlne.image=[UIImage imageNamed:@"online_icon.png"];
            }
            else{
                customCellView.isOnlne.image=[UIImage imageNamed:@"offline_icon.png"];
            }
            customCellView.customImageCounterView.hidden=NO;
            NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"http://taka.dating/%@",[thumbanailUrl objectAtIndex:indexPath.row]]];
            [customCellView.profileImageView setImageWithURL:url] ;
            customCellView.nameLabel.text =[displayName objectAtIndex:indexPath.row] ;
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
            
            customCellView.customImageCounterView.totalImageCountLabel.text = [imageCount objectAtIndex:indexPath.row];
            
        }
        }
          //   }
        cell.backgroundColor = [UIColor clearColor];
        [cell addSubview:customCellView];

    }
    
    if (indexPath.section==1) {
        if (thumbanailUrlUser.count>0) {
            
                   if ([[isOnlineUser objectAtIndex:indexPath.row]isEqualToString:@"1"]) {
                customCellView.isOnlne.image=[UIImage imageNamed:@"online_icon.png"];
            }
            else{
                customCellView.isOnlne.image=[UIImage imageNamed:@"offline_icon.png"];
            }
            customCellView.customImageCounterView.hidden=NO;
            NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"http://taka.dating/%@",[thumbanailUrlUser objectAtIndex:indexPath.row]]];
            [customCellView.profileImageView setImageWithURL:url] ;
            customCellView.nameLabel.text =[displayNameUser objectAtIndex:indexPath.row] ;
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
            
            customCellView.customImageCounterView.totalImageCountLabel.text = [imageCountUser objectAtIndex:indexPath.row];

        }
        cell.backgroundColor = [UIColor clearColor];
        [cell addSubview:customCellView];
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        if (thumbanailUrlUser.count>0) {
            return CGSizeMake(73, 73);
        }
        else{
            return CGSizeMake(0, 0);
        }
        
    }
    else if (indexPath.section==0)
    {
        if (thumbanailUrl.count>0) {
            return CGSizeMake(73, 73);
        }
        else{
            return CGSizeMake(0, 0);
        }
    }

    return CGSizeMake(0,0);

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size;
   /* if (section==0) {
         if (isProfilePic==YES) {
        size = CGSizeMake(self.view.frame.size.width, 180);
             return size;
         }
        
   }
    else if (section==1)
    {
       if (isProfilePic==NO) {
        size = CGSizeMake(self.view.frame.size.width, 180);
        return size;
       }
    }
    else if (section==2)
    {
        if (isProfilePic==NO) {
           size = CGSizeMake(self.view.frame.size.width, 25);
            return size;
            
        }
    }
    else if(section==3){
        if (isProfilePic==YES) {
             size = CGSizeMake(self.view.frame.size.width, 180);
            return size;
            
        }
    }*/
    if (section==0) {
        if (isProfilePic==NO) {
            size = CGSizeMake(self.view.frame.size.width, 180);
            return size;

        }
    }
   else if (section==1) {
        if (isProfilePic==YES) {
        size = CGSizeMake(self.view.frame.size.width, 180);
        return size;
        }

    }
    else  if(section==2)
    {
        if (isProfilePic==YES) {
            size = CGSizeMake(self.view.frame.size.width, 180);
            return size;
        }
    }
        size = CGSizeMake(self.view.frame.size.width, 25);
        return size;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionHeader){
        
        reuseableView = nil;
        
        if (indexPath.section==0) {
            reuseableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
            //if (thumbanailUrl.count<1) {
           //     [self createFirstSectionHeader:reuseableView];
           // }
            if (thumbanailUrlUser.count<1) {
                [self createSecondSectionHeader:reuseableView];
            }
            
            
            
        }
        else if(indexPath.section==0){
            reuseableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderViewSectionTwo" forIndexPath:indexPath];
            if (thumbanailUrlUser.count<1) {
                 [self createSecondSectionHeader:reuseableView];
            }
           
        }
        else if(indexPath.section==1){
           reuseableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderViewSectionThree" forIndexPath:indexPath];
          [self  createThirdSectionHeader:reuseableView];
        }
       /* else{
              reuseableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderViewSectionFour" forIndexPath:indexPath];
            [self  createFourSectionHeader:reuseableView];
        }*/
        
        
        reuseableView.backgroundColor = [UIColor blackColor];
        if (indexPath.section==0) {
            //textLabel.frame = CGRectMake(0, 100, self.view.frame.size.width, 25);
            reuseableView.headerTitleLabel.text = @"   Added you as a Favorite";
        }
        else if(indexPath.section==1){
            // textLabel.frame = CGRectMake(0, 0, self.view.frame.size.width, 25);
            reuseableView.headerTitleLabel.text = @"   Favorites";
        }
        else if(indexPath.section==2){
            if (isProfilePic==NO) {
                reuseableView.headerTitleLabel.hidden=YES;
            }
           // reuseableView.headerTitleLabel.text = @"   Friends";
        }
        else{
            reuseableView.headerTitleLabel.hidden=YES;
        }
        
        return reuseableView;
        
    }//End Header Kind Check
    return nil;
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

/*-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section==0) {
        
        if (!cellSelectedArr) {
            cellSelectedArr=[[NSMutableArray alloc]init];
        }
        CollectionCellView * customCellView=(CollectionCellView*)[collectionView cellForItemAtIndexPath:indexPath];

        
    if (editAll==YES) {
       
        
        if ([cellSelectedArr containsObject:indexPath]) {
             [customCellView.togglebutton setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal]  ;
            [cellSelectedArr removeObject:indexPath];
            [customCellView.togglebutton addTarget:self action:@selector(toggleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        }
    
        else{
            
            
            [customCellView.togglebutton setImage:[UIImage imageNamed:@"select_active.png"]   forState:UIControlStateSelected];
            [customCellView.togglebutton setSelected:YES];
            [cellSelectedArr addObject:indexPath];
        }
    }
    }if (indexPath.section==1) {
        
    }
    

   
    
}*/


#pragma  mark- Section header
-(void)createSecondSectionHeader:(CollectionHeaderTitleLabel *)areuseableView{
    
    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 150)];
    backView.backgroundColor = [UIColor clearColor];
    [areuseableView addSubview:backView];
  
    
    if (isProfilePic==NO ) {
        if (!self.secaddPhotoButton) {
            
            self.secaddPhotoButton=[[UIButton alloc]initWithFrame:CGRectMake(60, 120, 167 , 32)];
            [self.secaddPhotoButton setTitle:@"Add photos" forState:UIControlStateNormal];
            [self.secaddPhotoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.secaddPhotoButton setBackgroundImage:[UIImage imageNamed:@"setting_btn_bg.png"] forState:UIControlStateNormal];
            self.secaddPhotoButton.layer.cornerRadius=4;
            self.secaddPhotoButton.clipsToBounds=YES;
            [self.secaddPhotoButton addTarget:self action:@selector(addPhotoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:self.secaddPhotoButton];
        }
        self.secaddPhotoButton.hidden=NO;
        if (!self.secTopLabel) {
            self.secTopLabel=[[UILabel alloc]init];
            self.secTopLabel.frame=CGRectMake(40, 80, 240, 30);
            self.secTopLabel.textColor=[UIColor whiteColor];
            self.secTopLabel.font=[UIFont systemFontOfSize:12];
            self.secTopLabel.textAlignment=NSTextAlignmentCenter;
            self.secTopLabel.lineBreakMode=NSLineBreakByCharWrapping;
            self.secTopLabel.numberOfLines=0;
            self.secTopLabel.text=@"No one has added you as a Favorite because you don't have a photo.";
            [backView addSubview:self.secTopLabel];
            
        }
        self.secTopLabel.hidden=NO;
        //if (!self.imgView) {
            self.imgView=[[UIImageView alloc]init];
            self.imgView.frame=CGRectMake(self.view.frame.size.width/2-30, 40, 40, 40);
            self.imgView.image=[UIImage imageNamed:@"photo_icon_grey.png"];
            [backView addSubview:self.imgView];
       // }
    }
    else{
      // if (!self.promoteButton) {
           self.promoteButton.hidden=NO;
           self.promoteButton=[[UIButton alloc]initWithFrame:CGRectMake(60, 120, 167 , 32)];
           [self.promoteButton setTitle:@"Promote yourself" forState:UIControlStateNormal];
           [self.promoteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

       
        [self.promoteButton setBackgroundImage:[UIImage imageNamed:@"setting_btn_bg.png"] forState:UIControlStateNormal];
           [self.promoteButton addTarget:self action:@selector(addMeHereButtonAction:) forControlEvents:UIControlEventTouchUpInside];
           [backView addSubview:self.promoteButton];
    //}
    //    self.promoteButton.hidden=NO;
   
    if (!self.toplabel) {
        self.toplabel=[[UILabel alloc]init];
        self.toplabel.frame=CGRectMake(40, 80, 240, 30);
        self.toplabel.textColor=[UIColor whiteColor];
        self.toplabel.font=[UIFont systemFontOfSize:12];
        self.toplabel.textAlignment=NSTextAlignmentCenter;
        self.toplabel.lineBreakMode=NSLineBreakByCharWrapping;
        self.toplabel.numberOfLines=0;
        self.toplabel.text=@"No one has added you as a Favorite yet. Promote yourself to attract more attention:";
        [backView addSubview:self.toplabel];

    }
    self.toplabel.hidden=NO;
        for (int i=0; i<4; i++) {
            self.imgView=[[UIImageView alloc]init];
            self.imgView.frame=CGRectMake(30+(i*60), 30, 40, 40);
            self.imgView.image=[UIImage imageNamed:@"photo_icon_grey.png"];
            [backView addSubview:self.imgView];
        }
        
    }
}

-(void) createFirstSectionHeader:(CollectionHeaderTitleLabel *)areuseableView{
    
    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    backView.backgroundColor = [UIColor blackColor];
    [areuseableView addSubview:backView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(12, 14, 73, 73);
    button.titleLabel.numberOfLines = 0;
    button.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"add_me_icon.png"] forState:UIControlStateNormal];
    [button setTitle:@"Add me here!" forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:12];
    [button addTarget:self action:@selector(addMeHereButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:button];
    //------------------------------------
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(92, 0, self.view.frame.size.width-92, 100)];
    self.scrollView.backgroundColor = [UIColor blackColor];
    [areuseableView addSubview:self.scrollView];
    [self addHeaderDetails];
}

-(void)createThirdSectionHeader:(CollectionHeaderTitleLabel *)areuseableView{
    
    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 150)];
    backView.backgroundColor = [UIColor blackColor];
    [areuseableView addSubview:backView];

    
    if (isProfilePic==YES) {
        if (!self.addPhotoButton) {
            
            self.addPhotoButton=[[UIButton alloc]initWithFrame:CGRectMake(60, 120, 240, 30)];
            [self.addPhotoButton setTitle:@"Add photos" forState:UIControlStateNormal];
            [self.addPhotoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.addPhotoButton setBackgroundImage:[UIImage imageNamed:@"setting_btn_bg.png"] forState:UIControlStateNormal];
            [self.addPhotoButton addTarget:self action:@selector(addPhotoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:self.addPhotoButton];
        }
        self.addPhotoButton.hidden=NO;
        if (!self.toplabel) {
            self.toplabel=[[UILabel alloc]init];
            self.toplabel.frame=CGRectMake(40, 80, 240, 30);
            self.toplabel.textColor=[UIColor whiteColor];
            self.toplabel.font=[UIFont systemFontOfSize:12];
            self.toplabel.textAlignment=NSTextAlignmentCenter;
            self.toplabel.lineBreakMode=NSLineBreakByCharWrapping;
            self.toplabel.numberOfLines=0;
            self.toplabel.text=@"You can't see Favorites if you don't have you profile pic.";
            [backView addSubview:self.toplabel];
            
        }
        self.toplabel.hidden=NO;
        if (!self.imgView) {
            self.imgView=[[UIImageView alloc]init];
            self.imgView.frame=CGRectMake(self.view.frame.size.width/2-20, 40, 40, 40);
            self.imgView.image=[UIImage imageNamed:@"photo_icon_grey.png"];
            [backView addSubview:self.imgView];
        }
    }
    
}

-(void)createFourSectionHeader:(CollectionHeaderTitleLabel *)areuseableView{
    
    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 150)];
    backView.backgroundColor = [UIColor clearColor];
    [areuseableView addSubview:backView];
    
    
    if (isProfilePic!=NO) {
        
            
            self.findFirends=[[UIButton alloc]initWithFrame:CGRectMake(60, 120, 167, 32)];
            [self.findFirends setTitle:@"Find firends" forState:UIControlStateNormal];
            [self.findFirends setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.findFirends setBackgroundImage:[UIImage imageNamed:@"setting_btn_bg.png"] forState:UIControlStateNormal];
            [self.findFirends addTarget:self action:@selector(findFriendsButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:self.findFirends];
       
       
        if (!self.thirdTopLabel) {
            self.thirdTopLabel=[[UILabel alloc]init];
            self.thirdTopLabel.frame=CGRectMake(40, 80, 240, 30);
            self.thirdTopLabel.textColor=[UIColor whiteColor];
            self.thirdTopLabel.font=[UIFont systemFontOfSize:12];
            self.thirdTopLabel.textAlignment=NSTextAlignmentCenter;
            self.thirdTopLabel.lineBreakMode=NSLineBreakByCharWrapping;
            self.thirdTopLabel.numberOfLines=0;
            self.thirdTopLabel.text=@"Find People you know who are on Tkaka Dating or invite them to join:";
            [backView addSubview:self.thirdTopLabel];
            
        }
        self.thirdTopLabel.hidden=NO;
        //if (!self.imgView) {
            self.imgView=[[UIImageView alloc]init];
            self.imgView.frame=CGRectMake(self.view.frame.size.width/2-20, 40, 40, 40);
            self.imgView.image=[UIImage imageNamed:@"photo_icon_grey.png"];
            [backView addSubview:self.imgView];
       // }
    }
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
#pragma mark- Add button action
-(void)addMeHereButtonAction:(id)sender{
    if (!self.promoteVC) {
        self.promoteVC=[[PromoteyourselfViewController alloc]initWithNibName:@"PromoteyourselfViewController" bundle:nil];
    }
    [self.navigationController pushViewController:self.promoteVC animated:YES];
    
}
#pragma mark- find friends
-(void)findFriendsButtonAction:(id)sender{
    NSLog(@"Find Friends button clicked");
}

#pragma mark-add Photo

-(void)addPhotoButtonAction:(id)sender{
    if (!self.addPhoto) {
        self.addPhoto=[[AddphotosViewController alloc]initWithNibName:@"AddphotosViewController" bundle:nil];
    }
    [self.navigationController pushViewController:self.addPhoto animated:YES];
}

-(void)editVisitorsButtonAction{
    NSLog(@"edit button clicked in visitors");
    editAll=YES;
    [self.mainCollectionView reloadData];
//    UICollectionViewCell * cell=[self.mainCollectionView dequeueReusableCellWithReuseIdentifier:@"coCell" forIndexPath:<#(NSIndexPath *)#>]
}
-(void)cancelButtonAction{
    editAll=NO;
    selectAll=NO;
    [self.mainCollectionView reloadData];
    NSLog(@"Visitors cancel clicked");
}

-(void)selectFavoriteButtonAction:(id)sender{
    selectAll=YES;
    [self.mainCollectionView reloadData];
    UIActionSheet * actionsheet=[[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"" otherButtonTitles:@"Delete", nil];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        
        [actionsheet showFromRect:[(UIButton *)sender frame] inView:self.view animated:YES ];
        
        
    }
    else{
        [actionsheet showInView:self.view];
    }
    NSLog(@"select collection Button clicked");
    
}
-(void)deselectButtonAction{
    selectAll=NO;
    [self.mainCollectionView reloadData];
    NSLog(@"deselect Button clicked");
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        NSLog(@"Button action sheet ");
        [self callDeleteWebService];
    }
}

#pragma mark-Web service for delete
-(void)callDeleteWebService{
    NSError *error;
    NSURLResponse * urlResponse;
    NSMutableString * multipleId=[[NSMutableString alloc]init];
    for (int i=0; i<cellSelectedArr.count; i++) {
        
    
    if (i==0) {
        
        [multipleId appendFormat:[NSMutableString stringWithFormat:@"%@",useriId[i]]];
    }
        else
        {
            [multipleId appendFormat:[NSString stringWithFormat:@",%@",useriId[i]]];
        }
    }
    NSString * urlStr=[NSString stringWithFormat:@"http://taka.dating/mobile/multideletefav/%@/%@",[SingletonClass shareSingleton].userID,multipleId];
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
        [self callWebServicesForFavorite];
        [self.refreshActivityIndicator stopAnimating];
    }
}

#pragma mark- web service for favourite
-(void)callWebServicesForFavorite{
    
    [useriId removeAllObjects];
    [thumbanailUrl removeAllObjects];
    [isOnline removeAllObjects];
    [displayName removeAllObjects];
    [imageCount removeAllObjects];
    [useriIdUser removeAllObjects];
    [thumbanailUrlUser removeAllObjects];
    [isOnlineUser removeAllObjects];
    [displayNameUser removeAllObjects];
    [imageCountUser removeAllObjects];
    NSError * error;
    NSURLResponse * urlResponse;
    
    /*NSString * urlStr=[NSString stringWithFormat:@"http://takadating.com/mobile/favorites/%@",[SingletonClass shareSingleton].userID];
    urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];*/
    
    NSURL * url=[NSURL URLWithString:@"http://23.238.24.26/mobi/favourites"];
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    
    [request setHTTPMethod:@"POST"];
    
    
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSString * body=[NSString stringWithFormat:@"userId=%@",[SingletonClass shareSingleton].userID];
    [request setHTTPBody:[body dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (data==nil) {
        return;
    }
    id parse=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    NSLog(@"Favorite %@",parse);
    if ([[parse objectForKey:@"code"]isEqualToNumber:[NSNumber numberWithInt:200]]) {
        NSArray * favOfUsers=[parse objectForKey:@"favOfUsers"];
        NSMutableDictionary * dict=[[NSMutableDictionary alloc]init];
        for (int i=0; i<favOfUsers.count; i++) {
            dict=[favOfUsers objectAtIndex:i];
            [useriId addObject:[dict objectForKey:@"userId"]];
            [thumbanailUrl addObject:[dict objectForKey:@"thumbanailUrl"]];
            [isOnline addObject:[dict objectForKey:@"isOnline"]];
            [displayName addObject:[dict objectForKey:@"displayName"]];
            [imageCount addObject:[dict objectForKey:@"imagecount"]];
        }
        NSArray * myfavorites=[parse objectForKey:@"myfavorites"];
         NSMutableDictionary * dict1=[[NSMutableDictionary alloc]init];
        for (int i=0; i<myfavorites.count; i++) {
            dict1=[myfavorites objectAtIndex:i];
            [useriIdUser addObject:[dict1 objectForKey:@"userId"]];
            [thumbanailUrlUser addObject:[dict1 objectForKey:@"thumbanailUrl"]];
            [isOnlineUser addObject:[dict1 objectForKey:@"isOnline"]];
            [displayNameUser addObject:[dict1 objectForKey:@"displayName"]];
            [imageCountUser addObject:[dict1 objectForKey:@"imagecount"]];
        }
    }
   // [[NSNotificationCenter defaultCenter]removeObserver:self name:@"FavouriteUI" object:nil];
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
