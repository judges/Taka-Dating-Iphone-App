//
//  InterestTableViewCell.m
//  TakaDating
//
//  Created by Sumit Ghosh on 26/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "InterestTableViewCell.h"

@implementation InterestTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 15, 320, 80)];
        self.containerView.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)251/255 blue:(CGFloat)251/255 alpha:1];
        [self.contentView addSubview:self.containerView];
        
        self.cellLabel=[[UILabel  alloc]init];
        self.cellLabel.font=[UIFont systemFontOfSize:12];
        self.cellLabel.textColor=[UIColor blackColor];
        [self.containerView addSubview:self.cellLabel];
        
        self.cellButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.cellButton setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
        [self.cellButton setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
        [self.containerView addSubview:self.cellButton];
        
        //Add cell images view;
        
        self.imgView=[[UIImageView alloc]init ];
                     // WithFrame:CGRectMake(15, 15, 15, 15)];
        self.imgView.contentMode=UIViewContentModeScaleAspectFill;
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
