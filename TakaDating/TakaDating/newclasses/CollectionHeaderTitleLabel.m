//
//  CollectionHeaderTitleLabel.m
//  TakaDating
//
//  Created by GBS-ios on 11/12/14.
//  Copyright (c) 2014 Globussoft. All rights reserved.
//

#import "CollectionHeaderTitleLabel.h"

@implementation CollectionHeaderTitleLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
       
      
        
        
        self.headerTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height-25, frame.size.width, 25)];
       // self.headerTitleLabel.backgroundColor = [UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
           // self.headerTitleLabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"header_ipad.png"]];
             self.headerTitleLabel.backgroundColor= [UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)10/255 blue:(CGFloat)211/255 alpha:1.0];
            font_size=20;
        }
        else{
            font_size=14;
           // self.headerTitleLabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"header.png"]];
             self.headerTitleLabel.backgroundColor= [UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)10/255 blue:(CGFloat)211/255 alpha:1.0];
        }
        self.headerTitleLabel.textColor = [UIColor whiteColor];
        self.headerTitleLabel.font = [UIFont systemFontOfSize:font_size];
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
