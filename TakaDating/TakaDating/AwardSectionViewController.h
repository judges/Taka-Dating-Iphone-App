//
//  AwardSectionViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 14/03/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AwardSectionViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    CGSize windowSize;
    CGFloat height;
    UITableView * awardTbl;
    BOOL likesAward,viewsAward;
}
@property(nonatomic)UILabel * titleLabel;
@property(nonatomic)UIButton * cancelButton;

@end
