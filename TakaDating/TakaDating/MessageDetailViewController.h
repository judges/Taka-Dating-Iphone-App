//
//  MessageDetailViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 30/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  "ProfileViewController.h"

@interface MessageDetailViewController : UIViewController


@property(nonatomic,strong)NSString * titleStr;
@property(nonatomic)UILabel * titleLabel;
@property(nonatomic)UIButton * cancelButton,*profileButton;
@end
