//
//  PromoteyourselfViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 30/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "PromoteyourselfViewController.h"
#import "SingletonClass.h"
#import "UIImageView+WebCache.h"

@interface PromoteyourselfViewController ()
{
    CollectionReusableView * reusableView;
    
}
@property(nonatomic,strong)AddphotosViewController * addPhoto;
@end

@implementation PromoteyourselfViewController

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
    
    size =[UIScreen mainScreen].bounds.size;
    
   // self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)148/255 blue:(CGFloat)214/255 alpha:1.0];
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, size.width, 55);
    //UIColor *firstColor = [UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
   // UIColor *secColor = [UIColor colorWithRed:(CGFloat)121/255 green:(CGFloat)2/255 blue:(CGFloat)0/255 alpha:1.0];
    UIColor *firstColor = [UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)88/255 blue:(CGFloat)211/255 alpha:1.0];
    UIColor *secColor = [UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)0/255 blue:(CGFloat)155/255 alpha:1.0];
    layer.colors = [NSArray arrayWithObjects:(id)[firstColor CGColor],(id)[secColor CGColor], nil];
    [self.view.layer insertSublayer:layer atIndex:0];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.frame=CGRectMake(size.width/2-100, 20, size.width-100, 35);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.text = @"Promote yourself";
    [self.view addSubview:self.titleLabel];
    //Add Cancel BUTTON
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.frame = CGRectMake(size.width/2-145, 25, 60, 25);
    [self.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    self.cancelButton.layer.borderColor = [UIColor redColor].CGColor;
    self.cancelButton.layer.borderWidth = 0.7;
    self.cancelButton.layer.cornerRadius = 4;
    self.cancelButton.clipsToBounds = YES;
    [self.cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cancelButton];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
         layer.frame = CGRectMake(0, 0, size.width, 75);
        self.titleLabel.frame=CGRectMake(size.width/2-300, 25, size.width-100, 40);
        self.cancelButton.frame = CGRectMake(size.width/2-350, 25, 120, 40);
        self.cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:30];
        height=75;
    }
    else{
        height=55;
    }
    
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark-createUI

-(void)createUI{
    UICollectionViewFlowLayout * flowLayout=[[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing = (CGFloat)2.0;
    flowLayout.minimumLineSpacing = (CGFloat)2.0;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        self.mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, height, size.width, size.height-500)collectionViewLayout:flowLayout];
    }
    else{
        self.mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, height, size.width, size.height+50) collectionViewLayout:flowLayout];
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
    [self.mainCollectionView registerClass:[CollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    
    [self.mainCollectionView registerClass:[CollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
   

    
}

#pragma mark-
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"images count in promote %lu",(unsigned long)[SingletonClass shareSingleton].userImages.count);
    if ([SingletonClass shareSingleton].profileImages.count<1) {
        return 1;
    }
    return [SingletonClass shareSingleton].profileImages.count+1;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"CustomCollectionCell" forIndexPath:indexPath];
    NSString *name = @"crm.png";
    
     CustomCollectionCell *customCellView = [[CustomCollectionCell alloc] initWithFrame:cell.bounds];
    if(indexPath.row==0)
    {
        customCellView.profileImageView.image = [UIImage imageNamed:@"profile_pic_bg.png"];
        customCellView.toggleButton.hidden=YES;
    }
    else{
        customCellView.toggleButton.hidden=YES;
        NSString * imageUrl;
        if ([SingletonClass shareSingleton].profileImages.count>0) {
            NSMutableDictionary * dict=[[SingletonClass shareSingleton].profileImages objectAtIndex:indexPath.row-1];
            
            
            if ([[dict objectForKey:@"privacy"]isEqualToString:@"3"]) {
                imageUrl=[NSString stringWithString:[dict objectForKey:@"imageLink"]];
            }
            else{
                imageUrl=[NSString stringWithFormat:@"http://taka.dating/%@",[dict objectForKey:@"imageLink"]];
            }
            NSURL * url=[NSURL URLWithString:imageUrl];
            
        [customCellView.profileImageView  setImageWithURL:url];
        }
       
    }
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
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            return CGSizeMake(size.width, 150);
        }
        CGSize size1 = CGSizeMake(self.view.frame.size.width, 125);
        return size1;
    }
    CGSize size1 = CGSizeMake(self.view.frame.size.width, 25);
    return size1;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    if (section==0) {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            return CGSizeMake(size.width, 150);
        }

        CGSize size1 = CGSizeMake(self.view.frame.size.width, 125);
        return size1;
    }
    CGSize size1 = CGSizeMake(self.view.frame.size.width, 25);
    return size1;
    
}



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    reusableView = nil;

    if (kind == UICollectionElementKindSectionHeader){
        
        
        if (indexPath.section==0) {
            reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        }
       
        reusableView.backgroundColor = [UIColor whiteColor];
        
        if (indexPath.section==0) {
                //textLabel.frame = CGRectMake(0, 100, self.view.frame.size.width, 25);
            reusableView.headerTitleLabel.text = @"   Promote your profile to number one and be seen by thousands of people nearby!. ";
            reusableView.bottomLabel.text=@" Choose a photo display:";
            reusableView.headerTitleLabel.textColor=[UIColor whiteColor];
            reusableView.bottomLabel.textColor=[UIColor whiteColor];
            reusableView.backgroundColor=[UIColor blackColor];
            
          
        }
       
        return reusableView;
        
    }//End Header Kind Check
    if (kind==UICollectionElementKindSectionFooter) {
        
            if (indexPath.section==0) {
                reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
                }
            reusableView.backgroundColor = [UIColor whiteColor];
            
            if (indexPath.section==0) {
                    //textLabel.frame = CGRectMake(0, 100, self.view.frame.size.width, 25);
                    reusableView.footerTitleLabel.text=@" This feature requires 100 credits";
                reusableView.backgroundColor=[UIColor blackColor];
                reusableView.footerTitleLabel.textColor=[UIColor whiteColor];
                [reusableView.footerButton setBackgroundImage:[UIImage imageNamed:@"setting_btn_bg.png"] forState:UIControlStateNormal];                [reusableView.footerButton setTitle:@"GO!" forState:UIControlStateNormal];
                    [reusableView.footerButton addTarget:self action:@selector(footerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                }
        return  reusableView;
    }
    
       return nil;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            if (!self.addPhoto) {
                self.addPhoto=[[AddphotosViewController alloc]initWithNibName:@"AddphotosViewController" bundle:nil];
            }
            [self.navigationController pushViewController:self.addPhoto animated:YES];
        }
    }
}

-(void)footerButtonAction:(id)sender{
    NSLog(@"Footer button clicked");
}

-(void)cancelButtonAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
