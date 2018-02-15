//
//  PXReachability.m
//  PaxusApp-C
//
//  Created by Jithin on 14/2/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//

#import "PXReachability.h"


@interface PXReachability()

@property (nonatomic) Reachability *hostReachability;
@property (nonatomic) Reachability *internetReachability;

@end


@implementation PXReachability

static PXReachability *sharedMyManager = nil;

+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}
#pragma mark - Check network rechability status
-(BOOL)checkNetworkIsAvailable {
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus remoteHostStatus = [self.internetReachability currentReachabilityStatus];
    switch (remoteHostStatus) {
        case NotReachable:
            return false;
            break;
        case ReachableViaWiFi:
            return true;
            break;
        case ReachableViaWWAN:
            return true;
            break;
        default:
            return false;
            break;
    }    
}
@end
