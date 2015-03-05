//
//  CollectionCellView.m
//  TakaDating
//
//  Created by Sumit Ghosh on 04/12/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "CollectionCellView.h"


@implementation CollectionCellView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //self.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
        self.profileImageView = [[UIImageView alloc] initWithFrame:frame];
        [self addSubview:self.profileImageView];
        self.profileImageView.layer.cornerRadius = 3;
        self.profileImageView.clipsToBounds = YES;
        //----------
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 2, frame.size.width-10, 15)];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.nameLabel];
        
        self.customImageCounterView = [[CustomImageCountView alloc] initWithFrame:CGRectMake(40, 55, 30, 16)];
        self.customImageCounterView.backgroundColor = [UIColor colorWithRed:(CGFloat)100/255 green:(CGFloat)100/255 blue:(CGFloat)100/255 alpha:1];
        self.customImageCounterView.layer.cornerRadius = 1.5;
        self.customImageCounterView.clipsToBounds = YES;
        [self addSubview:self.customImageCounterView];
        
        self.togglebutton=[UIButton buttonWithType:UIButtonTypeCustom];
        self.togglebutton.frame=CGRectMake(50, 5, 15, 15);
        [self.togglebutton setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateNormal];
        
        [self.togglebutton setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
        //[self addSubview:self.togglebutton];
        
        
        self.isOnlne=[[UIImageView alloc]init];
        self.isOnlne.frame=CGRectMake(0, 60, 15, 15);
        [self addSubview:self.isOnlne];
        
//        self.promoteButton=[[UIButton alloc]initWithFrame:CGRectMake(40, 120, 240, 30)];
//        [self.promoteButton setTitle:@"Promote yourself" forState:UIControlStateNormal];
//        [self.promoteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        self.promoteButton.backgroundColor=[UIColor blueColor];
//        self.promoteButton.layer.cornerRadius=4;
//        self.promoteButton.clipsToBounds=YES;
//        [self addSubview:self.promoteButton];
//        
//        self.toplabel=[[UILabel alloc]init];
//        self.toplabel.frame=CGRectMake(40, 80, 240, 30);
//        self.toplabel.textColor=[UIColor blackColor];
//        self.toplabel.font=[UIFont systemFontOfSize:12];
//        self.toplabel.textAlignment=NSTextAlignmentCenter;
//        self.toplabel.lineBreakMode=NSLineBreakByCharWrapping;
//        self.toplabel.numberOfLines=0;
//        [self addSubview:self.toplabel];
        
        
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
