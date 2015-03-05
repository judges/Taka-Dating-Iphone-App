//
//  AddInterestViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 26/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddInterestTableViewCell.h"

@interface AddInterestViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    CGSize windowSize;
    NSMutableArray * subData;
    
}
@property(nonatomic)UITableView * addInterestTable;
@property(nonatomic,strong)UISearchBar *searchbar;
@property(nonatomic,strong)NSArray * tableData;
@property(nonatomic,assign)int indexValue;
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UIButton *cancelButton,* saveButton;
@property(nonatomic,strong)NSArray * subArray,*intr_id_arr;
@property(nonatomic)NSMutableArray * selectedArray;

@end
