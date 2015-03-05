//
//  ProfileViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 13/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsViewController.h"

@interface ProfileViewController : UIViewController<UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic)UIButton * settingButton;
@property(nonatomic)UILabel * titleLabel,* addPhotoLabel;
@property(nonatomic,strong)UIView *parentView, *tabView,*bottomView,*firstView;
@property(nonatomic,strong)UITableView * profileTableView,* creditsTableView,* superPowerTableView;
@property(nonatomic)BOOL animation,state;
@property(nonatomic,assign)NSInteger selectedIndex;

@end
