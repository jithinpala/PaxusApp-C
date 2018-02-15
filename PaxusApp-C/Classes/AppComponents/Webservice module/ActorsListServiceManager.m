//
//  ActorsListServiceManager.m
//  PaxusApp-C
//
//  Created by Jithin on 14/2/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//

#import "ActorsListServiceManager.h"

@implementation ActorsListServiceManager

static ActorsListServiceManager *sharedMyManager = nil;

+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}
#pragma mark - Method to fetch actors list for ActorsListViewController
- (void)fetchAcotrsListfromServerWithSuccess:(void (^)(BOOL resultSuccess))successBlock failure:(void (^)(NSError *error))failureBlock{
    WebserviceServerManager *serverManager = [WebserviceServerManager sharedManager];
    [serverManager sendRequestToServer:@"http://microblogging.wingnity.com/JSONParsingTutorial/jsonActors" parameters:nil apiRequestType:@"GET" success:^(NSTEasyJSON *fetchedJSON) {
        NSArray *result = fetchedJSON[@"actors"].array;
        //NSDictionary *ok = fetchedJSON[@"actors"].dictionary;
        [[ActorsModel sharedManager] addActorDetailsToModel:result];
        successBlock(true);
    } failure:^(NSError *error) {
        NSLog(@"Erroorrrr");
        failureBlock(error);
    }];
}

#pragma mark - Method to fetch image  for table cell in ActorsListViewController
- (void)fetchImageFromServer:(UIImageView *)imageView imageURLPath:(NSString *)imagePath placeHoldeImage:(NSString *)placeHolderName {
    imageView.image = [UIImage imageNamed:placeHolderName];
    WebserviceServerManager *serverManager = [WebserviceServerManager sharedManager];
    [serverManager sendRequestToServerForImageDownload:imagePath success:^(NSData *data) {
        UIImage *image = [[UIImage alloc] initWithData:data];
        imageView.image = image;
    } failure:^(NSError *error) {
        UIImage *image = [UIImage imageNamed:placeHolderName];
        imageView.image = image;
    }];
}
@end
