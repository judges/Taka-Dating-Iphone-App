//
//  PromoteyourselfViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 30/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionReusableView.h"
#import "CustomCollectionCell.h"
#import "AddphotosViewController.h"

@interface PromoteyourselfViewController : UIViewController< UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    CGSize size;
    CGFloat height;
}
@property(nonatomic)UILabel * titleLabel;
@property(nonatomic)UIButton * cancelButton;

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UICollectionView *mainCollectionView;
@property (nonatomic, strong) NSArray *topCollectionArray;


@end
