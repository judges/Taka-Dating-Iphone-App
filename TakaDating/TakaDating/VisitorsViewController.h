//
//  VisitorsViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 30/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VisitorsViewController : UIViewController< UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIActionSheetDelegate>
{
    BOOL selectAll,editAll,awardSanction;
    CGSize windowSize;
    NSMutableArray * viewerID,*viewerName,*viewerImage,*isOnline,*imgCount;
    UIButton * toggleButton;
    NSMutableArray * cellSelectedArr;
}
@property (nonatomic) UIScrollView *scrollView;
//@property (nonatomic) UICollectionView *topCollectionView;
@property (nonatomic) UICollectionView *mainCollectionView;
@property (nonatomic, strong) NSArray *topCollectionArray;
@property (nonatomic, strong) NSArray *mainDataCollectionArray;
@property(nonatomic,strong)UIActivityIndicatorView * refreshActivityIndicator;

@end
