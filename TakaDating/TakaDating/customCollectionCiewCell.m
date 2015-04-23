//
//  customCollectionCiewCell.m
//  TakaDating
//
//  Created by Sumit Ghosh on 31/03/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import "customCollectionCiewCell.h"

@implementation customCollectionCiewCell

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //self.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
        self.profileImageView = [[UIImageView alloc] init];
        self.profileImageView.frame=CGRectMake(0, 0, 73, 73);
        [self addSubview:self.profileImageView];
        self.profileImageView.layer.cornerRadius = 4;
        self.profileImageView.clipsToBounds = YES;
        //----------
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.frame=CGRectMake(7, 4, frame.size.width-10, 15);
        self.nameLabel.backgroundColor = [UIColor clearColor];
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.nameLabel];
        
        self.customImageCounterView = [[CustomImageCountView alloc] init];
        self.customImageCounterView.frame=CGRectMake(40, 60, 30, 16);
        self.customImageCounterView.backgroundColor = [UIColor colorWithRed:(CGFloat)100/255 green:(CGFloat)100/255 blue:(CGFloat)100/255 alpha:1];
        self.customImageCounterView.layer.cornerRadius = 1.5;
        self.customImageCounterView.clipsToBounds = YES;
        [self addSubview:self.customImageCounterView];
        
        self.isOnlne=[[UIImageView alloc]init];;
        self.isOnlne.frame=CGRectMake(5, 55, 15, 15);
        //[self.toggleButton setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
        
        
        // [self.toggleButton setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
        [self addSubview:self.isOnlne];
        
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            self.profileImageView.frame=CGRectMake(0, 0, 150, 150);
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
@end
