//
//  FBPhotoPickerViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 31/12/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "FBPhotoPickerViewController.h"
#import "SingletonClass.h"
#import "UIImageView+WebCache.h"
#import "AFNHelper.h"

@interface FBPhotoPickerViewController ()

@end

@implementation FBPhotoPickerViewController

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
    
    self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
     self.view.backgroundColor=[UIColor blackColor];
    self.headerView=[[UIView alloc]init];
    self.headerView.frame=CGRectMake(0, 0, self.view.frame.size.width, 55);
    
    [self.view addSubview:self.headerView];
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, self.view.frame.size.width, 55);
    UIColor *firstColor = [UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
    UIColor *secColor = [UIColor colorWithRed:(CGFloat)121/255 green:(CGFloat)2/255 blue:(CGFloat)0/255 alpha:1.0];
    layer.colors = [NSArray arrayWithObjects:(id)[firstColor CGColor],(id)[secColor CGColor], nil];
    
    [self.view.layer insertSublayer:layer atIndex:1];
    
    self.titleLabel = [[UILabel alloc] init ];
    self.titleLabel.frame= CGRectMake(size.width/2-60, 20, size.width-200, 35);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.text = @"Choose photo";
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
    [self.cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cancelButton];
    
    self.saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saveButton.frame = CGRectMake(size.width/2-70, 25, 60, 25);
    [self.saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.saveButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.saveButton setTitle:@"Save" forState:UIControlStateNormal];
    self.saveButton.layer.borderColor = [UIColor redColor].CGColor;
    self.saveButton.layer.borderWidth = 0.7;
    self.saveButton.layer.cornerRadius = 4;
    self.saveButton.clipsToBounds = YES;
    [self.view addSubview:self.saveButton];

    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
         layer.frame = CGRectMake(0, 0,size.width, 75);
         self.cancelButton.frame = CGRectMake(size.width/2-350, 25, 120, 40);
        self.saveButton.frame = CGRectMake(size.width-150, 25, 120, 40);
        self.titleLabel.frame= CGRectMake(size.width/2-270, 20, size.width-200, 35);
        
         self.titleLabel.font = [UIFont boldSystemFontOfSize:30];
        self.cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.saveButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    }
    
    
  /*  if ([SingletonClass shareSingleton].photosOfUser.count<=0) {
        self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
         NSLog(@"Show message on View");
        UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(0, size.height-300, size.width, 40)];
        label.font=[UIFont boldSystemFontOfSize:15.0];
        label.text=@"No photos are available";
        [self.view addSubview:label];
    }
    else{*/
        [self createUI];
   // }
    // Do any additional setup after loading the view from its nib.
}

-(void)createUI{
    CGFloat height,minus;;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        height=75;
        minus=480;
    }
    else{
        height=55;
        minus=55;
    }
    
    UICollectionViewFlowLayout * collectionFlowLayout=[[UICollectionViewFlowLayout alloc]init];
    collectionFlowLayout.minimumInteritemSpacing=(float)2.0;
    collectionFlowLayout.minimumLineSpacing=(float)2.0;
    collectionFlowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, height, size.width, size.height-minus) collectionViewLayout:collectionFlowLayout];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //self.mainCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    [self.mainCollectionView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    self.mainCollectionView.dataSource = self;
    self.mainCollectionView.delegate = self;
    //self.mainCollectionView.backgroundColor = [UIColor colorWithRed:(CGFloat)59/255 green:(CGFloat)97/255 blue:(CGFloat)107/255 alpha:1];
    //self.mainCollectionView.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    [self.mainCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CustomCollectionCell"];
    
    [self.view addSubview:self.mainCollectionView];
    
    
}
-(void)cancelButtonAction{
    [SingletonClass shareSingleton].photosOfUser=nil;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma  mark- Collection view delecgate methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [SingletonClass shareSingleton].photosOfUser.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
     UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"CustomCollectionCell" forIndexPath:indexPath];
    AddPhotoViewCell * photoCell=[[AddPhotoViewCell alloc]initWithFrame:cell.bounds];
    NSString * urlStr=[[SingletonClass shareSingleton].photosOfUser objectAtIndex:indexPath.row];
    NSURL * url=[NSURL URLWithString:urlStr];
    [photoCell.profileImageView setImageWithURL:url];
    [cell addSubview:photoCell];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        return CGSizeMake(150,150);
    }
    return CGSizeMake(73, 73);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString * urlStr=[[SingletonClass shareSingleton].photosOfUser objectAtIndex:indexPath.row];
    NSURL * url=[NSURL URLWithString:urlStr];
    
    
    NSData * imageData=[NSData dataWithContentsOfURL:url];
    
    UIImage * image=[UIImage imageWithData:imageData];
    
   // NSLog(@"nsdata of image %@",imageData);
    NSMutableDictionary * dictParm=[[NSMutableDictionary alloc]init];
    [dictParm setValue:[SingletonClass shareSingleton].userID forKey:@"id"];
    //[dictParm setValue:@"0"forKey:@"id"];
   // [dictParm setValue:imageData forKey:@"image_upload"];
    NSString * postUrl=@"http://taka.dating/mobile/uploadImage";
    AFNHelper * afn=[[AFNHelper alloc]init];
    
    [afn getDataFromPath:postUrl withParamDataImage:dictParm andImage:image withBlock:^(id response, NSError *error) {
        if (error) {
            NSLog(@"Fail");
        }else{
            
            NSLog(@"Upload Successfull");
            NSLog(@"responsible %@",response);
            
        }
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
