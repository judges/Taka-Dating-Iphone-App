//
//  ProfileableViewCell.m
//  TakaDating
//
//  Created by Sumit Ghosh on 13/12/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "ProfileableViewCell.h"

@implementation ProfileableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.containerView=[[UIView alloc]init];
        self.containerView.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:self.containerView];
        
        self.topLabel=[[UILabel alloc]init];
        self.topLabel.textColor=[UIColor blackColor];
        [self.containerView addSubview:self.topLabel];
        
        self.secLabel=[[UILabel alloc]init];
       
        self.secLabel.textColor=[UIColor blackColor];
        [self.containerView addSubview:self.secLabel];
        
        

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
