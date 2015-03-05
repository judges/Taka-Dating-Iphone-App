//
//  FavoriteCustomCell.m
//  TakaDating
//
//  Created by Sumit Ghosh on 06/12/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "FavoriteCustomCell.h"

@implementation FavoriteCustomCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.toggleButton=[UIButton buttonWithType:UIButtonTypeCustom];
        self.toggleButton.frame=CGRectMake(50, 5, 30, 30);
        [self.toggleButton setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
        
        [self.toggleButton setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
        [self addSubview:self.toggleButton];
        
        self.isOnlne=[[UIImageView alloc]init];
        self.isOnlne.frame=CGRectMake(0, 50, 30, 30);
        [self addSubview:self.isOnlne];
        
        
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            self.toggleButton.frame=CGRectMake(50, 5, 50, 50);
             self.isOnlne.frame=CGRectMake(0, 50, 50, 50);
            [self.toggleButton setImage:[UIImage imageNamed:@"select_normal_ipad.png"] forState:UIControlStateNormal];
            
            [self.toggleButton setImage:[UIImage imageNamed:@"select_active_ipad.png"] forState:UIControlStateSelected];

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
