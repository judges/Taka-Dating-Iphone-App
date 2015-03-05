//
//  SuperPowerViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 03/12/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SuperPowerFreeViewController.h"

@interface SuperPowerViewController : UIViewController
{
    AppDelegate * appdalegate;
    SuperPowerFreeViewController * spFree;
}

@property(nonatomic)UILabel * titleLabel;
@property(nonatomic)UIButton * cancelButton;

-(id)initWithFrame:(CGRect)frame;
@end
