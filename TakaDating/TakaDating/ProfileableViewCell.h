//
//  ProfileableViewCell.h
//  TakaDating
//
//  Created by Sumit Ghosh on 13/12/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileableViewCell : UITableViewCell
@property (nonatomic,strong)UIView * containerView;
@property(nonatomic,strong)UILabel * topLabel,* secLabel;
@property(nonatomic,strong)UIImageView * imgView;

@end
