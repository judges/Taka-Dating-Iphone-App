//
//  UserProfileViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 29/01/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserProfileViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UILabel * imageCount;
    UIScrollView * imageScroll;
    CGSize windowSize;
     CGFloat row_hh,height;
     
}


@property(nonatomic)UILabel * titleLabel;
@property(nonatomic)UIButton *  cancelButton;
@property(nonatomic,strong)UIView *parentView, *tabView,*bottomView,*firstView;
@property(nonatomic,strong)UITableView * profileTableView,* creditsTableView,* superPowerTableView;
@property(nonatomic)BOOL animation,state;
@property(nonatomic,assign)NSInteger selectedIndex;
@property(nonatomic,strong)NSArray * sectionTwoData,*sectionTwoImages;
@property(nonatomic,strong)UISwipeGestureRecognizer * swipe;
@property (nonatomic, assign) CGFloat screen_width;
@property(nonatomic)UIView * secondView;
@property(nonatomic,assign)int index;
@end
