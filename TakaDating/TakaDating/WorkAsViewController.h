//
//  WorkAsViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 03/12/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkAsViewController.h"

@interface WorkAsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSArray * incomeArr;
    NSIndexPath * selectedIndex;
    CGSize WindowSize;
    CGFloat height;
    CGFloat cell_font,row_hh;
    UIImageView * access_image;
    NSString * selectedRow;
}
@property(nonatomic)UITableView * workTable;
@property(nonatomic)UILabel * titleLabel;
@property(nonatomic)UIButton * cancelButton,*saveButton;

@end
