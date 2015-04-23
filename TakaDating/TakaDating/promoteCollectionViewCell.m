//
//  promoteCollectionViewCell.m
//  TakaDating
//
//  Created by Sumit Ghosh on 31/03/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import "promoteCollectionViewCell.h"

@implementation promoteCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // self.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
        self.profileImageView = [[UIImageView alloc] init];
        self.profileImageView.frame=CGRectMake(0, 0, 73, 73);
        [self addSubview:self.profileImageView];
        self.profileImageView.layer.cornerRadius = 3;
        self.profileImageView.clipsToBounds = YES;
        
        self.toggleButton=[UIButton buttonWithType:UIButtonTypeCustom];
        self.toggleButton.frame=CGRectMake(0, 50, 30, 30);
        [self.toggleButton setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
        
        [self.toggleButton setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
        [self addSubview:self.toggleButton];
        if (UIUserInterfaceIdiomPad==UI_USER_INTERFACE_IDIOM()) {
             self.profileImageView.frame=CGRectMake(0, 0, 150, 150);
        }
    }
    return self;
}

@end
