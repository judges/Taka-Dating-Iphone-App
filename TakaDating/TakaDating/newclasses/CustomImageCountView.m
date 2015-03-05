//
//  CustomImageCountView.m
//  TakaDating
//
//  Created by GBS-ios on 11/12/14.
//  Copyright (c) 2014 Globussoft. All rights reserved.
//

#import "CustomImageCountView.h"

@implementation CustomImageCountView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.cameraImageView = [[UIImageView alloc] init];
        self.cameraImageView.frame=CGRectMake(3, 2, 12, 12);
        self.cameraImageView.image = [UIImage imageNamed:@"photo_icon_grey.png"];
        [self addSubview:self.cameraImageView];
        
        self.totalImageCountLabel = [[UILabel alloc] init];
        self.totalImageCountLabel.frame=CGRectMake(19, 0, 20, 15);
        self.totalImageCountLabel.backgroundColor = [UIColor clearColor];
        self.totalImageCountLabel.textAlignment = NSTextAlignmentLeft;
        self.totalImageCountLabel.font = [UIFont boldSystemFontOfSize:11];
        self.totalImageCountLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.totalImageCountLabel];
        
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            self.cameraImageView.frame=CGRectMake(3, 7, 20, 20);
            self.cameraImageView.image = [UIImage imageNamed:@"photo_icon_grey_ipad.png"];
            self.totalImageCountLabel.frame=CGRectMake(25, 9, 50, 15);
            self.totalImageCountLabel.font = [UIFont boldSystemFontOfSize:15];
        }
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
