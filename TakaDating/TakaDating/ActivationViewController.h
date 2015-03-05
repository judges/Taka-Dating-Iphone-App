//
//  ActivationViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 05/12/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivationViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic) UILabel *titleLabel,*userLabel,*passwordLabel,* activationLabel;
@property (nonatomic) UIButton *cancelButton;
@property(nonatomic)UITextField * userText,*passwordText,*activationKey;

@end
