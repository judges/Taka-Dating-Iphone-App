//
//  ISpeakLanguageViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 12/01/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectClassCell.h"
@interface ISpeakLanguageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    UITableView * selectLanguageTbale;
    CGSize  win;
    NSArray * languageArray;
    CGFloat height,row_hh,table_hh;
    CGFloat font_size;
    NSString * select_image,* select_image_act;
    NSMutableString * language;
    NSArray *  langName;
}
@property(nonatomic)UIView * headerView;
@property(nonatomic)UILabel * titleLabel;
@property(nonatomic)UIButton * cancelButton,* saveButton;
@property(nonatomic)UIPickerView * langaugePicker;
@property(nonatomic)NSMutableArray * selectedArray,* names;



@end
