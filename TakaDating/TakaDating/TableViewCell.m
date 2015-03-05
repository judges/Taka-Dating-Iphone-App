//
//  TableViewCell.m
//  TakaDating
//
//  Created by Sumit Ghosh on 20/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib
{
    // Initialization code
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 15, 320, 100)];
    self.containerView.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)251/255 blue:(CGFloat)251/255 alpha:1];
    [self.contentView addSubview:self.containerView];
    
    self.cellLabel=[[UILabel alloc]init];
    self.cellLabel.textColor=[UIColor blackColor];
    self.cellLabel.font=[UIFont systemFontOfSize:12];
    [self.containerView addSubview:self.cellLabel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
