//
//  CustomMenuViewController.h
//  MOVYT
//
//  Created by Sumit Ghosh on 27/05/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsViewController.h"
#import "EncounterFilterViewController.h"

@interface CustomMenuViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    BOOL editVisitors,editMessage,editFavorite,editLike;
    BOOL selectVisitors,selectMessage,selectFavorite,selectLike;
    NSArray * menuImgArr,* sectionArr;
    NSMutableArray * imagesArr;
}

@property(nonatomic,strong)UINavigationController * nav;
@property (nonatomic, assign) CGFloat screen_height;



@property (nonatomic, strong) UIButton *menuButton;
@property (nonatomic, strong) UILabel *headerTitleLabel;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *contentContainerView;
@property (nonatomic, strong) UILabel *menuLabel;
@property (nonatomic, strong) UITableView *menuTableView;
@property (nonatomic, strong) UILabel *secondHeaderLabel;



@property (nonatomic, copy) NSArray *viewControllers;
@property (nonatomic, strong) NSArray *secondSectionViewControllers;
@property (nonatomic, assign) NSInteger numberOfSections;

@property (nonatomic, copy) UIViewController *selectedViewController;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) NSInteger selectedSection;

@property (nonatomic, strong) UIView *mainsubView;

@property (nonatomic, strong) UISwipeGestureRecognizer *swipeGesture;

@property(nonatomic)UIButton * setting,* filter1,*filter2,*edit,*cancel,*select,* deselect;

-(NSArray *) getAllViewControllers;
@end

@interface UIViewController (CustomMenuViewControllerItem)

@property (nonatomic, strong) CustomMenuViewController *customMenuViewController;
//-(CustomMenuViewController *)firstAvailableViewController;
@end
