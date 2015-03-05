//
//  CustomCellView.h
//  TakaDating
//
//  Created by GBS-ios on 11/12/14.
//  Copyright (c) 2014 Globussoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomImageCountView.h"

@interface CustomCellView : UIView
@property (nonatomic, strong)  UIImageView *profileImageView;
@property (nonatomic, strong)  UILabel *nameLabel;
@property(nonatomic,strong)UIImageView *toggleButton,* isOnlne;
@property (nonatomic, strong) UIImageView *loginIndicatorImageView;
@property (nonatomic, strong) CustomImageCountView *customImageCounterView;


@end
