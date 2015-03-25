//
//  FBPhotoPickerViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 31/12/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddPhotoViewCell.h"
#import "AppDelegate.h"

@interface FBPhotoPickerViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
{
    CGSize size;
}
@property(nonatomic,strong)UICollectionView * mainCollectionView;
@property(nonatomic)UILabel * titleLabel;
@property(nonatomic)UIButton * cancelButton,*saveButton;

@property(nonatomic)UIView * headerView;
@end
