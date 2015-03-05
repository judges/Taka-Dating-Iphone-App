//
//  CustomCellView.m
//  TakaDating
//
//  Created by GBS-ios on 11/12/14.
//  Copyright (c) 2014 Globussoft. All rights reserved.
//

#import "CustomCellView.h"

@implementation CustomCellView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
       //self.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
        self.profileImageView = [[UIImageView alloc] initWithFrame:frame];
        [self addSubview:self.profileImageView];
        self.profileImageView.layer.cornerRadius = 4;
        self.profileImageView.clipsToBounds = YES;
        //----------
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.frame=CGRectMake(7, 2, frame.size.width-10, 15);
        self.nameLabel.backgroundColor = [UIColor clearColor];
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.nameLabel];

        self.customImageCounterView = [[CustomImageCountView alloc] init];
        self.customImageCounterView.frame=CGRectMake(40, 55, 30, 16);
        self.customImageCounterView.backgroundColor = [UIColor colorWithRed:(CGFloat)100/255 green:(CGFloat)100/255 blue:(CGFloat)100/255 alpha:1];
        self.customImageCounterView.layer.cornerRadius = 1.5;
        self.customImageCounterView.clipsToBounds = YES;
        [self addSubview:self.customImageCounterView];
        
        self.isOnlne=[[UIImageView alloc]init];;
        self.isOnlne.frame=CGRectMake(0, 50, 15, 15);
        //[self.toggleButton setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
        
        
       // [self.toggleButton setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
        [self addSubview:self.isOnlne];
        
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            
            self.nameLabel.frame=CGRectMake(7, 2, frame.size.width-10, 30);
            self.customImageCounterView.frame=CGRectMake(100, 100, 50, 30);
            self.isOnlne.frame=CGRectMake(0, 110, 20, 20);
            //[self.toggleButton setImage:[UIImage imageNamed:@"select_normal_ipad.png"] forState:UIControlStateNormal];
            
          //  [self.toggleButton setImage:[UIImage imageNamed:@"select_active_ipad.png"] forState:UIControlStateSelected];
            self.nameLabel.font = [UIFont systemFontOfSize:20];
            self.customImageCounterView.layer.cornerRadius = 3.0;
           
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
