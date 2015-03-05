//
//  NotificationCustomCell.h
//  TakaDating
//
//  Created by Sumit Ghosh on 19/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationCustomCell : UITableViewCell

@property(nonatomic,strong)UIView * containerView;
@property(nonatomic,strong)UILabel * cellLabel;
@property(nonatomic,strong)UIButton * mobileButton,* letterButton;
@end
