//
//  ActorsModel.h
//  PaxusApp-C
//
//  Created by Jithin on 14/2/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActorsModel : NSObject

@property (nonatomic, strong)   NSMutableArray *actorsListArray;

+ (instancetype)sharedManager;
- (NSMutableArray *)actorsArray;
-(void)addActorDetailsToModel:(NSArray *)resultArray;

@end
