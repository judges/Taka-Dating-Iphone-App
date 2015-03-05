//
//  AddphotoCustomCell.m
//  TakaDating
//
//  Created by Sumit Ghosh on 02/01/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import "AddphotoCustomCell.h"

@implementation AddphotoCustomCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.containerView.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:self.containerView];
        
        self.imageView=[[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 120, 120)];
        
        [self.contentView addSubview:self.imageView];

        
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
