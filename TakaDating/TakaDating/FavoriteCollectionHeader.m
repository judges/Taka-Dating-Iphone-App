//
//  FavoriteCollectionHeader.m
//  TakaDating
//
//  Created by Sumit Ghosh on 04/12/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "FavoriteCollectionHeader.h"

@implementation FavoriteCollectionHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.headerTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height-25, frame.size.width, 25)];
        // self.headerTitleLabel.backgroundColor = [UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
        
        self.headerTitleLabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"header.png"]];
        self.headerTitleLabel.textColor = [UIColor whiteColor];
        self.headerTitleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.headerTitleLabel];

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
