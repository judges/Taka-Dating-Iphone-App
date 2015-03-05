//
//  SignInViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 08/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountInfoViewController.h"
#import  "ProfileViewController.h"
#import "MessagesViewController.h"
#import  "VisitorsViewController.h"

@interface SignInViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate,NSURLConnectionDelegate>
{
    id parse;
    CGSize windowSize;
    NSString * blueLine,* grayLine;
    CAGradientLayer * glayer;
    NSMutableData *responseData;
}

@property (nonatomic) UILabel *titleLabel,*userLabel,*passwordLabel;
@property (nonatomic) UIButton *cancelButton;
@property(nonatomic)UITextField * userText,*passwordText;
@property (nonatomic, strong) UIActivityIndicatorView *refreshActivityIndicator;
@end
