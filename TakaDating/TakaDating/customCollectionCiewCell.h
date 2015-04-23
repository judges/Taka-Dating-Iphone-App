//
//  customCollectionCiewCell.h
//  TakaDating
//
//  Created by Sumit Ghosh on 31/03/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomImageCountView.h"


@interface customCollectionCiewCell : UICollectionViewCell


@property (nonatomic, strong)  UIImageView *profileImageView;
@property (nonatomic, strong)  UILabel *nameLabel;
@property(nonatomic,strong)UIImageView *toggleButton,* isOnlne;
@property (nonatomic, strong) UIImageView *loginIndicatorImageView;
@property (nonatomic, strong) CustomImageCountView *customImageCounterView;
@end
