//
//  AppDelegate.h
//  TakaDating
//
//  Created by Sumit Ghosh on 08/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "SingletonClass.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>


@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)NSString * accessToken;
- (BOOL)openSessionWithAllowLoginUI:(NSInteger)isLoginReq;
//- (BOOL)openSessionWithLoginUI:(NSInteger)isLoginReq;
@end
