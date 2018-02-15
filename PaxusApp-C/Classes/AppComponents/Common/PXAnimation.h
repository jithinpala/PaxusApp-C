//
//  PXAnimation.h
//  PaxusApp-C
//
//  Created by Jithin on 15/2/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^AnimationCompletionBlock)(BOOL finishedStatus);

@interface PXAnimation : NSObject <CAAnimationDelegate>
@property (nonatomic, strong) AnimationCompletionBlock completionHandler;
+ (instancetype)sharedManager;
- (void) playAnimationWithImageView:(UIImageView *)imageView completion:(AnimationCompletionBlock)completionBlock;

@end
