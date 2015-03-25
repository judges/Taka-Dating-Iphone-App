//
//  MessageTableViewCell.m
//  TakaDating
//
//  Created by Sumit Ghosh on 30/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.containerView=[[UIView alloc]init];
        self.containerView.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:self.containerView];
        
        
        self.cellLabel=[[UILabel alloc]init];
        self.cellLabel.font=[UIFont systemFontOfSize:12];
        self.cellLabel.textColor=[UIColor blackColor];
        [self.containerView addSubview:self.cellLabel];
        
        self.deleteButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.deleteButton setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
        [self.deleteButton setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
        [self.containerView addSubview: self.deleteButton];
        
        self.imgView=[[UIImageView alloc]init];
        self.imgView.layer.cornerRadius=12.0;
        self.imgView.clipsToBounds=YES;
        [self.containerView addSubview:self.imgView];
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
