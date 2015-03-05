//
//  CreditsCustomCell.h
//  TakaDating
//
//  Created by Sumit Ghosh on 12/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreditsCustomCell : UITableViewCell

@property (nonatomic, strong) UIView *containerView;
@property(nonatomic,strong)UILabel * topLabel,* bottomLabel;
@property(nonatomic,strong)UIImageView * imagView;
@property(nonatomic,strong)UIButton *refillCredits;

@end
