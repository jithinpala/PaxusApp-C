//
//  NetworkingAPI.m
//  PaxusApp-C
//
//  Created by Jithin on 14/2/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//

#import "NetworkingAPI.h"

@implementation NetworkingAPI
static NetworkingAPI *sharedMyManager = nil;

+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}
#pragma mark - Base URL
-(NSString *)apiBaseUrl {
    return @"http://microblogging.wingnity.com/JSONParsingTutorial/jsonActors";
}

@end
