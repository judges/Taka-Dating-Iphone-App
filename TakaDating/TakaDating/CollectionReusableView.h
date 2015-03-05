//
//  CollectionReusableView.h
//  TakaDating
//
//  Created by Globussoft 1 on 12/1/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionReusableView : UICollectionReusableView
@property (nonatomic) UILabel *headerTitleLabel,*bottomLabel;
@property(nonatomic)UIView * backView;
@property (nonatomic) UILabel *footerTitleLabel;
@property(nonatomic)UIButton * footerButton;
@end
