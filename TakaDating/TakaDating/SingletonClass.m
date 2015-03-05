//
//  SingletonClass.m
//  TakaDating
//
//  Created by Sumit Ghosh on 06/12/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "SingletonClass.h"
static SingletonClass *sharesingleton;
@implementation SingletonClass

+(SingletonClass *) shareSingleton{
    @synchronized(self){
        if (!sharesingleton) {
            sharesingleton = [[SingletonClass alloc] init];
        }
    }
    
    return sharesingleton;
}
@end
