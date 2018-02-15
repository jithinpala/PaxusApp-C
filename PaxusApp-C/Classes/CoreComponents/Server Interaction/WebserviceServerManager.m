//
//  WebserviceServerManager.m
//  PaxusApp-C
//
//  Created by Jithin on 14/2/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//

#import "WebserviceServerManager.h"



@implementation WebserviceServerManager

static WebserviceServerManager *sharedMyManager = nil;

+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

#pragma mark - Send request to server for getting actors list
-(void)sendRequestToServer:(NSString *)apiServiceFullURL parameters:(NSDictionary*)params apiRequestType:(NSString * )requestMethod success:(void (^)(NSTEasyJSON *result))successBlock failure:(void (^)(NSError *error))failureBlock {    
    
    if ([[PXReachability sharedManager] checkNetworkIsAvailable]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURL *url = [NSURL URLWithString:apiServiceFullURL];
            NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url];
            [urlRequest setHTTPMethod:@"GET"];
            [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
            NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
            
            NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSTEasyJSON *fetchedJSON = [NSTEasyJSON withData:data];
                    if (error == nil) {
                        successBlock(fetchedJSON);
                    } else {
                        failureBlock(error);
                    }
                });
                
            }];
            [dataTask resume];
        });
    } else {
        NSDictionary *userInfo = @{
                                   NSLocalizedDescriptionKey: NSLocalizedString(@"Operation was unsuccessful.", nil),
                                   NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"Network connection not available.", nil),
                                   NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Have you tried turning it off and on again?", nil)
                                   };
        NSError *error = [NSError errorWithDomain:@"jithin.paxus.com" code:-57 userInfo:userInfo];
        failureBlock(error);
    }
    
    
}
#pragma mark - Method to download image
-(void)sendRequestToServerForImageDownload:(NSString *)apiServiceFullURL success:(void (^)(NSData *data))successBlock failure:(void (^)(NSError *error))failureBlock{
    
    if ([[PXReachability sharedManager] checkNetworkIsAvailable]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self setSharedCacheForImages];
            NSURL *url = [NSURL URLWithString:apiServiceFullURL];
            NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url];
            NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
            NSCachedURLResponse *cachedResponse = [[NSURLCache sharedURLCache] cachedResponseForRequest:urlRequest];
            NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
            if (cachedResponse.data) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    successBlock(cachedResponse.data);
                });
            } else {
                NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error != nil) {
                            failureBlock(error);
                            return;
                        }
                        successBlock(data);
                        return;
                    });
                    
                }];
                [dataTask resume];
            }
            
        });
    } else {
        NSDictionary *userInfo = @{
                                   NSLocalizedDescriptionKey: NSLocalizedString(@"Operation was unsuccessful.", nil),
                                   NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"Network connection not available.", nil),
                                   NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Have you tried turning it off and on again?", nil)
                                   };
        NSError *error = [NSError errorWithDomain:@"jithin.paxus.com" code:-57 userInfo:userInfo];
        failureBlock(error);
    }
    
    
}

- (void)setSharedCacheForImages
{
    NSUInteger cashSize = 250 * 1024 * 1024;
    NSUInteger cashDiskSize = 250 * 1024 * 1024;
    NSURLCache *imageCache = [[NSURLCache alloc] initWithMemoryCapacity:cashSize diskCapacity:cashDiskSize diskPath:@"someCachePath"];
    [NSURLCache setSharedURLCache:imageCache];
}

@end
