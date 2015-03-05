//
//  IntermediateViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 08/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface IntermediateViewController : UIViewController<UIActionSheetDelegate>
{
   CGFloat font_size,privacy_font;
}
@property (nonatomic, assign) CGSize windowSize;
@property (nonatomic) UIButton *facebook_btn;
@property (nonatomic) UIButton *other_option_btn;
@property (nonatomic) UIActionSheet *optionActionSheet;

@end
