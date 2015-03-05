//
//  AccountInfoViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 11/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsViewController.h"
#import "CreditsCustomCell.h"

@interface AccountInfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic)UIButton * settingButton;
@property(nonatomic)UILabel * titleLabel,* addPhotoLabel;
@property(nonatomic,strong)UITableView * profileTableView,*creditsTableView;
@property(nonatomic,strong)UIView * tabView,* profileView;
@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,strong)UITabBarController * tabBarController;

@end
