//
//  BasicInfoViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 15/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicInfoViewController : UIViewController<UITextFieldDelegate>
{
   int radiobutton;
    CGSize windowSize;
    CGFloat font_size;
    NSString * img_normal,* img_active;
}
@property(nonatomic)UILabel * nameLabel,* birthdayLabel,* genderLabel,* titleLabel;
@property(nonatomic)UITextField * nameText;
@property(nonatomic)UIDatePicker * datePick;
@property(nonatomic)UIButton * cancelButton,*birthdayButton,*radioButtonGirl,* radioButtonBoy,* saveButton;
@property(nonatomic)UIView * tabView;
@property(nonatomic)BOOL dateSelect;
@end
