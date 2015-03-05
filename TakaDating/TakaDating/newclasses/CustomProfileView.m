//
//  CustomProfileView.m
//  TakaDating
//
//  Created by GBS-ios on 11/12/14.
//  Copyright (c) 2014 Globussoft. All rights reserved.
//

#import "CustomProfileView.h"

@implementation CustomProfileView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
        self.profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:self.profileImageView];
        self.profileImageView.layer.cornerRadius = 3;
        self.profileImageView.clipsToBounds = YES;
        //----------
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 2, frame.size.width-10, 15)];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.nameLabel];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
