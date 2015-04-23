//
//  PhotoViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 05/12/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "PhotoViewController.h"
#import "PhotoCollectionView.h"
#import "PhotoReusableCollection.h"
#import "AddphotosViewController.h"
#import "SingletonClass.h"
#import "UIImageView+WebCache.h"

@interface PhotoViewController ()
{
 PhotoReusableCollection *reuseableView;
}
@property(nonatomic,strong)AddphotosViewController *addPhoto;
@end

@implementation PhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
    
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
//        if (!frame) {
//            return nil;
//        }
        
        [SingletonClass shareSingleton].frame = frame;
        
    }
    return self;
}


- (void)viewDidLoad
{
    
    //[NSThread detachNewThreadSelector:@selector(divideImagesOnBasisPrivacy) toTarget:self withObject:nil];
   
    self.view.frame=[SingletonClass shareSingleton].frame;
    NSLog(@"view frame %f",self.view.frame.size.height-268);
    [super viewDidLoad];
   // self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    
    self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)148/255 blue:(CGFloat)214/255 alpha:1.0];
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        x=140;
        y=140;
        header_hh=50;
    }
    else{
        x=73;
        y=73;
        header_hh=25;
    }
    
    self.refreshActivityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(140, 150, 40, 40)];
    
    self.refreshActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    
    self.refreshActivityIndicator.color = [UIColor blackColor];
    
    [self.view addSubview:self.refreshActivityIndicator];
    self.refreshActivityIndicator.alpha = 1.0;
    [self.refreshActivityIndicator startAnimating];
    
    dispatch_async(dispatch_get_global_queue(0, 0),^{
        [self divideImagesOnBasisPrivacy];
        dispatch_async(dispatch_get_main_queue(),^{
            [self.refreshActivityIndicator stopAnimating];
            [self createCollectionView];
        });
    });
    
    
    // Do any additional setup after loading the view from its nib.
}

#pragma mark-

