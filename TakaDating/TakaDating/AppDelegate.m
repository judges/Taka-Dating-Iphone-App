//
//  AppDelegate.m
//  TakaDating
//
//  Created by Sumit Ghosh on 08/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"
#import "GCDAsyncSocket.h"
#import "XMPP.h"
#import "XMPPLogging.h"
#import "XMPPReconnect.h"
#import "XMPPCapabilitiesCoreDataStorage.h"
#import "XMPPRosterCoreDataStorage.h"
#import "XMPPvCardAvatarModule.h"
#import "XMPPvCardCoreDataStorage.h"

#import "DDLog.h"
#import "DDTTYLogger.h"

#import "SingletonClass.h"
#import "EncountersViewController.h"
#import <CFNetwork/CFNetwork.h>
#import "PayPalMobile.h"
#import "MessageDetailViewController.h"


#import <NewRelicAgent/NewRelic.h>

@class MessageDetailViewController;
// Log levels: off, error, warn, info, verbose
#if DEBUG
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
static const int ddLogLevel = LOG_LEVEL_INFO;
#endif

NSString *const kXMPPmyJID = @"kXMPPmyJID";
NSString *const kXMPPmyPassword = @"kXMPPmyPassword";

@interface AppDelegate()
{
    MessageDetailViewController * mdVC;
    
}

- (void)setupStream;
- (void)teardownStream;

- (void)goOnline;
- (void)goOffline;

@end



@implementation AppDelegate

@synthesize xmppStream;
@synthesize xmppReconnect;
@synthesize xmppRoster;
@synthesize xmppRosterStorage;
@synthesize xmppvCardTempModule;
@synthesize xmppvCardAvatarModule;
@synthesize xmppCapabilities;
@synthesize xmppCapabilitiesStorage;

@synthesize window;



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //[NewRelicAgent startWithApplicationToken:@"AAf51ed5e2c602336259adc6f4c8404770ec806ea1"];
    
    self.storeNewMsg=[[NSMutableDictionary alloc]init];
    self.unreadMsgArr=[[NSMutableArray alloc]init];
   // [NewRelicAgent disableFeatures:NRFeatureFlag_CrashReporting];
       [self reacheability];
   
    // Configure logging framework
    
    [DDLog addLogger:[DDTTYLogger sharedInstance] withLogLevel:XMPP_LOG_FLAG_SEND_RECV];
    
    // Setup the XMPP stream
    
    [self setupStream];
    
    [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentProduction : @"",
                                                           PayPalEnvironmentSandbox : @"ASR0bxDIAqjAPLLlPs_echPOSIloTtvLdcQFNelhseLzNKcyqojUdMPOxxOZ"}];
   
    [SingletonClass shareSingleton].messages=[[NSMutableArray alloc]init];
    
    [self reacheability];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"kNetworkReachabilityChangedNotification" object:nil];   
   
    return YES;
}



