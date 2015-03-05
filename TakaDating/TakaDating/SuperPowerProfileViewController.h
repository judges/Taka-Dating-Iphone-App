//
//  SuperPowerProfileViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 06/12/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SuperPowerFreeViewController.h"


@interface SuperPowerProfileViewController : UIViewController
{
    AppDelegate * appdalegate;
    CGSize windowSize;
    SuperPowerFreeViewController * spFree;
    
}

@property(nonatomic)UILabel * titleLabel;
@property(nonatomic)UIButton * cancelButton;


@end
