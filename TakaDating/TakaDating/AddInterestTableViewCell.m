//
//  AddInterestTableViewCell.m
//  TakaDating
//
//  Created by Sumit Ghosh on 26/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "AddInterestTableViewCell.h"

@implementation AddInterestTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.containerView=[[UIView alloc]init];
        self.containerView.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:self.containerView];
        
        self.cellLabel=[[UILabel alloc]init];
        self.cellLabel.font=[UIFont boldSystemFontOfSize:13];
        self.cellLabel.textColor=[UIColor blackColor];
        [self.containerView addSubview:self.cellLabel];
        
        self.cellButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.cellButton setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
        [self.cellButton setImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateSelected];
        [self.containerView addSubview:self.cellButton];
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
             self.cellLabel.font=[UIFont boldSystemFontOfSize:20];
        }
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
