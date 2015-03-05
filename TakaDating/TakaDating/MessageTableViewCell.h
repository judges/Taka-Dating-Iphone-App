//
//  MessageTableViewCell.h
//  TakaDating
//
//  Created by Sumit Ghosh on 30/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell

@property(nonatomic,strong)UIView * containerView;
@property(nonatomic,strong)UIImageView * imgView;
@property(nonatomic,strong)UIButton * deleteButton;
@property(nonatomic,strong)UILabel * cellLabel;




@end
