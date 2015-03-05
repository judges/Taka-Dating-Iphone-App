//
//  AppDelegate.m
//  TakaDating
//
//  Created by Sumit Ghosh on 08/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self reacheability];
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
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
                             
                             [SingletonClass shareSingleton].userID=userInfo;
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
  NSString * fbid= [[NSUserDefaults standardUserDefaults]objectForKey:ConnectedFacebookUserID];
    NSString * urlStr=[NSString stringWithFormat:@"http://taka.dating/facebook/%@",fbid];
    urlStr=[urlStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL  * url=[NSURL URLWithString:urlStr];
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlReponse error:&error];
    
    if (data==nil) {
        NSLog(@"No data");
        return NO;
    }
    id parse=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if ([[parse objectForKey:@"code"]isEqualToNumber:[NSNumber numberWithInt:200]]) {
        return  YES;
    }
    else{
        return NO;
    }
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
}


@end
