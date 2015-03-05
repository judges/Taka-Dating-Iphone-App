//
//  PeopleNearByViewController.h
//  TakaDating
//
//  Created by GBS-ios on 11/10/14.
//  Copyright (c) 2014 Globussoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeopleNearByViewController : UIViewController<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    CGSize windowSize;
    int currentPage;
    BOOL addNewRows,firstTime;
}
@property (nonatomic) UIScrollView *scrollView;
//@property (nonatomic) UICollectionView *topCollectionView;
@property (nonatomic) UICollectionView *mainCollectionView;
@property (nonatomic, strong) NSArray *topCollectionArray;
@property (nonatomic, strong) NSArray *mainDataCollectionArray;
@property(nonatomic,strong)NSArray * displaName,* isOnline,*imageCount,* profilePic,* userId;
@property(nonatomic,strong)UIActivityIndicatorView *refreshActivityIndicator;

@end
