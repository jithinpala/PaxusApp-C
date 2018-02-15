//
//  ActorsListServiceManager.h
//  PaxusApp-C
//
//  Created by Jithin on 14/2/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebserviceServerManager.h"
#import "NSTEasyJSON.h"
#import "ActorsModel.h"

@interface ActorsListServiceManager : NSObject

+ (instancetype)sharedManager;
- (void)fetchAcotrsListfromServerWithSuccess:(void (^)(BOOL resultSuccess))successBlock failure:(void (^)(NSError *error))failureBlock;
- (void)fetchImageFromServer:(UIImageView *)imageView imageURLPath:(NSString *)imagePath placeHoldeImage:(NSString *)placeHolderName;
@end
