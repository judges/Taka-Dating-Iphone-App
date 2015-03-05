//
//  EncounterFilterViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 29/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "EncountersViewController.h"

@interface EncounterFilterViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    AppDelegate * appdelegate;
    UIPickerView * pickerView;
    NSArray * age1,*age2;
    NSString * heightStr,* weightStr,*combineStr;
    NSIndexPath * selectedIndex,*index2;
    CGSize windowSize;
    CGFloat height,row_hh,font_size;
    int selectedRowOne,selectedRowTwo;
}

@property(nonatomic)UITableView * filterTable;
@property(nonatomic)UILabel * titleLabel;
@property(nonatomic)UIButton * cancelButton,*find;
@property(nonatomic)UITextField * textFiled;
@property(nonatomic)UIView * pickerBackView;
@property(nonatomic,strong) NSString * hereFor,*sex,*withWhom;
@property(nonatomic,strong)UIActivityIndicatorView * refreshActivityIndicator;
@end
