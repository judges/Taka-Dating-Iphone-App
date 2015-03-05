//
//  AccountSignOutViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 15/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeleteAccountViewController.h"
#import "AppDelegate.h"

@interface AccountSignOutViewController : UIViewController<UIActionSheetDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    DeleteAccountViewController * deleteVC;
     AppDelegate * appdelegate;
    CGSize windowSize;
    CGFloat height;
    CGFloat font_sz;
    UIImage * next_question;
}
@property(nonatomic)UILabel * signOutLabel,* emailIdLabel,*titleLabel;
@property(nonatomic)UIButton * signOutButton,*deleteAccountButton,*cancelButton;
@property(nonatomic)UIButton * changePassword,*fogotPassword,* changeEmail;
@property(nonatomic)UIScrollView * scrollView;
@property(nonatomic)UIActionSheet * actionSheet;
@property(nonatomic) UIView * changePassowrdView,*displayView;
@property(nonatomic,strong)UITextField * pasword,*oldPassword,*emailText,* newemailText;
@end