-(void) createCollectionView{
    
    
    self.topCollectionArray = @[@"Abc",@"Bcd",@"Cde",@"Def",@"Efg"];
    //---------
   
    UICollectionViewFlowLayout *flowLayOut= [[UICollectionViewFlowLayout alloc] init];
   
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        self.mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-80) collectionViewLayout:flowLayOut];
        flowLayOut.minimumInteritemSpacing = (CGFloat)2.0;
        flowLayOut.minimumLineSpacing = (CGFloat)2.0;
        flowLayOut.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    else{
        self.mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowLayOut];
        flowLayOut.minimumInteritemSpacing = (CGFloat)2.0;
        flowLayOut.minimumLineSpacing = (CGFloat)2.0;
        flowLayOut.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    
    self.mainCollectionView.collectionViewLayout=flowLayOut;
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
    [self.mainCollectionView registerClass:[PhotoReusableCollection class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [self.mainCollectionView registerClass:[PhotoReusableCollection class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderViewSectionTwo"];
    [self.mainCollectionView registerClass:[PhotoReusableCollection class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderViewSectionThree"];
     [self.mainCollectionView registerClass:[PhotoReusableCollection class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderViewSectionFour"];
    
    //-------------------------------------------
}
#pragma mark-
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==3) {
        return 0;
    }
    else if (section==0)
    {
        if (privacyTwoPic.count<1) {
            return 1;
        }
        else{
            return privacyTwoPic.count+1;
        }
    }
    else if (section==1)
    {
        if (privacyZeroPic.count<1) {
            return 1;
        }
        else{
            return privacyZeroPic.count+1;
        }
    }
    else{
        if (privacyTwoPic.count<1) {
            return 1;
        }
        else{
            return privacyOnePic.count+1;
        }
    }
   
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"CustomCollectionCell" forIndexPath:indexPath];
     PhotoCollectionView *customCellView = [[PhotoCollectionView alloc] initWithFrame:cell.bounds];
    //NSString *name = @"";
   /* if (indexPath.row==0) {
        customCellView.profileImageView.image = [UIImage imageNamed:@"profile_pic_bg.png"];
       
    }
    else{
    
   
    customCellView.profileImageView.image = [UIImage imageNamed:name];
    }*/
    NSURL * url;
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            customCellView.profileImageView.image = [UIImage imageNamed:@"profile_pic_bg.png"];
        }
        else{
             if (privacyTwoPic.count>0) {
                url=[NSURL URLWithString:[NSString stringWithString:[privacyTwoPic objectAtIndex:indexPath.row-1]]];
                [customCellView.profileImageView setImageWithURL:url];
             }
        }
    }
    else if (indexPath.section==1)
    {
        if (indexPath.row==0) {
            customCellView.profileImageView.image = [UIImage imageNamed:@"profile_pic_bg.png"];
        }
        else{
        if (privacyZeroPic.count>0) {
            url=[NSURL URLWithString:[NSString stringWithString:[privacyZeroPic objectAtIndex:indexPath.row-1]]];
            [customCellView.profileImageView setImageWithURL:url];
        }
        }
    }
    else{
        if (indexPath.row==0) {
           customCellView.profileImageView.image = [UIImage imageNamed:@"profile_pic_bg.png"];
        }
        else{
              if (privacyOnePic.count>0) {
                url=[NSURL URLWithString:[NSString stringWithString:[privacyOnePic objectAtIndex:indexPath.row-1]]];
                [customCellView.profileImageView setImageWithURL:url];
              }
            
        }

    }
    cell.backgroundColor = [UIColor clearColor];
    [cell addSubview:customCellView];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==3) {
        return CGSizeMake(0, 0);
    }
    return CGSizeMake(x, y);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        CGSize size = CGSizeMake(self.view.frame.size.width, 25);
        return size;
    }if (section==3) {
        CGSize size = CGSizeMake(self.view.frame.size.width, 150);
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
        else if(indexPath.section==2){
            reuseableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderViewSectionThree" forIndexPath:indexPath];
        }
        else{
            reuseableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderViewSectionFour" forIndexPath:indexPath];
        }
        
        
       // reuseableView.backgroundColor = [UIColor clearColor];
        if (indexPath.section==0) {
            //textLabel.frame = CGRectMake(0, 100, self.view.frame.size.width, 25);
            reuseableView.headerTitleLabel.text = @"   Photos";
        }
        else if(indexPath.section==1){
            // textLabel.frame = CGRectMake(0, 0, self.view.frame.size.width, 25);
            reuseableView.headerTitleLabel.text = @"   Other photos";
        }
        else if(indexPath.section==2){
            reuseableView.headerTitleLabel.text = @"   Private photos";
        }
        else{
            reuseableView.headerTitleLabel.hidden=YES;
            [self createHeadrView:reuseableView];
        }
        
        return reuseableView;
        
    }//End Header Kind Check
    return nil;
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        if (!self.addPhoto) {
            self.addPhoto=[[AddphotosViewController alloc]initWithNibName:@"AddphotosViewController" bundle:nil];
        }
        [self.navigationController pushViewController:self.addPhoto animated:YES];
    }
    else{
        if (indexPath.section==0) {
            profilePicPath= [privacyTwoPic objectAtIndex:indexPath.row-1];
        }
        else if (indexPath.section==1)
        {
          profilePicPath= [privacyZeroPic objectAtIndex:indexPath.row-1];
        }
        else
        {
          profilePicPath=[privacyOnePic objectAtIndex:indexPath.row-1];
        }
        actionSheet =[[UIActionSheet alloc]initWithTitle:@"Set as profile pic" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"OK", nil];
        [actionSheet showFromRect:CGRectMake(windowSize.width/2-40, windowSize.height/2, 200, 100) inView:self.view animated:YES];
        
    }
}

#pragma mark-divideImagesOnBasisPrivacy

-(void)divideImagesOnBasisPrivacy{
    privacyOnePic =[[NSMutableArray alloc]init];
    privacyZeroPic=[[NSMutableArray alloc]init];
    privacyTwoPic=[[NSMutableArray alloc]init];
     NSString * imageUrl;
    for (int s=0; s<[SingletonClass shareSingleton].profileImages.count; s++) {
        NSMutableDictionary * dict=[[SingletonClass shareSingleton].profileImages objectAtIndex:s];
        if ([[dict objectForKey:@"privacy"]isEqualToString:@"0"]||[[dict objectForKey:@"privacy"]isEqualToString:@"3"]) {
           
            if ([[dict objectForKey:@"privacy"]isEqualToString:@"3"]) {
                imageUrl=[NSString stringWithString:[dict objectForKey:@"imageLink"]];
            }
            else{
                imageUrl=[NSString stringWithFormat:@"http://taka.dating/%@",[dict objectForKey:@"imageLink"]];
            }
            [privacyZeroPic addObject:imageUrl];
        }
        else if ([[dict objectForKey:@"privacy"]isEqualToString:@"1"]){
             imageUrl=[NSString stringWithFormat:@"http://taka.dating/%@",[dict objectForKey:@"imageLink"]];
            [privacyOnePic addObject:imageUrl];
        }
        else if([[dict objectForKey:@"privacy"]isEqualToString:@"2"]) {
             imageUrl=[NSString stringWithFormat:@"http://taka.dating/%@",[dict objectForKey:@"imageLink"]];
            [privacyTwoPic addObject:imageUrl];
        }
    }
}

