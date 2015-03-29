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
#import "PayPalMobile.h"

@interface SuperPowerViewController : UIViewController<PayPalPaymentDelegate>
{
     NSNumber * total;
    AppDelegate * appdalegate;
    SuperPowerFreeViewController * spFree;
    NSString * continent,*desc,*amount,* status,*created_at,*paypal_id;
}

@property(nonatomic)UILabel * titleLabel;
@property(nonatomic)UIButton * cancelButton;


@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;
@property(nonatomic, assign, readwrite) BOOL acceptCreditCards;
@property(nonatomic, strong, readwrite) IBOutlet UIView *successView;
-(id)initWithFrame:(CGRect)frame;
@end
