//
//  EncountersViewController.h
//  TakaDating
//
//  Created by GBS-ios on 11/10/14.
//  Copyright (c) 2014 Globussoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EncounterProfileTableViewCell.h"
#import "EncounterFilterViewController.h"

@interface EncountersViewController : UIViewController<UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    UIScrollView * imageScroll;
    UILabel * imageCount;
    CGFloat row_hh;
    CGSize windowSize;
    
    
    UIImageView * imgVw;
    UILabel *  tagLine;
    UIView * view;
    UILabel *  ProfileName;
    NSArray *interests;
    
}

@property(nonatomic)UIButton * settingButton;
@property(nonatomic)UILabel * titleLabel,* addPhotoLabel;
@property(nonatomic,strong)UIView *parentView, *tabView,*bottomView,*firstView;
@property(nonatomic,strong)UITableView * profileTableView,* creditsTableView,* superPowerTableView;
@property(nonatomic)BOOL animation,state,Fromfilter;
@property(nonatomic,assign)NSInteger selectedIndex;
@property(nonatomic,strong)NSArray * sectionTwoData,*sectionTwoImages;
@property(nonatomic,strong)UISwipeGestureRecognizer * swipe;
@property (nonatomic, assign) CGFloat screen_width;
@property(nonatomic)UIView * secondView;
@property(nonatomic,strong)UIActivityIndicatorView* refreshActivityIndicator;


@property(nonatomic,strong)NSString * userHereFor,*sex,*appearance;
@property(nonatomic,strong) NSString * useriId,*income,*languages,*profession,*sexuality,*relationship,*eduaction,*drinking,*smoking,*kids,*living,*weight,*height,*bodyType,*about,*interestedIn,*displayName,*location,*hairColor,*eyeColor,*intrests,*imageId;;
@end
