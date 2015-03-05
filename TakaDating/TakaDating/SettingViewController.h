//
//  SettingViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 17/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>
{
    CGSize windowSize;
    CGFloat cell_hh,cell_font;
}

@property(nonatomic,strong)UITableView * settingsTableView;
@property(nonatomic)UILabel *titleLabel,*emailLabel;
@property(nonatomic)UIButton * cancelButton;
@property(nonatomic,strong)UINavigationController * nav;
@end
