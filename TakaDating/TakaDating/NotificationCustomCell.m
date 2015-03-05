//
//  NotificationCustomCell.m
//  TakaDating
//
//  Created by Sumit Ghosh on 19/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "NotificationCustomCell.h"

@implementation NotificationCustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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
        
       
        
        
        
        self.mobileButton=[UIButton buttonWithType:UIButtonTypeCustom];
        //self.mobileButton.frame=CGRectMake(200, 5, 15, 10);
        //[self.mobileButton setTitle:@"m" forState:UIControlStateNormal];
        self.mobileButton.titleLabel.textColor=[UIColor blackColor];
        [self.mobileButton setImage:[UIImage imageNamed:@"mobile_icon.png"] forState:UIControlStateNormal];
        [self.mobileButton setImage:[UIImage imageNamed:@"mobile_icon_active.png"] forState:UIControlStateSelected];
        [self.containerView addSubview:self.mobileButton];
        
        self.letterButton=[UIButton buttonWithType:UIButtonTypeCustom];
       // self.letterButton.frame=CGRectMake(240, 5, 15, 10);
       // [self.letterButton setTitle:@"l" forState:UIControlStateNormal];
        self.letterButton.titleLabel.textColor=[UIColor blackColor];
         [self.letterButton setImage:[UIImage imageNamed:@"message_icon.png"] forState:UIControlStateNormal];
         [self.letterButton setImage:[UIImage imageNamed:@"message_icon_active.png"] forState:UIControlStateSelected];
        [self.containerView addSubview:self.letterButton];
        
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            [self.mobileButton setImage:[UIImage imageNamed:@"mobile_icon_ipad.png"] forState:UIControlStateNormal];
            [self.mobileButton setImage:[UIImage imageNamed:@"mobile_icon_active_ipad.png"] forState:UIControlStateSelected];
            
            [self.letterButton setImage:[UIImage imageNamed:@"message_icon_ipad.png"] forState:UIControlStateNormal];
            [self.letterButton setImage:[UIImage imageNamed:@"message_icon_active_ipad.png"] forState:UIControlStateSelected];
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
