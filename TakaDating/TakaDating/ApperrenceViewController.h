//
//  ApperrenceViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 27/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApperrenceViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>
{
    int sectionVal;
    NSString * heightStr,* weightStr;
    NSMutableArray * selectedArray;
    UIImageView * imgView;
    CGSize windowSize;
    CGFloat height,row_hh,font_size;
    NSIndexPath * selectedIndex ,* selected2,*selected3;
}
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UIButton *cancelButton,*saveButton;

@property(nonatomic,strong)UITableView * appearenceTable;
@property(nonatomic,strong)NSArray * bodyType,*eyeColor,*hairColor,*height,*weight;
@property(nonatomic,strong)UIPickerView * pickerView;
@property(nonatomic,strong)UITextField * heightText,*weightText;
@property(nonatomic,strong)UIView * pickerBackView,*headerView;;


@end
