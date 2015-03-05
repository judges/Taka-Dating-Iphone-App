//
//  FavoritViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 04/12/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionHeaderTitleLabel.h"
#import "CustomCellView.h"
#import "CustomProfileView.h"

@interface FavoritViewController : UIViewController< UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIActionSheetDelegate>
{
    UILabel *textLabel;
    CollectionHeaderTitleLabel *reuseableView;
    BOOL isProfilePic,selectAll,editAll;
    CGSize windowSize;
    NSMutableArray * sex,* imageCount,* isOnline,*displayName,*useriId,*thumbanailUrl;
    NSMutableArray  * sexUser,* imageCountUser,* isOnlineUser,*displayNameUser,*useriIdUser,*thumbanailUrlUser;
    NSMutableArray * cellSelectedArr;
    UIButton * toggleButton;
}
@property (nonatomic) UIScrollView *scrollView;
@property(nonatomic,strong)UIImageView * imgView;
@property (nonatomic) UICollectionView *mainCollectionView;
@property (nonatomic, strong) NSArray *topCollectionArray;
@property (nonatomic, strong) NSArray *mainDataCollectionArray;
@property(nonatomic,strong)UIButton *promoteButton,*addPhotoButton,*secaddPhotoButton,*findFirends;
@property (nonatomic, strong)  UILabel *toplabel,*secTopLabel,*thirdTopLabel;
@property(nonatomic,strong)UIActivityIndicatorView * refreshActivityIndicator;

@end
