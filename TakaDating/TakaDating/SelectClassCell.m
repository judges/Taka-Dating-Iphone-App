//
//  SelectClassCell.m
//  TakaDating
//
//  Created by Sumit Ghosh on 16/12/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "SelectClassCell.h"

@implementation SelectClassCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.containerView=[[UIView alloc]init];
        self.containerView.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:self.containerView];
        
        self.cellLabel=[[UILabel alloc]init];
        self.cellLabel.font=[UIFont boldSystemFontOfSize:12];
        self.cellLabel.textColor=[UIColor blackColor];
        [self.containerView addSubview:self.cellLabel];
        
        self.rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
        self.rightButton.layer.cornerRadius=4;
        self.rightButton.clipsToBounds=YES;
        [self.containerView addSubview:self.rightButton];
        
        self.leftbutton=[UIButton buttonWithType:UIButtonTypeCustom];
        self.leftbutton.layer.cornerRadius=4;
        self.leftbutton.clipsToBounds=YES;
        [self.leftbutton setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
        [self.leftbutton setImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateSelected];
        [self.containerView addSubview:self.leftbutton];
        
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            self.cellLabel.font=[UIFont boldSystemFontOfSize:20];
            [self.leftbutton setImage:[UIImage imageNamed:@"select_normal_ipad.png"] forState:UIControlStateNormal];
            [self.leftbutton setImage:[UIImage imageNamed:@"select_ipad.png"] forState:UIControlStateSelected];
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
