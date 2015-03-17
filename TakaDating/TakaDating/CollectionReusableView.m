//
//  CollectionReusableView.m
//  TakaDating
//
//  Created by Globussoft 1 on 12/1/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "CollectionReusableView.h"

@implementation CollectionReusableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
            // Initialization code
        
        self.backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 100)];
        self.backView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.backView];
        
        self.headerTitleLabel = [[UILabel alloc] init];
        self.headerTitleLabel.frame =CGRectMake(20, 30, frame.size.width-50, 30);
        self.headerTitleLabel.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
        self.headerTitleLabel.textColor = [UIColor blackColor];
        self.headerTitleLabel.lineBreakMode=NSLineBreakByCharWrapping;
        self.headerTitleLabel.numberOfLines=0;
        self.headerTitleLabel.font = [UIFont systemFontOfSize:12];
        self.headerTitleLabel.textAlignment=NSTextAlignmentCenter;
        [self.backView addSubview:self.headerTitleLabel];
        
        self.bottomLabel = [[UILabel alloc] init];
        self.bottomLabel.frame=CGRectMake(20, 55, frame.size.width-50, 20);
        self.bottomLabel.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
        self.bottomLabel.textColor = [UIColor blackColor];
        self.bottomLabel.numberOfLines=0;
        self.bottomLabel.lineBreakMode=NSLineBreakByCharWrapping;
        self.bottomLabel.font = [UIFont boldSystemFontOfSize:13];
         self.bottomLabel.textAlignment=NSTextAlignmentCenter;
        [self.backView addSubview:self.bottomLabel];
        
        
        self.footerTitleLabel = [[UILabel alloc] init ];
        self.footerTitleLabel.frame=CGRectMake(20, 40, frame.size.width-50, 30);
        self.footerTitleLabel.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
        self.footerTitleLabel.textColor = [UIColor blackColor];
        self.footerTitleLabel.lineBreakMode=NSLineBreakByCharWrapping;
        self.footerTitleLabel.numberOfLines=0;
        self.footerTitleLabel.font = [UIFont systemFontOfSize:12];
        self.footerTitleLabel.textAlignment=NSTextAlignmentCenter;
            [self.backView addSubview:self.footerTitleLabel];
        
        self.footerButton=[[UIButton alloc]init];
        self.footerButton.frame=CGRectMake(80, 0,167, 30);
            //  self.footerButton.backgroundColor=[UIColor blueColor];
            //  [self.footerButton setTitle:@"GO!" forState:UIControlStateNormal];
        self.footerButton.layer.cornerRadius=4;
        self.footerButton.clipsToBounds=YES;
            [self addSubview:self.footerButton];
        
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            self.headerTitleLabel.frame =CGRectMake(20, 50, frame.size.width-40, 40);
            self.bottomLabel.frame=CGRectMake(20, 80, frame.size.width-50, 20);
             self.footerTitleLabel.frame=CGRectMake(20, 60, frame.size.width-50, 30);
              self.footerButton.frame=CGRectMake(frame.size.width/2-60, 10, 167, 30);
            
            self.headerTitleLabel.font = [UIFont systemFontOfSize:20];
             self.bottomLabel.font = [UIFont boldSystemFontOfSize:20];
            self.footerTitleLabel.font = [UIFont systemFontOfSize:20];
        }

    }
    return self;
}


@end
