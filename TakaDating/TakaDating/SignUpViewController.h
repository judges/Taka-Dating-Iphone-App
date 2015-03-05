//
//  SignUpViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 08/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddPhotoViewController.h"

#import "MessagesViewController.h"
#import "VisitorsViewController.h"

@interface SignUpViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate, UIPickerViewDataSource,UIPickerViewDelegate,NSURLConnectionDelegate>
{
    BOOL radioBtnSelect;
    NSString* radiobutton;
    CGSize windowSize;
    NSMutableData * responseData;
}

@property (nonatomic, assign) CGSize windowSize;


@property (nonatomic) UILabel *titleLabel,* LookingforLabel,*termsAndCondtionLabel;
@property (nonatomic) UIButton *cancelButton,*UIButton ,* dateBtn,*im_here_tooBtn,* radioButtonGirl,* radioButtonBoy,*letsGo;
@property(nonatomic)UIDatePicker * datePick,*datePick1;
@property(nonatomic)UIView * tabView,* bottomView;
@property(nonatomic)UITextField  *nameText,*emailText,* passwordText;
@property(nonatomic)BOOL selectOption,dateSelect,radio_Select;
@property(nonatomic)UIPickerView * pickerView;
@property(nonatomic,strong)NSArray * pickerViewArray,*pickerViewImages;
@property(nonatomic,strong)NSString* url;
@property(nonatomic)CALayer * layer;
@property(nonatomic)UIImageView *looking_for_male,* looking_for_female;

@property(nonatomic,strong) NSString * locationName,*pickerstr,*dateString;
@end
