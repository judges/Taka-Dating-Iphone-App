//
//  MessagesViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 30/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageTableViewCell.h"
#import <CoreData/CoreData.h>
#import "XMPPFramework.h"
#import "DDLog.h"
#import "AppDelegate.h"



@interface MessagesViewController : UIViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate>

{
    BOOL editbuttonSelect,selectAll,online;
    NSMutableArray *nameArr;
    CGFloat row_hh,secHeight;
    CGSize  windowSize;
    NSFetchedResultsController *fetchedResultsController;
    UITextField *    buddyField;

}


@property(nonatomic)UISearchBar * searchbar;
@property(nonatomic)UISegmentedControl * segment;
@property(nonatomic)UITableView * messageTable;
@end
