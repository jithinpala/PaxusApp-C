//
//  WebserviceServerManager.h
//  PaxusApp-C
//
//  Created by Jithin on 14/2/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSTEasyJSON.h"
#import "PXCommon.h"
#import "PXReachability.h"

@interface WebserviceServerManager : NSObject

+ (instancetype)sharedManager;
-(void)sendRequestToServer:(NSString *)apiServiceFullURL parameters:(NSDictionary*)params apiRequestType:(NSString *)requestMethod success:(void (^)(NSTEasyJSON *result))successBlock failure:(void (^)(NSError *error))failureBlock ;
-(void)sendRequestToServerForImageDownload:(NSString *)apiServiceFullURL success:(void (^)(NSData *data))successBlock failure:(void (^)(NSError *error))failureBlock;
@end
