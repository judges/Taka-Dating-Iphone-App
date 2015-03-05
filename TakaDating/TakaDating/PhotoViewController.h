//
//  PhotoViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 05/12/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController< UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSMutableArray * privacyZeroPic,* privacyOnePic,* privacyTwoPic;
    CGFloat x,y,header_hh;
}

@property (nonatomic) UIScrollView *scrollView;
//@property (nonatomic) UICollectionView *topCollectionView;
@property (nonatomic) UICollectionView *mainCollectionView;
@property (nonatomic, strong) NSArray *topCollectionArray,*profileImages;
@property (nonatomic, strong) NSArray *mainDataCollectionArray;
@property(nonatomic,assign)CGRect collection_frame;
-(id)initWithFrame:(CGRect)frame;
@end
