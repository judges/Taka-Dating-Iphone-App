//
//  AddphotosViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 29/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "AFNHelper.h"



@interface AddphotosViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIWebViewDelegate>
{
    NSArray * photoarr,* photoPathArr;
    UIImage * img;
    UIWebView * webView;
    NSMutableArray * urlParts;
    int count;
    CGSize windowSize;
    CGFloat height,row_hh,font_size;
    
}
@property(nonatomic,strong)UITableView * addPhotoTable;
@property(nonatomic)UILabel * titleLabel;
@property(nonatomic)UIButton * cancelButton;
@property(nonatomic)UIImagePickerController * imagePicker;
@property(nonatomic)UIActivityIndicatorView * activityView;

@end
