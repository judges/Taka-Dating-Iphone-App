//
//  FeedBackViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 18/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellSelectionViewController.h"

@interface FeedBackViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>
{
     CGSize windowSize;
    CGFloat cell_hh,cell_font;
}

@property(nonatomic)UILabel * titleLabel;
@property(nonatomic)UIButton * cancelButton;
@property(nonatomic)UITableView * feedbackTable;
@end
