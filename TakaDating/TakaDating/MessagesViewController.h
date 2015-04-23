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



@interface MessagesViewController : UIViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate,UITextFieldDelegate>

{
    BOOL editbuttonSelect,selectAll,online,completion,search,unread;
    NSMutableArray *nameArr;
    CGFloat row_hh,secHeight,fontSize;
    CGSize  windowSize;
    NSFetchedResultsController *fetchedResultsController;
    UITextField *    buddyField;
    NSMutableArray * profileImage, * userName,* userId;
    UITextField * searchBar;
    NSArray * searchResults;
    NSMutableArray * searchImages,* searchIds,*unreadMsg,* unreadMsgId ,* unreadUserId,* unreadProfileImg,*unreadUserName;
   

}


@property(nonatomic)UISearchBar * searchbar;
@property(nonatomic)UISegmentedControl * segment;
@property(nonatomic)UITableView * messageTable;
@property(nonatomic,strong)UIActivityIndicatorView * refreshActivity;
@end
