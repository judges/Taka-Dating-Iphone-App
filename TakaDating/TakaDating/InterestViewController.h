//
//  InterestViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 26/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InterestTableViewCell.h"
#import "AddInterestViewController.h"

@interface InterestViewController : UIViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSArray * interests_iphone,* interests_ipad;
    id parse;
    NSArray * subArray;
    CGSize windowSize;
    CGFloat height,row_hight;
}

@property(nonatomic)NSArray * mostPopular,* browseByCat;
@property(nonatomic,strong)UISearchBar * searchbar;
@property(nonatomic)UITableView * intersetTable;
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UIButton *cancelButton;

@property(nonatomic,strong)NSMutableArray * intr_cat_id,* intr_id,* intr_name;

@end