- (void)dealloc
{
    [self teardownStream];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
    
    // Use this method to release shared resources, save user data, invalidate timers, and store
    // enough application state information to restore your application to its current state in case
    // it is terminated later.
    //
    // If your application supports background execution,
    // called instead of applicationWillTerminate: when the user quits.
    
    DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
    
#if TARGET_IPHONE_SIMULATOR
    DDLogError(@"The iPhone simulator does not process background network traffic. "
               @"Inbound traffic is queued until the keepAliveTimeout:handler: fires.");
#endif
    
    if ([application respondsToSelector:@selector(setKeepAliveTimeout:handler:)])
    {
        [application setKeepAliveTimeout:600 handler:^{
            
            DDLogVerbose(@"KeepAliveHandler");
            
            // Do other keep alive stuff here.
        }];
    }
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
    
    [self teardownStream];
    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    NSLog(@"Url== %@", url);
    return [FBSession.activeSession handleOpenURL:url];
}
#pragma mark- Log in Facebook
- (BOOL)openSessionWithAllowLoginUI:(NSInteger)isLoginReq{
    //First
    //    self.CurrentValue = isLoginReq;
    NSArray *permissions = [[NSArray alloc] initWithObjects:@"public_profile",@"email",@"status_update",@"user_photos",@"user_birthday",@"user_about_me",@"user_friends",@"photo_upload",@"read_friendlists", nil];
    
    FBSession *session = [[FBSession alloc] initWithPermissions:permissions];
    // Set the active session
    [FBSession setActiveSession:session];
    
    [session openWithBehavior:FBSessionLoginBehaviorWithNoFallbackToWebView
            completionHandler:^(FBSession *session,
                                FBSessionState status,
                                NSError *error) {
                
                
                
                if (error==nil) {
                    
                    FBAccessTokenData *tokenData= session.accessTokenData;
                    
                    
                    self.accessToken = tokenData.accessToken;
                    NSLog(@"AccessToken1==%@",self.accessToken);
                    
                    [[NSUserDefaults standardUserDefaults] setObject:self.accessToken forKey:@"accessToken"];
                    
                    
                    
                    [FBRequestConnection
                     startForMeWithCompletionHandler:^(FBRequestConnection *connection,id<FBGraphUser> user,NSError *error){
                         
                         NSString *userInfo = @"";
                         userInfo = [userInfo
                                     stringByAppendingString:
                                     [NSString stringWithFormat:@"Name: %@\n\n",
                                      [user objectForKey:@"id"]]];
                         NSLog(@"userinfo = %@",userInfo);
                         NSLog(@"Name = %@",user.name);
                         [SingletonClass shareSingleton].name= user.name ;
                         
                         NSArray *ary=[userInfo componentsSeparatedByString:@":"];
                         if([ary count]>1){
                             userInfo=[ary objectAtIndex:1];
                             userInfo=[userInfo stringByReplacingOccurrencesOfString:@" " withString:@""];
                             userInfo=[userInfo stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                             NSLog(@"sender id=%@",userInfo);
                             
                             //   NSString *userID = [NSString stringWithFormat:@"%@",[user objectForKey:@"id"]];
                             
                            // [SingletonClass shareSingleton].userID=userInfo;
                             NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large",userInfo]];
                             NSString * urlstr=[NSString stringWithFormat:@"%@",url];
                             NSLog(@"Profile url %@",urlstr);
                             [[NSUserDefaults standardUserDefaults]setObject:urlstr forKey:@"profilePicUrl"];
                             
                             
                             NSString *userName = [NSString stringWithFormat:@"%@",[user objectForKey:@"name"]];
                             
                             [[NSUserDefaults standardUserDefaults] setBool:YES forKey:FacebookConnected];
                             [[NSUserDefaults standardUserDefaults] setObject:userInfo forKey:ConnectedFacebookUserID];
                             [[NSUserDefaults standardUserDefaults] setObject:userName  forKey:@"ConnectedFacebookUserName"];
                             [[NSUserDefaults standardUserDefaults]synchronize];
                             if ([SingletonClass shareSingleton].fetchFBPhoto==YES) {
                                 [[NSNotificationCenter defaultCenter]postNotificationName:@"fetchFbPhoto" object:nil];
                             }
                             else{
                                 
                                 [SingletonClass shareSingleton].facebookId=userInfo;
                                 BOOL check=[self fbIdexistsInDB];
                                 if (!check) {
                                     [self getAllFacebookInfo:user];
                                     [[NSNotificationCenter defaultCenter] postNotificationName:@"signupAction" object:nil];
                                 }
                                 else{
                                     [[NSNotificationCenter defaultCenter] postNotificationName:@"FacebookLogin" object:nil];
                                 }
                             }
                         }
                         
                     }];
                    
                    // [self retriveAllfriends];
                }
                else{
                    
                    NSLog(@"Session not open==%@",error);
                }
                
                // Respond to session state changes,
                // ex: updating the view
            }];
    return YES;
}

#pragma mark- fbIdexistsInDB
-(BOOL)fbIdexistsInDB{
    NSError * error;
    NSURLResponse * urlReponse;
    BOOL returnValue;
 
    NSString * urlStr=[NSString stringWithFormat:@"http://23.238.24.26/authentication/fblogin/"];
    NSURL  * url=[NSURL URLWithString:urlStr];
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    
    NSString * body=[NSString stringWithFormat:@"faceId=%@",[SingletonClass shareSingleton].facebookId];
    [request setHTTPBody:[body
                         dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlReponse error:&error];
    
    if (data==nil) {
        NSLog(@"No data");
        return NO;
    }
    id parse=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"Parse facebook %@",parse);
    if([[parse objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]])
    {
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"signIn"];
    NSDictionary * dict=[parse objectForKey:@"userdata"];
    NSString * loc=[dict objectForKey:@"location"];
    [SingletonClass shareSingleton].location=loc;
    
    NSString * name=[dict objectForKey:@"displayName"];
    [SingletonClass shareSingleton].name=name;
    
    [SingletonClass shareSingleton].bodyType=[NSString stringWithFormat:@"BodyType:%@",[self appearanceBodyType:[dict objectForKey:@"bodyType"]]];
        
        [[NSUserDefaults standardUserDefaults]setObject:[parse objectForKey:@"balance"] forKey:@"credit"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [SingletonClass shareSingleton].superPower=[[dict objectForKey:@"superpower"]intValue];
        
    [SingletonClass shareSingleton].userID=[dict objectForKey:@"userId"];
        
    [SingletonClass shareSingleton ].dob=[dict objectForKey:@"dob"];
    NSLog(@"UserID %@",[SingletonClass shareSingleton].userID);
    
    [SingletonClass shareSingleton].hairColor=[NSString stringWithFormat:@"HairColor:%@",[self appearanceHairColor:[dict objectForKey:@"hairColor"]]];
    
    [SingletonClass shareSingleton].eyeColor=[NSString stringWithFormat:@"EyeColor:%@",[self appearanceEyeColor:[dict objectForKey:@"eyeColor"]]];
    NSLog(@"eyecolor %@",[SingletonClass shareSingleton].eyeColor);
    
    
    [SingletonClass shareSingleton].income=[NSString stringWithFormat:@"Income:%@",[self appearanceIncome:[dict objectForKey:@"income"]]];
    
    
    [SingletonClass shareSingleton].height=[NSString stringWithFormat:@"Height:%@",[dict objectForKey:@"height"]];
    
    
    [SingletonClass shareSingleton].weight=[NSString stringWithFormat:@"Weight:%@",[dict objectForKey:@"weight"]];
    [SingletonClass shareSingleton].appearance=[NSString stringWithFormat:@"%@,%@,%@,%@,%@",[SingletonClass shareSingleton].height,[SingletonClass shareSingleton].weight,[SingletonClass shareSingleton].bodyType,[SingletonClass shareSingleton].hairColor,[SingletonClass shareSingleton].eyeColor];
    NSLog(@" appearance %@",[SingletonClass shareSingleton].appearance);
    [SingletonClass shareSingleton].Living=[NSString stringWithFormat:@"Living:%@",[self appearanceLving:[dict objectForKey:@"living"]]];
    
    [SingletonClass shareSingleton].children=[NSString stringWithFormat:@"Kids:%@",[self appearanceKids:[dict objectForKey:@"kids"]]];
    
    [SingletonClass shareSingleton].smoking=[NSString stringWithFormat:@"Smoking:%@",[self appearanceSmoking:[dict objectForKey:@"smoking"]]];
    
    [SingletonClass shareSingleton].dirinking=[NSString stringWithFormat:@"Drinking:%@",[self appearanceDrinking:[dict objectForKey:@"drinking"]]];
    
    [SingletonClass shareSingleton].education=[NSString stringWithFormat:@"Education:%@",[self appearanceEducation:[dict objectForKey:@"education"]]];
    
    [SingletonClass shareSingleton].relation=[NSString stringWithFormat:@"Relationship:%@",[self appearanceRelationShip:[dict objectForKey:@"relationshipStatus"]]];
    
    //    NSLog(@"Relation %@",[SingletonClass shareSingleton].relation);
    
    [SingletonClass shareSingleton].languages=[dict objectForKey:@"languagesKnown"];
    NSLog(@"Relation %@",[SingletonClass shareSingleton].languages);
    [SingletonClass shareSingleton].sexuality=[NSString stringWithFormat:@"sexuality:%@",[self appearancesexuality:[dict objectForKey:@"education"]]];
    
    [SingletonClass shareSingleton].profession=[NSString stringWithFormat:@"Profession:%@",[dict objectForKey:@"profession"]];
    
    [SingletonClass shareSingleton].aboutMe =[dict objectForKey:@"about"];
    
    
    [SingletonClass shareSingleton].hereFor =[[dict objectForKey:@"hereFor"] intValue];
    
    
    [SingletonClass shareSingleton].sex =[[dict objectForKey:@"sex"]intValue];
    
    
    
    [SingletonClass shareSingleton].interestedIn=[dict objectForKey:@"interestedIn"];
    // NSLog(@"interested in %@",[SingletonClass shareSingleton].interestedIn);
    //Profile setting data
    NSString * profileSetting=[dict objectForKey:@"profileSettings"];
    
    NSString *  data= [profileSetting stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    NSError * error=nil;
    
    NSData * Data=[NSData dataWithBytes:[data UTF8String] length:[data length]];
    NSDictionary * dataDict=[NSJSONSerialization JSONObjectWithData:Data options:NSJSONReadingMutableLeaves error:&error];
    if (data==nil) {
        return NO;
    }
    
    
    NSDictionary * privacy=[dataDict objectForKey:@"privacy"];//privacy information
    NSLog(@"privacy %@", privacy);
    [SingletonClass shareSingleton].onlineStatus=[privacy objectForKey:@"onlineStatus"];
    [SingletonClass shareSingleton].distance=[privacy objectForKey:@"distance"];
    [SingletonClass shareSingleton].viewProfile=[privacy objectForKey:@"viewProfile"];
    [SingletonClass shareSingleton].browsing=[privacy objectForKey:@"browsing"];
    [SingletonClass shareSingleton].securityLevel=[privacy objectForKey:@"securityLevel"];
    [SingletonClass shareSingleton].publicSearch=[privacy objectForKey:@"publicSearch"];
    [SingletonClass shareSingleton].find=[privacy objectForKey:@"find"];
    
    NSDictionary * photosDict=[dataDict objectForKey:@"photos"];
    [SingletonClass shareSingleton].comment=[photosDict objectForKey:@"comment"];
    [SingletonClass shareSingleton].watermark_on=[photosDict objectForKey:@"watermark_on"];
    
    NSDictionary * languageDict=[dataDict objectForKey:@"language"];
    [SingletonClass shareSingleton].language=[languageDict objectForKey:@"language"];
    
    NSString * notification=[dict objectForKey:@"notifications"];
    
    NSString *  newNotification= [notification stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    
    
    NSData * notifyData=[NSData dataWithBytes:[newNotification UTF8String] length:[newNotification length]];
    NSDictionary * emailDict=[NSJSONSerialization JSONObjectWithData:notifyData options:NSJSONReadingMutableLeaves error:&error];
    NSDictionary * email=[emailDict objectForKey:@"Email"];
    NSDictionary * mobile=[emailDict objectForKey:@"Mobile"];
    if (data==nil) {
        return NO;
    }
    
    [SingletonClass shareSingleton].newmsgEmail=[email objectForKey:@"newmsgEmail"];
    [SingletonClass shareSingleton].profvisitEmail=[email objectForKey:@"profvisitEmail"];
    [SingletonClass shareSingleton].alertEmail=[email objectForKey:@"alertEmail"];
    [SingletonClass shareSingleton].peopleEmail=[email objectForKey:@"peopleEmail"];
    [SingletonClass shareSingleton].newsEmail=[email objectForKey:@"newsEmail"];
    [SingletonClass shareSingleton].giftEmail=[email objectForKey:@"giftEmail"];
    [SingletonClass shareSingleton].rateEmail=[email objectForKey:@"rateEmail"];
    [SingletonClass shareSingleton].favEmail=[email objectForKey:@"favEmail"];
    
    // mobile data
    
    [SingletonClass shareSingleton].newmsgMobile=[mobile objectForKey:@"newmsgMobile"];
    [SingletonClass shareSingleton].profvisitMobile=[mobile objectForKey:@"profvisitMobile"];
    [SingletonClass shareSingleton].peopleMobile=[mobile objectForKey:@"peopleMobile"];
    [SingletonClass shareSingleton].alertMobile=[mobile objectForKey:@"alertMobile"];
    [SingletonClass shareSingleton].newsMobile=[mobile objectForKey:@"newsMobile"];
    [SingletonClass shareSingleton].giftMobile=[mobile objectForKey:@"giftMobile"];
    [SingletonClass shareSingleton].rateMobile=[mobile objectForKey:@"rateMobile"];
    [SingletonClass shareSingleton].favMobile=[mobile objectForKey:@"favMobile"];
    
    
    [SingletonClass shareSingleton].InvisibleModeSetting=[dict objectForKey:@"InvisibleModeSetting"];
    [SingletonClass shareSingleton].MessagesSetting=[dict objectForKey:@"MessagesSetting"];
    
    NSArray * imagesArr=[parse objectForKey:@"imagegallery"];
    /*if (imagesArr.count>0) {
        
        
       // NSMutableDictionary * dictImges=[[NSMutableDictionary alloc]init];
        NSMutableArray * dictarr=[[NSMutableArray alloc]init];
        NSMutableArray * arr=[[ NSMutableArray alloc]init];
        
        for (int i=0; i<imagesArr.count; i++) {
            
            dict =[imagesArr objectAtIndex:i];
            if ([[dict objectForKey:@"privacy"]isEqualToString:@"3"]){
                NSString * imageName=[NSString stringWithString:[dict objectForKey:@"imageLink"]];
                [arr addObject:imageName];
                
            }
            else{
                [dictarr addObject:[dict objectForKey:@"imageLink"]];
                NSString * imageName=[NSString stringWithFormat:@"http://taka.dating%@",[dict objectForKey:@"imageLink"]];
                NSLog(@"image Name %@",imageName);
                [arr addObject:imageName];
            }
            
      
        }
        [SingletonClass shareSingleton].userImages =[[NSMutableArray alloc]initWithArray:arr];
    }
    */
    [SingletonClass shareSingleton].profileImg=[parse objectForKey:@"profileimg"];
    
    
  //  NSLog(@"user profile images %@",[SingletonClass shareSingleton].userImages);
   // [SingletonClass shareSingleton].profileImages=(NSArray*)imagesArr;
        returnValue=YES;
}

    else{
        returnValue = NO;
        //return NO;
    }
    return returnValue;
}

#pragma mark- Appearence
    -(NSString *)appearanceBodyType:(NSString *)value{
        NSString * bodyType=@"";
        
        int val= value.intValue;
        if (val==0) {
            bodyType=@"Unfilled yet";
        }
        else if(val==1)
        {
            bodyType=@"Average";
        }
        else if(val==2)
        {
            bodyType=@"A few extra pounds";
        }
        else if(val==3)
        {
            bodyType=@"Slim";
        }
        else if(val==4)
        {
            bodyType=@"Athletic";
        }
        else if(val==5)
        {
            bodyType=@"Muscular";
        }
        else
        {
            bodyType=@"Big and beautiful";
        }
        
        return bodyType;
    }
    
    -(NSString *)appearanceHairColor:(NSString *)value{
        NSString * hairColor=@"";
        
        int val= value.intValue;
        if (val==0) {
            hairColor=@"Unfilled yet";
        }
        else if(val==1)
        {
            hairColor=@"Black";
        }
        else if(val==2)
        {
            hairColor=@"Brown";
        }
        else if(val==3)
        {
            hairColor=@"Red";
        }
        else if(val==4)
        {
            hairColor=@"Grey";
        }
        else if(val==5)
        {
            hairColor=@"White";
        }
        else if(val==6)
        {
            hairColor=@"Shaved";
        }
        else if(val==7)
        {
            hairColor=@"Dyed";
        }
        else
        {
            hairColor=@"Bald";
        }
        
        
        return hairColor;
        
    }
    -(NSString *)appearanceKids:(NSString *)value{
        int val= value.intValue;
        NSString * kids=@"";
        if (val==0) {
            kids=@"Unfilled yet";
        }
        else if(val==1)
        {
            kids=@"No, Never";
        }
        else if(val==2)
        {
            kids=@"Someday";
        }
        else if(val==3)
        {
            kids=@"Already Have";
        }
        else
        {
            kids=@"Empty nest";
        }
        return kids;
    }
    
    -(NSString *)appearanceEyeColor:(NSString *)value{
        NSString * eyeColor=@"";
        
        int val= value.intValue;
        if (val==0) {
            eyeColor=@"others";
        }
        else if(val==1)
        {
            eyeColor=@"Brown";
        }
        else if(val==2)
        {
            eyeColor=@"Grey";
        }
        else if(val==3)
        {
            eyeColor=@"Green";
        }
        else if(val==4)
        {
            eyeColor=@"Blue";
        }
        else if(val==5)
        {
            eyeColor=@"Hazel";
        }
        else
        {
            eyeColor=@"Other";
        }
        
        return eyeColor;
        
    }
    -(NSString *)appearanceIncome:(NSString *)value{
        int val=value.intValue;
        NSString * income=@"";
        if (val==0) {
            income=@"Unfilled yet";
        }
        else if(val==1)
        {
            income=@"Low";
        }
        else if(val==2)
        {
            income=@"Average";
        }
        else
        {
            income=@"High";
        }
        return  income;
    }
    
    -(NSString *)appearanceLving:(NSString *)value{
        NSString * living=@"";
        int val= value.intValue;
        if (val==0) {
            living=@"Unfilled yet";
        }
        else if(val==1)
        {
            living=@"With Parents";
        }
        else if(val==2)
        {
            living=@"With Roomates";
        }
        else if(val==3)
        {
            living=@"Student Residence";
        }
        else if(val==4)
        {
            living=@"With Partner";
        }
        else{
            living=@"Alone";
        }
        return  living;
    }
    -(NSString *)appearanceSmoking:(NSString *)value{
        int val= value.intValue;
        NSString * smoking=@"";
        if (val==0) {
            smoking=@"Unfilled yet";
        }
        else if (val==1){
            smoking=@"No";
        }
        else if (val==2)
        {
            smoking=@"No, Never";
        }
        else if (val==3)
        {
            smoking=@"Yes";
        }
        else if (val==4)
        {
            smoking=@"Social";
        }
        else
        {
            smoking=@"Chain Smoker, Oxygen is overrated";
        }
        
        return smoking;
    }
    
    -(NSString *)appearanceDrinking:(NSString *)value{
        int val=value.intValue;
        NSString * drinking=@"";
        if (val==0) {
            drinking=@"Unfilled yet";
            
        }
        else if (val==1)
        {
            drinking=@"No";
            
        }
        else if (val==3)
        {
            drinking=@"With Company";
        }
        else if(val==2){
            drinking=@"No, Never";
        }
        else{
            drinking=@"Yes, Please";
        }
        return drinking;
    }
    
    -(NSString *)appearanceEducation:(NSString *)value{
        int val=value.intValue;
        NSString * edu=@"";
        if (val==0) {
            edu=@"Unfilled yet";
            
        }
        else if (val==1)
        {
            edu=@"School only";
            
        }
        else if (val==3)
        {
            edu=@"Trade/Technical";
        }
        else if(val==2){
            edu=@"College/University";
        }
        else{
            edu=@"Advanced Degree";
        }
        return edu;
    }
    -(NSString *)appearanceRelationShip:(NSString *)value{
        int val=value.intValue;
        NSString * relation=@"";
        if (val==0) {
            relation=@"Unfilled yet";
            
        }
        else if (val==1)
        {
            relation=@"Single";
            
        }
        else if (val==3)
        {
            relation=@"Taken";
        }
        else{
            relation=@"Open";
        }
        return relation;
    }
    
-(NSString * )appearancesexuality:(NSString *)value
    {
        int val=value.intValue;
        NSString * sex=@"";
        if (val==0) {
            sex=@"Unfilled yet";
            
        }
        else if (val==1)
        {
            sex=@"Straight";
            
        }
        else if (val==3)
        {
            sex=@"Bisexual";
        }
        else if(val==2){
            sex=@"Open Minded";
        }
        else if(val==4){
            sex=@"Gay";
        }
        else{
            sex=@"Lesbian";
        }
        return sex;
        
    }

    
    
    
#pragma mark-get All Facebook user info

-(void)getAllFacebookInfo:(id<FBGraphUser>) user{
    NSLog(@"facebook user email --===--%@",[user objectForKey:@"email"]);
    if (![[user objectForKey:@"email"]isEqualToString:@"(null)"]) {
        [SingletonClass shareSingleton].emailID=[user objectForKey:@"email"];
    }
    NSLog(@"Facebook user dob -==- %@",[user objectForKey:@"birthday"]);
    if (![user.birthday isEqualToString:@"(null)"]) {
        [SingletonClass shareSingleton].dob=[user objectForKey:@"birthday"];
    }
    if (![[user objectForKey:@"about"]isEqualToString:@"(null)"]) {
        [SingletonClass shareSingleton].aboutMe=[user objectForKey:@"about"];
    }
    NSLog(@"Facebook user about me -==- %@",[user objectForKey:@"about"]  );
    
    NSLog(@"facebook user sex -===- %@",[user objectForKey:@"gender"]);
    if (![[user objectForKey:@"gender"]isEqualToString:@"female"]) {
        [SingletonClass shareSingleton].sex=0;
    }
    else{
        [SingletonClass shareSingleton].sex=1;
    }
}

#pragma mark- Reachablity

-(void)reacheability
{
    NSLog(@"Rechability");
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    BOOL networkStatus = NO;
    if(status == NotReachable)
    {
        NSLog(@"stringgk////");
        networkStatus = NO;
    }
    else if (status == ReachableViaWiFi)
    {
        NSLog(@"reachable");
        networkStatus = YES;
        
    }
    else if (status == ReachableViaWWAN)
    {
        //3G
        networkStatus = YES;
        
    }
    else
    {
        networkStatus = NO;
    }
    // Do any additional setup after loading the view.
    
    [[NSUserDefaults standardUserDefaults] setBool:networkStatus forKey:@"NetworkStatus"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kReachabilityChangedNotification object:nil];
}


- (void)teardownStream
{
    [xmppStream removeDelegate:self];
    [xmppRoster removeDelegate:self];
    
    [xmppReconnect         deactivate];
    [xmppRoster            deactivate];
    [xmppvCardTempModule   deactivate];
    [xmppvCardAvatarModule deactivate];
    [xmppCapabilities      deactivate];
    
    [xmppStream disconnect];
    
    xmppStream = nil;
    xmppReconnect = nil;
    xmppRoster = nil;
    xmppRosterStorage = nil;
    xmppvCardStorage = nil;
    xmppvCardTempModule = nil;
    xmppvCardAvatarModule = nil;
    xmppCapabilities = nil;
    xmppCapabilitiesStorage = nil;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Core Data
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSManagedObjectContext *)managedObjectContext_roster
{
    return [xmppRosterStorage mainThreadManagedObjectContext];
}

- (NSManagedObjectContext *)managedObjectContext_capabilities
{
    return [xmppCapabilitiesStorage mainThreadManagedObjectContext];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Private
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)setupStream
{
    NSAssert(xmppStream == nil, @"Method setupStream invoked multiple times");
    
    // Setup xmpp stream
    //
    // The XMPPStream is the base class for all activity.
    // Everything else plugs into the xmppStream, such as modules/extensions and delegates.
    
    xmppStream = [[XMPPStream alloc] init];
    
#if !TARGET_IPHONE_SIMULATOR
    {
        // Want xmpp to run in the background?
        //
        // P.S. - The simulator doesn't support backgrounding yet.
        //        When you try to set the associated property on the simulator, it simply fails.
        //        And when you background an app on the simulator,
        //        it just queues network traffic til the app is foregrounded again.
        //        We are patiently waiting for a fix from Apple.
        //        If you do enableBackgroundingOnSocket on the simulator,
        //        you will simply see an error message from the xmpp stack when it fails to set the property.
        
        xmppStream.enableBackgroundingOnSocket = YES;
    }
#endif
    
    // Setup reconnect
    //
    // The XMPPReconnect module monitors for "accidental disconnections" and
    // automatically reconnects the stream for you.
    // There's a bunch more information in the XMPPReconnect header file.
    
    xmppReconnect = [[XMPPReconnect alloc] init];
    
    // Setup roster
    //
    // The XMPPRoster handles the xmpp protocol stuff related to the roster.
    // The storage for the roster is abstracted.
    // So you can use any storage mechanism you want.
    // You can store it all in memory, or use core data and store it on disk, or use core data with an in-memory store,
    // or setup your own using raw SQLite, or create your own storage mechanism.
    // You can do it however you like! It's your application.
    // But you do need to provide the roster with some storage facility.
    
    xmppRosterStorage = [[XMPPRosterCoreDataStorage alloc] init];
    //	xmppRosterStorage = [[XMPPRosterCoreDataStorage alloc] initWithInMemoryStore];
    
    xmppRoster = [[XMPPRoster alloc] initWithRosterStorage:xmppRosterStorage];
    
    xmppRoster.autoFetchRoster = YES;
    xmppRoster.autoAcceptKnownPresenceSubscriptionRequests = YES;
    
    // Setup vCard support
    //
    // The vCard Avatar module works in conjuction with the standard vCard Temp module to download user avatars.
    // The XMPPRoster will automatically integrate with XMPPvCardAvatarModule to cache roster photos in the roster.
    
    xmppvCardStorage = [XMPPvCardCoreDataStorage sharedInstance];
    xmppvCardTempModule = [[XMPPvCardTempModule alloc] initWithvCardStorage:xmppvCardStorage];
    
    xmppvCardAvatarModule = [[XMPPvCardAvatarModule alloc] initWithvCardTempModule:xmppvCardTempModule];
    
    // Setup capabilities
    //
    // The XMPPCapabilities module handles all the complex hashing of the caps protocol (XEP-0115).
    // Basically, when other clients broadcast their presence on the network
    // they include information about what capabilities their client supports (audio, video, file transfer, etc).
    // But as you can imagine, this list starts to get pretty big.
    // This is where the hashing stuff comes into play.
    // Most people running the same version of the same client are going to have the same list of capabilities.
    // So the protocol defines a standardized way to hash the list of capabilities.
    // Clients then broadcast the tiny hash instead of the big list.
    // The XMPPCapabilities protocol automatically handles figuring out what these hashes mean,
    // and also persistently storing the hashes so lookups aren't needed in the future.
    //
    // Similarly to the roster, the storage of the module is abstracted.
    // You are strongly encouraged to persist caps information across sessions.
    //
    // The XMPPCapabilitiesCoreDataStorage is an ideal solution.
    // It can also be shared amongst multiple streams to further reduce hash lookups.
    
    xmppCapabilitiesStorage = [XMPPCapabilitiesCoreDataStorage sharedInstance];
    xmppCapabilities = [[XMPPCapabilities alloc] initWithCapabilitiesStorage:xmppCapabilitiesStorage];
    
    xmppCapabilities.autoFetchHashedCapabilities = YES;
    xmppCapabilities.autoFetchNonHashedCapabilities = NO;
    
    // Activate xmpp modules
    
    [xmppReconnect         activate:xmppStream];
    [xmppRoster            activate:xmppStream];
    [xmppvCardTempModule   activate:xmppStream];
    [xmppvCardAvatarModule activate:xmppStream];
    [xmppCapabilities      activate:xmppStream];
    
    // Add ourself as a delegate to anything we may be interested in
    
    [xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    [xmppRoster addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    // Optional:
    //
    // Replace me with the proper domain and port.
    // The example below is setup for a typical google talk account.
    //
    // If you don't supply a hostName, then it will be automatically resolved using the JID (below).
    // For example, if you supply a JID like 'user@quack.com/rsrc'
    // then the xmpp framework will follow the xmpp specification, and do a SRV lookup for quack.com.
    //
    // If you don't specify a hostPort, then the default (5222) will be used.
    
    [xmppStream setHostName:@"takadating.com"];
    [xmppStream setHostPort:5222];
    
    
    // You may need to alter these settings depending on the server you're connecting to
    customCertEvaluation = YES;
}

- (void)goOnline
{
    XMPPPresence *presence = [XMPPPresence presence]; // type="available" is implicit
    
    NSString *domain = [xmppStream.myJID domain];
    
    //Google set their presence priority to 24, so we do the same to be compatible.
    
    if ([domain isEqualToString:@"takadating.com"]) {// me edited
        NSXMLElement *priority = [NSXMLElement elementWithName:@"priority" stringValue:@"24"];
        [presence addChild:priority];
    }
    /* if([domain isEqualToString:@"takadating.com"]
     || [domain isEqualToString:@"takadating.com"]
     || [domain isEqualToString:@"takadating.com"])
     {
     NSXMLElement *priority = [NSXMLElement elementWithName:@"priority" stringValue:@"24"];
     [presence addChild:priority];
     }*/
    
    [[self xmppStream] sendElement:presence];
}

- (void)goOffline
{
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
    
    [[self xmppStream] sendElement:presence];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Connect/disconnect
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (BOOL)connect
{
    if (![xmppStream isDisconnected]) {
        return YES;
    }
    
    NSString *myJID = [[NSUserDefaults standardUserDefaults] stringForKey:kXMPPmyJID];
    NSString *myPassword = [[NSUserDefaults standardUserDefaults] stringForKey:kXMPPmyPassword];
    
    //
    // If you don't want to use the Settings view to set the JID,
    // uncomment the section below to hard code a JID and password.
    //
    // myJID = @"user@gmail.com/xmppframework";
    // myPassword = @"";
    
    if (myJID == nil || myPassword == nil) {
        return NO;
    }
    
    [xmppStream setMyJID:[XMPPJID jidWithString:myJID]];
    password = myPassword;
    
    NSError *error = nil;
    if (![xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error connecting"
                                                            message:@"See console for error details."
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
        
        DDLogError(@"Error connecting: %@", error);
        
        return NO;
    }
    
    return YES;
}

- (void)disconnect
{
    [self goOffline];
    [xmppStream disconnect];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark XMPPStream Delegate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)xmppStream:(XMPPStream *)sender socketDidConnect:(GCDAsyncSocket *)socket
{
    DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
}

- (void)xmppStream:(XMPPStream *)sender willSecureWithSettings:(NSMutableDictionary *)settings
{
    DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
    
    NSString *expectedCertName = [xmppStream.myJID domain];
    if (expectedCertName)
    {
        settings[(NSString *) kCFStreamSSLPeerName] = expectedCertName;
    }
    
    if (customCertEvaluation)
    {
        settings[GCDAsyncSocketManuallyEvaluateTrust] = @(YES);
    }
}

- (void)xmppStream:(XMPPStream *)sender didReceiveTrust:(SecTrustRef)trust
 completionHandler:(void (^)(BOOL shouldTrustPeer))completionHandler
{
    DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
    
    // The delegate method should likely have code similar to this,
    // but will presumably perform some extra security code stuff.
    // For example, allowing a specific self-signed certificate that is known to the app.
    
    dispatch_queue_t bgQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(bgQueue, ^{
        
        SecTrustResultType result = kSecTrustResultDeny;
        OSStatus status = SecTrustEvaluate(trust, &result);
        
        if (status == noErr && (result == kSecTrustResultProceed || result == kSecTrustResultUnspecified)) {
            completionHandler(YES);
        }
        else {
            completionHandler(NO);
        }
    });
}

- (void)xmppStreamDidSecure:(XMPPStream *)sender
{
    DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
}

- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
    DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
    
    isXmppConnected = YES;
    
    NSError *error = nil;
    
    if (![[self xmppStream] authenticateWithPassword:password error:&error])
    {
        DDLogError(@"Error authenticating: %@", error);
    }
}

- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
    
    [self goOnline];
}

- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(NSXMLElement *)error
{
    DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
}

- (BOOL)xmppStream:(XMPPStream *)sender didReceiveIQ:(XMPPIQ *)iq
{
    DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
    
    return NO;
}

- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
    //DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
    
    // A simple example of inbound message handling.
    
    if ([message isChatMessageWithBody])
    {
        NSLog(@"messages recieved %@",message);
        XMPPUserCoreDataStorageObject *user = [xmppRosterStorage userForJID:[message from]
                                                                 xmppStream:xmppStream
                                                       managedObjectContext:[self managedObjectContext_roster]];
        int timeStamp=[[NSDate date] timeIntervalSince1970];
        
        NSString * time=[NSString stringWithFormat:@"%d",timeStamp];
        
        NSString *body = [[message elementForName:@"body"] stringValue];
        NSString *displayName = [user displayName];
        
     //   NSString * timeStampStr=[[message elementForName:@"time"]stringValue];
        
        //int timeStamp=[timeStampStr intValue];
       // NSDate * date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
       // NSString * str=[NSString stringWithFormat:@"%@",date];
        
        if (![[self.storeNewMsg objectForKey:@"jid"]isEqualToString:displayName]) {
            [self.storeNewMsg setObject:displayName forKey:@"jid"];
            [self.storeNewMsg setObject:body forKey:@"msg"];
            
        }
        else{
            
            [self.storeNewMsg setObject:body forKey:@"msg"];
        }
        [self.unreadMsgArr addObject:self.storeNewMsg];

        if ([displayName isEqualToString:[SingletonClass shareSingleton].chattingWith]) {
            
            NSMutableDictionary * dict=[[NSMutableDictionary alloc]init];
            [dict setObject:body forKey:@"msg"];
            [dict setObject:displayName forKey:@"sender"];
            [dict setObject:time forKey:@"time"];
            
            [[SingletonClass shareSingleton].messages addObject:dict];
        }
        
       
        
        if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive)
        {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"recievedMsg" object:nil userInfo:nil];
             [[NSNotificationCenter defaultCenter]removeObserver:self name:@"recievedMsg" object:nil];
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:displayName
                                                                message:body
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            //[alertView show];
        }
        else
        {
            // We are not active, so use a local notification instead
            UILocalNotification *localNotification = [[UILocalNotification alloc] init];
            localNotification.alertAction = @"Ok";
            localNotification.alertBody = [NSString stringWithFormat:@"From: %@\n\n%@",displayName,body];
            
            [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
        }
    }
}

- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence
{
    DDLogVerbose(@"%@: %@ - %@", THIS_FILE, THIS_METHOD, [presence fromStr]);
    
    NSString *presenceType = [presence type];            // online/offline
    NSString *myUsername = [[sender myJID] user];
    NSString *presenceFromUser = [[presence from] user];
    //
    //new request from unknow user
    if (![presenceFromUser isEqualToString:myUsername])
    {
        if  ([presenceType isEqualToString:@"subscribe"])
        {
            // [_chatDelegate newBuddyOnline:[NSString stringWithFormat:@"%@@%@", presenceFromUser, kHostName]];
            XMPPPresence *tempPresence = [[XMPPPresence alloc] init];
            tempPresence = presence;
            [[self xmppStream] sendElement:presence];
            NSLog(@"presence user wants to subscribe %@",presenceFromUser);
           
           // UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"New request From:" message:presenceFromUser delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
            // [alert show];
        }
    }
    
    //    if ([presenceFromUser isEqualToString:myUsername])
    //    {
    //        XMPPPresence *tempPresence = [[XMPPPresence alloc] init];
    //        tempPresence = presence;
    //        [[self xmppStream] sendElement:presence];
    //    }
}

- (void)xmppStream:(XMPPStream *)sender didReceiveError:(id)error
{
    DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
}

- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
    DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
    
    if (!isXmppConnected)
    {
        DDLogError(@"Unable to connect to server. Check xmppStream.hostName");
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark XMPPRosterDelegate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)xmppRoster:(XMPPRoster *)sender didReceiveBuddyRequest:(XMPPPresence *)presence
{
    DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
    
    XMPPUserCoreDataStorageObject *user = [xmppRosterStorage userForJID:[presence from]
                                                             xmppStream:xmppStream
                                                   managedObjectContext:[self managedObjectContext_roster]];
    
    NSString *displayName = [user displayName];
    NSString *jidStrBare = [presence fromStr];
    NSString *body = nil;
    
    if (![displayName isEqualToString:jidStrBare])
    {
        body = [NSString stringWithFormat:@"Buddy request from %@ <%@>", displayName, jidStrBare];
    }
    else
    {
        body = [NSString stringWithFormat:@"Buddy request from %@", displayName];
    }
    
    
    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:displayName
                                                            message:body
                                                           delegate:nil
                                                  cancelButtonTitle:@"Not implemented"
                                                  otherButtonTitles:nil];
        //[alertView show];
    }
    else
    {
        // We are not active, so use a local notification instead
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.alertAction = @"Not implemented";
        localNotification.alertBody = body;
        
        [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
    }
    
}


#pragma mark -
#pragma mark - Loading View mbprogresshud

-(void) showHUDLoadingView:(NSString *)strTitle
{
    HUD = [[MBProgressHUD alloc] initWithView:self.window];
    [self.window addSubview:HUD];
    //HUD.delegate = self;
    //HUD.labelText = [strTitle isEqualToString:@""] ? @"Loading...":strTitle;
    HUD.detailsLabelText=[strTitle isEqualToString:@""] ? @"Loading...":strTitle;
    [HUD show:YES];
}

-(void) hideHUDLoadingView
{
    [HUD removeFromSuperview];
}

-(void)showToastMessage:(NSString *)message
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.window
                                              animated:YES];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = message;
    hud.margin = 10.f;
    hud.yOffset = 130.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:5.0];
}

+(AppDelegate *)sharedAppDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}



@end
