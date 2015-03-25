//
//  RefillCreditsViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 05/03/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayPalMobile.h"

@interface RefillCreditsViewController : UIViewController<PayPalPaymentDelegate>
{
    NSNumber * total;
    CGSize windowSize;
    NSString * oneMonth,* threeMonth,* sixMonth, *oneYear;
    NSString * continent,*desc,*amount,* status,*created_at,*paypal_id;
}
@property(nonatomic)UILabel * titleLabel,*creditsLabel;
@property(nonatomic)UIButton * cancelButton;
@property(nonatomic)UIButton * threeMonths ,*sixMonths,*oneMonths,*oneYear;
@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;
@property(nonatomic, assign, readwrite) BOOL acceptCreditCards;
@property(nonatomic, strong, readwrite) IBOutlet UIView *successView;

@end
