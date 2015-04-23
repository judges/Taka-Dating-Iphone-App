//
//  ViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 08/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountInfoViewController.h"
#import  "ProfileViewController.h"
#import "MessagesViewController.h"
#import  "VisitorsViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<UIActionSheetDelegate,CLLocationManagerDelegate>
{
    id parse;
    NSMutableData *responseData;
     UITextField * locationTextField;
}
@property (nonatomic, assign) CGSize windowSize;
@property (nonatomic) UIButton *facebook_btn;
@property (nonatomic) UIButton *other_option_btn;
@property(nonatomic,strong) CLLocationManager * manager1;
@property(nonatomic)NSString * Area,*CountryArea,* longitude,* lattitude;

-(void)getAllDataFromService;
-(void)getAllChatHistory;
@end
