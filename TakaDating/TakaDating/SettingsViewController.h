//
//  SettingsViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 11/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    CGSize windowSize;
}

@property(nonatomic)UILabel *titleLabel;
@property(nonatomic)UIButton * cancelButton;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * cellValues;
@end
