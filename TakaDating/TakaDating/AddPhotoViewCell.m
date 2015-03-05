//
//  AddPhotoViewCell.m
//  TakaDating
//
//  Created by Sumit Ghosh on 02/01/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import "AddPhotoViewCell.h"

@implementation AddPhotoViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
       // self.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
        self.backgroundColor=[UIColor blackColor];
      
        self.profileImageView = [[UIImageView alloc] initWithFrame:frame];
        
        self.profileImageView.layer.cornerRadius = 3;
        self.profileImageView.layer.borderColor=[UIColor colorWithRed:(CGFloat)193/255 green:(CGFloat)193/255 blue:(CGFloat)193/255 alpha:1.0].CGColor;
        self.profileImageView.layer.borderWidth=0.5;
        self.profileImageView.clipsToBounds = YES;
        [self addSubview: self.profileImageView];
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
