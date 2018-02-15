//
//  ActorsModel.m
//  PaxusApp-C
//
//  Created by Jithin on 14/2/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//

#import "ActorsModel.h"
#import "NSTEasyJSON.h"

@implementation ActorsModel

@synthesize actorsListArray;


static ActorsModel *sharedMyManager = nil;

+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
        sharedMyManager->actorsListArray = [NSMutableArray array];
    });
    return sharedMyManager;
}
#pragma mark - Get fetched data
- (NSMutableArray *)actorsArray {
    return self.actorsListArray;
}
#pragma mark - Add parsed data from server to array
-(void)addActorDetailsToModel:(NSArray *)jsonResults {
    [self.actorsListArray removeAllObjects];
    for (NSArray *item in jsonResults) {
        [self.actorsListArray addObject:item];
    }
    return;
}

@end
