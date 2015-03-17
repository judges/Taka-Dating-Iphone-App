//
//  AwardTableViewCell.h
//  TakaDating
//
//  Created by Sumit Ghosh on 14/03/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AwardTableViewCell : UITableViewCell

@property(nonatomic,strong)UIView * containerView;
@property(nonatomic,strong)UIImageView * imgView;
@property(nonatomic,strong)UILabel * cellLable,* cellSubLbl;

@end
