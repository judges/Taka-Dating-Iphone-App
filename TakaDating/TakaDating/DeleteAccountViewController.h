//
//  DeleteAccountViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 02/12/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface DeleteAccountViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UIScrollView *  scroll;
    UITextField * option;
    NSIndexPath * selectedIndex;
}

@property(nonatomic)UITableView * deleteTable;
@property(nonatomic)UILabel *titleLabel;
@property(nonatomic)UIButton * cancelButton;
@end
