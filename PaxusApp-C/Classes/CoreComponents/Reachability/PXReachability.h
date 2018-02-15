//
//  PXReachability.h
//  PaxusApp-C
//
//  Created by Jithin on 14/2/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface PXReachability : NSObject
+ (instancetype)sharedManager;
-(BOOL)checkNetworkIsAvailable;
@end
