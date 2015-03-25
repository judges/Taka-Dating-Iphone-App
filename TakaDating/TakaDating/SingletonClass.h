//
//  SingletonClass.h
//  TakaDating
//
//  Created by Sumit Ghosh on 06/12/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingletonClass : NSObject
@property(nonatomic,strong) NSString* aboutMe,*location,* name,*bodyType,*eyeColor,*hairColor,*appearance,* relation,* sexuality,*Living,*children,*smoking,* education,* dirinking,* height,* weight, * income,*profession,*userID,*inetrestedIn;
@property (nonatomic,strong) NSString *interest,*interestedIn,*withPeople,*dob,*languages,*thumbURL,*favoriteMemberId,*awards,*password;
@property(nonatomic,assign)int hereFor,with,sex;

//profile setting privacy variables
@property(nonatomic,strong) NSString * onlineStatus,* distance,* viewProfile,* securityLevel,* browsing,* publicSearch,* find;
//profile setting phtotos variables
@property(nonatomic,strong)NSString * comment,* watermark_on;
//languages valiabes
@property(nonatomic,strong)NSString * language;

//notification variables

@property(nonatomic,strong)NSString * newmsgEmail,* profvisitEmail,* peopleEmail,* alertEmail,*newsEmail,*giftEmail,*rateEmail,*favEmail;
@property(nonatomic,strong)NSString * newmsgMobile,*profvisitMobile,*peopleMobile,* alertMobile,*newsMobile,*giftMobile,*rateMobile,*favMobile;
@property(nonatomic,strong)NSString * InvisibleModeSetting,*MessagesSetting;
+(SingletonClass *) shareSingleton;

//sign email id

@property(nonatomic,strong)NSString * emailID;

//For not facebook login

@property(nonatomic)BOOL facebookLog,fetchFBPhoto;
@property(nonatomic)NSString * facebookId;

//profile user images

@property(nonatomic,strong)NSMutableArray * userImages;

//Location Information

@property(nonatomic,strong)NSString *CountryArea,* longitude,* lattitude;

//Facebook user photos

@property(nonatomic,strong)NSMutableArray * photosOfUser;


// photo and supper power class frame
@property(nonatomic,assign)CGRect frame;


// variable for fetching all interests
@property(nonatomic,strong)NSMutableDictionary * mostPopular,* msuic,*moviesAndTvShow,* fashion,*sports,* food,* profession_cat,* books;

//profile visistors variables
@property(nonatomic,strong)NSMutableArray * viewerID,*viewerName,*viewerImage,*isOnline,*imgCount;
@property(nonatomic,strong)NSString * viewerSex;


//@property(nonatomic,strong)NSMutableArray * subArray;

@property(nonatomic,strong)NSMutableArray * intr_cat_id,* intr_id,*  intr_name;
@property(nonatomic,strong)NSArray * profileImages;


//Encounter class variables

@property(nonatomic,strong)NSMutableArray * encounterUsrImages,*messages;
@property(nonatomic,strong)NSString * encounterUsrProfilePic;
@property(nonatomic)NSString *enhereFor,*enwithWhom,*enFromAge,*enEndAge;

//Custom menu Variabe
@property(nonatomic,strong)NSString * profileImg;

//Insterests updating
@property(nonatomic,strong)NSMutableArray * selectedInterests ;

//Message chat history sorted array
@property(nonatomic,strong)NSArray * sortedData;


//Chat bool varibale
@property(nonatomic)BOOL fromChat;

@property(nonatomic)NSMutableArray * selectedIntId,* selectedIntName;

// super power activation

@property(nonatomic)int superPower;
@end
