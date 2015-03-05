//
//  CustomTableCell.h
//  TakaDating
//
//  Created by Sumit Ghosh on 11/02/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableCell : UITableViewCell

@property(nonatomic,strong)UIView * containerView;
@property(nonatomic,strong)UIImageView * leftImgView,* rightImgView;
@property(nonatomic,strong)UILabel * titleLabel;
@end
