//
//  AboutMeViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 28/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutMeViewController : UIViewController<UITextViewDelegate>
{
    CGSize windowSize;
    CGFloat lblFont,height_frm_top;
}

@property(nonatomic)UILabel * titleLabel;
@property(nonatomic)UIButton * cancelButton,*saveButton;
@property(nonatomic)UIScrollView * scrollView;
@property(nonatomic)UITextView * textView;
@property(nonatomic)UIView * headerView;

@end
