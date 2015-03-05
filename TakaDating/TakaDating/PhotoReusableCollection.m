//
//  PhotoReusableCollection.m
//  TakaDating
//
//  Created by Sumit Ghosh on 05/12/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "PhotoReusableCollection.h"

@implementation PhotoReusableCollection

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
        CGFloat font_size;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
                self.headerTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height-25, frame.size.width, 25)];
            self.headerTitleLabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"header_ipad.png"]];
            font_size=20;
        }
        else{
            self.headerTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height-25, frame.size.width, 25)];
             self.headerTitleLabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"header.png"]];
            font_size=13;
        }
        // self.headerTitleLabel.backgroundColor = [UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
        
       
       // self.headerTitleLabel.backgroundColor=[UIColor clearColor];
        self.headerTitleLabel.textColor = [UIColor whiteColor];
        self.headerTitleLabel.font = [UIFont boldSystemFontOfSize:font_size];
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
