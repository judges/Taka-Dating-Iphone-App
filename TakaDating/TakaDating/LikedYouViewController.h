//
//  LikedYouViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 28/01/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LikedYouViewController : UIViewController<UICollectionViewDataSource,UIScrollViewDelegate,UICollectionViewDelegate>
{
    NSMutableArray * sex,* imageCount,* isOnline,*displayName,*useriId,*thumbanailUrl;
    CGSize windowSize;
    BOOL editAll,selectAll,awardSanction;
    UIButton * toggleButton;
    NSMutableArray * cellSelectedArr;
}
@property(nonatomic)UIButton * cancelButton;
@property (nonatomic) UIScrollView *scrollView;
//@property (nonatomic) UICollectionView *topCollectionView;
@property (nonatomic) UICollectionView *mainCollectionView;
@property (nonatomic, strong) NSArray *topCollectionArray;
@property (nonatomic, strong) NSArray *mainDataCollectionArray;
@property(nonatomic,strong)UIActivityIndicatorView * refreshActivityIndicator;
@end
