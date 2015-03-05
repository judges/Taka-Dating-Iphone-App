//
//  EncounterProfileTableViewCell.m
//  TakaDating
//
//  Created by Sumit Ghosh on 24/11/14.
//  Copyright (c) 2014 Globussoft. All rights reserved.
//

#import "EncounterProfileTableViewCell.h"

@implementation EncounterProfileTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor clearColor];
        self.contentView.backgroundColor=[UIColor clearColor];
        self.containerView=[[UIView alloc]init];
        self.containerView.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:self.containerView];
        
        self.cellLabel=[[UILabel alloc]init];
        self.cellLabel.font=[UIFont systemFontOfSize:12];
        self.cellLabel.textColor=[UIColor blackColor];
        [self.containerView addSubview:self.cellLabel];

               
                    
        
        

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
