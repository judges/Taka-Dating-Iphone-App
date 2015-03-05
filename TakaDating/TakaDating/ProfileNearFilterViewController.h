//
//  ProfileNearFilterViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 04/12/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ProfileNearFilterViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    AppDelegate * appdelegate;
    UIPickerView * pickerView;
    NSArray * age1,*age2,*distancearr;
    NSString * heightStr,* weightStr,*combineStr;
    NSIndexPath * selectedIndex,*index2;
    CGSize windowSize;
    CGFloat row_hh,font_size,height;
    NSMutableDictionary * dict,*geoDict,*locationDict;
    NSString * log,*lat;
    BOOL searchRslt,findPressed;
    int selectedRow,numberofComp, selectedRowSecOne, selectedRowSecTwo;
    NSString *age,*distance;;
    
}

@property(nonatomic)UITableView * filterTable;
@property(nonatomic)UILabel * titleLabel;
@property(nonatomic)UIButton * cancelButton,*find;
@property(nonatomic)UITextField * textFiled,* placeTextFiled,*distanceTxtField;
@property(nonatomic)UIView * pickerBackView;
@property(nonatomic,strong)NSMutableArray * logAndLat,*placeName;


@end
