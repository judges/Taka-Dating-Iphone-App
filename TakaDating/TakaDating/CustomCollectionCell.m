//
//  CustomCollectionCell.m
//  TakaDating
//
//  Created by Globussoft 1 on 12/1/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "CustomCollectionCell.h"

@implementation CustomCollectionCell


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
            // Initialization code
       // self.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
        self.profileImageView = [[UIImageView alloc] initWithFrame:frame];
        [self addSubview:self.profileImageView];
        self.profileImageView.layer.cornerRadius = 3;
        self.profileImageView.clipsToBounds = YES;
        
        self.toggleButton=[UIButton buttonWithType:UIButtonTypeCustom];
        self.toggleButton.frame=CGRectMake(0, 50, 30, 30);
        [self.toggleButton setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
        
        [self.toggleButton setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
        [self addSubview:self.toggleButton];
    }
    return self;
}

@end
