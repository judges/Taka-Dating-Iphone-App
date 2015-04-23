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
#import <CoreData/CoreData.h>
#import "XMPPFramework.h"

#import "GCDAsyncSocket.h"
#import "XMPP.h"
#import "XMPPLogging.h"
#import "XMPPReconnect.h"
#import "XMPPCapabilitiesCoreDataStorage.h"
#import "XMPPRosterCoreDataStorage.h"
#import "XMPPvCardAvatarModule.h"
#import "XMPPvCardCoreDataStorage.h"

#import "MBProgressHUD.h"

extern NSString *const kXMPPmyJID;
extern NSString *const kXMPPmyPassword;


@interface AppDelegate : UIResponder <UIApplicationDelegate,XMPPStreamDelegate>
{
    XMPPStream *xmppStream;
    XMPPReconnect *xmppReconnect;
    XMPPRoster *xmppRoster;
    XMPPRosterCoreDataStorage *xmppRosterStorage;
    XMPPvCardCoreDataStorage *xmppvCardStorage;
    XMPPvCardTempModule *xmppvCardTempModule;
    XMPPvCardAvatarModule *xmppvCardAvatarModule;
    XMPPCapabilities *xmppCapabilities;
    XMPPCapabilitiesCoreDataStorage *xmppCapabilitiesStorage;
    
    NSString *password;
    
    BOOL customCertEvaluation;
    
    BOOL isXmppConnected;
    
    UIWindow *window;
    
     MBProgressHUD * HUD;
}

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)NSString * accessToken;
- (BOOL)openSessionWithAllowLoginUI:(NSInteger)isLoginReq;
//- (BOOL)openSessionWithLoginUI:(NSInteger)isLoginReq;

@property (nonatomic, strong, readonly) XMPPStream *xmppStream;
@property (nonatomic, strong, readonly) XMPPReconnect *xmppReconnect;
@property (nonatomic, strong, readonly) XMPPRoster *xmppRoster;
@property (nonatomic, strong, readonly) XMPPRosterCoreDataStorage *xmppRosterStorage;
@property (nonatomic, strong, readonly) XMPPvCardTempModule *xmppvCardTempModule;
@property (nonatomic, strong, readonly) XMPPvCardAvatarModule *xmppvCardAvatarModule;
@property (nonatomic, strong, readonly) XMPPCapabilities *xmppCapabilities;
@property (nonatomic, strong, readonly) XMPPCapabilitiesCoreDataStorage *xmppCapabilitiesStorage;

@property(nonatomic,strong)NSMutableDictionary * storeNewMsg;
@property(nonatomic,strong)NSMutableArray * unreadMsgArr;

- (NSManagedObjectContext *)managedObjectContext_roster;
- (NSManagedObjectContext *)managedObjectContext_capabilities;

- (BOOL)connect;
- (void)disconnect;


-(NSString*)appearanceDrinking:(NSString*)dict;
-(NSString*)appearanceEducation:(NSString*)dict;
-(NSString*)appearanceSmoking:(NSString*)dict;
-(NSString*)appearanceKids:(NSString*)dict;
-(NSString*)appearanceLving:(NSString*)dict;
-(NSString*)appearanceRelationShip:(NSString*)dict;
-(NSString*)appearancesexuality:(NSString*)dict;
-(NSString*)appearanceBodyType:(NSString*)dict;
-(NSString*)appearanceHairColor:(NSString*)dict;
-(NSString*)appearanceEyeColor:(NSString*)dict;
-(NSString*)appearanceIncome:(NSString*)dict;

-(void)reacheabilit;

-(void)getAllFacebookInfo:(id)sender;


-(void) showHUDLoadingView:(NSString *)strTitle;
-(void) hideHUDLoadingView;
-(void)showToastMessage:(NSString *)message;
+(AppDelegate *)sharedAppDelegate;
@end
