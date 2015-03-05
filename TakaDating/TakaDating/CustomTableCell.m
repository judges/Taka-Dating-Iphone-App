//
//  CustomTableCell.m
//  TakaDating
//
//  Created by Sumit Ghosh on 11/02/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import "CustomTableCell.h"

@implementation CustomTableCell

- (void)awakeFromNib {
    // Initialization code
    
    self.backgroundColor=[UIColor clearColor];
    self.containerView=[[UIView alloc]init];
    self.containerView.frame=CGRectMake(0, 0, 320, 30);
    self.containerView.backgroundColor=[UIColor clearColor];
    [self.contentView addSubview:self.containerView];
    
    self.leftImgView=[[UIImageView alloc]init];
    [self.containerView addSubview:self.leftImgView];
    
    self.titleLabel=[[UILabel alloc]init];
    self.titleLabel.font=[UIFont boldSystemFontOfSize:15];
    self.titleLabel.textColor=[UIColor whiteColor];
    [self.containerView addSubview:self.titleLabel];
    
    self.rightImgView=[[UIImageView alloc]init];
    [self.containerView addSubview:self.rightImgView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
