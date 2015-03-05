//
//  MessagesViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 30/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageTableViewCell.h"

@interface MessagesViewController : UIViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
{
    BOOL editbuttonSelect,selectAll;
    NSMutableArray *nameArr;
    CGFloat row_hh,secHeight;
    CGSize  windowSize;
}


@property(nonatomic)UISearchBar * searchbar;
@property(nonatomic)UISegmentedControl * segment;
@property(nonatomic)UITableView * messageTable;
@end
