//
//  PrivacyViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 17/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingletonClass.h"

@interface PrivacyViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    CGSize w;
    NSString *  radiobutton,*radiobuttonDis;
    NSString *   radiobuttonView,*radioButtonSecurity;
    NSString *  radioButtonSrch,*radiobuttonFind;
    NSString * radiobuttonBrowsing;
    UIScrollView * scroll;
    CGFloat head_label_font,choise_font;
}
@property(nonatomic)UILabel * titleLabel;
@property(nonatomic)UIButton * cancelButton,* saveButton,*editButton;
@property(nonatomic)UITableView * privacyTableView;
//@property(nonatomic)UISwitch * switch1,* switch2,*switch3,* switch4;
@property(nonatomic)UIButton * radioButtonStatusY,* radioButtonStatusN;
@property(nonatomic)UIButton * radioButtonDisY,* radioButtonDisN;
@property(nonatomic)UIButton * radioButtonViewY,* radioButtonViewN;
@property(nonatomic)UIButton * radioButtonSecurityY,* radioButtonSecurityN,* radioButtonSecurityM;
@property(nonatomic)UIButton * radioButtonbrowY,* radioButtonbrowN;

@property(nonatomic)UIButton * radioButtonSrchY,* radioButtonSrchN,*radioButtonFindY,*radioButtonFindN ;

@end
