//
//  RelationshipViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 28/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RelationshipViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * relationArray,* sexualityArr,* livingArr,*kidsArr,*smokingArr,*drinkingArr,*educationArr;
    NSIndexPath * selectedIndex;
    NSString* selectedRow;
    CGSize windowSize;
    UIImageView * imgView;
    CGFloat height_frm_top,row_hh,cell_font;
}
@property(nonatomic,strong)UITableView * relationTable;
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UIButton *cancelButton,*saveButton;
@property(nonatomic,strong)NSString * titleStr;
@property(nonatomic,assign)int index;
@property(nonatomic)UIActivityIndicatorView * refreshActivityIndicator;


@end