#pragma  mark- actionsheet delegate methods
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
       //SET PROFILE PIC
        NSError * error;
        NSURLResponse * urlResponse;
        
        NSURL * postUrl=[NSURL URLWithString:@"http://23.238.24.26/mobile-app/set-profile-pic"];
        
        NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:postUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
        [request setHTTPMethod:@"POST"];
        [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        NSString * body=[NSString stringWithFormat:@"userid=%@&propicurl=%@&imageId=0",[SingletonClass shareSingleton].userID,profilePicPath];
        
        [request setHTTPBody:[body dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
        
        NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
        
        if (data==nil) {
            return;
        }
        id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"%@",json);
        if ([[json objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
            [SingletonClass shareSingleton].profileImg=profilePicPath;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"setProfilePic" object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter]removeObserver:self name:@"setProfilePic" object:nil];
        }
        else
        {
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:@"Image is not uploaded" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            
        }
    }
}

#pragma mark- Header View for section four

-(void)createHeadrView:(UICollectionReusableView *)reusable{
    UIButton * facebookBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    facebookBtn.frame=CGRectMake(0, 10, self.view.frame.size.width, 40);
   // [facebookBtn setTitle:@"Add from facebook" forState:UIControlStateNormal];
    //facebookBtn.backgroundColor=[UIColor blueColor];
    [facebookBtn setBackgroundImage:[UIImage imageNamed:@"fb_btn_white.png"] forState:UIControlStateNormal];
    facebookBtn.layer.borderColor=[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0].CGColor;
    facebookBtn.layer.borderWidth=0.3;
    [reuseableView addSubview:facebookBtn];
    
    UIButton * instagramBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    instagramBtn.frame=CGRectMake(0, 50, self.view.frame.size.width, 40);
   // [instagramBtn setTitle:@"Add from instagram" forState:UIControlStateNormal];
  //  instagramBtn.backgroundColor=[UIColor blueColor];
    [instagramBtn setBackgroundImage:[UIImage imageNamed:@"instragram_btn.png"] forState:UIControlStateNormal];
    instagramBtn.layer.borderColor=[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0].CGColor;
    instagramBtn.layer.borderWidth=0.3;
    [reuseableView addSubview:instagramBtn];
    
    UIButton * existingBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    existingBtn.frame=CGRectMake(0, 88, self.view.frame.size.width, 40);
    //[existingBtn setTitle:@"Add from existing photos" forState:UIControlStateNormal];
    //existingBtn.backgroundColor=[UIColor blueColor];
    [existingBtn setBackgroundImage:[UIImage imageNamed:@"gallery_btn.png"] forState:UIControlStateNormal];
    existingBtn.layer.borderColor=[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0].CGColor;
    existingBtn.layer.borderWidth=0.3;
    [reuseableView addSubview:existingBtn];
    
    UIButton * takePhotoBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    takePhotoBtn.frame=CGRectMake(0, 125, self.view.frame.size.width, 40);
    //[takePhotoBtn setTitle:@"Take a new  photo " forState:UIControlStateNormal];
   //takePhotoBtn.titleLabel.textColor=[UIColor blackColor];
  // takePhotoBtn.backgroundColor=[UIColor blueColor];
    [takePhotoBtn setBackgroundImage:[UIImage imageNamed:@"camera_btn.png"] forState:UIControlStateNormal];
    takePhotoBtn.layer.borderColor=[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0].CGColor;
    takePhotoBtn.layer.borderWidth=0.3;
    [reuseableView addSubview:takePhotoBtn];
}



/*
-(void) createFirstSectionHeader:(CollectionHeaderTitleLabel *)areuseableView{
    
    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
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
        customProfileView.profileImageView.image = [UIImage imageNamed:@"dwc.png"];
        customProfileView.nameLabel.text = [NSString stringWithFormat:@"%@",[self.topCollectionArray objectAtIndex:i]];
        x = x+76;
    }//End For Loop
    [self.scrollView setContentSize:CGSizeMake(x, 100)];
}*/
#pragma mark-


#pragma mark- Add button action
/*
-(void)addMeHereButtonAction:(id)sender{
    if (promote) {
        promote=nil;
    }
    promote=[[PromoteyourselfViewController alloc]initWithNibName:@"PromoteyourselfViewController" bundle:nil];
    [self.navigationController pushViewController:promote animated:YES];
}

*/


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
