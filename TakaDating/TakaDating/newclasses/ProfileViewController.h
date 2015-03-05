//
//  ProfileViewController.h
//  TakaDating
//
//  Created by GBS-ios on 11/10/14.
//  Copyright (c) 2014 Globussoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperPowerViewController.h"
#import "SuperPowerProfileViewController.h"
#import "ProfileableViewCell.h"
#import "RefillCreditsViewController.h"

@interface ProfileViewController : UIViewController<UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    UIScrollView * imageScroll;
    UILabel * imageCount;
    SuperPowerViewController * superPower;
    SuperPowerProfileViewController * superPowerProfile;
    BOOL facebookVerify,spVerify,viewAppear;
    CGSize windowSize;
    CGFloat row_hh,credts_hh,font_size;
}

@property(nonatomic)UIButton * settingButton;
@property(nonatomic)UILabel * titleLabel,* addPhotoLabel;
@property(nonatomic,strong)UIView *parentView, *tabView,*bottomView,*firstView;
@property(nonatomic,strong)UITableView * profileTableView,* creditsTableView,* superPowerTableView;
@property(nonatomic)BOOL animation,state;
@property(nonatomic,assign)NSInteger selectedIndex;
@property(nonatomic,strong)NSArray * sectionTwoData,*sectionTwoImages;
@property(nonatomic,strong)UISwipeGestureRecognizer * swipe;
@property (nonatomic, assign) CGFloat screen_width;
@property(nonatomic)UIView * secondView;
@end
