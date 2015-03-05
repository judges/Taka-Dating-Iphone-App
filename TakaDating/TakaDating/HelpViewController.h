//
//  HelpViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 20/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HelpCustomTableViewCell.h"

@interface HelpViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    NSInteger currentSelection;
    CAGradientLayer *layer;
    int i;
}

@property(nonatomic)UILabel *titleLabel;
@property(nonatomic)UIButton * cancelButton;
@property(nonatomic)UITableView * helpTableView,*sectionTable;
@property(nonatomic)NSArray * tableData,* secTblData;
@property(nonatomic)UISearchBar * searchbar;
@end
