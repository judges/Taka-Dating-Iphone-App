//
//  AddPhotoViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 10/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPhotoViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic)UILabel * titleLabel;
@property(nonatomic)UIImageView * imageView;
@property(nonatomic)UIButton * cancelButton;
@property(nonatomic)UIImagePickerController * imagePicker;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * imageArray;
@end
