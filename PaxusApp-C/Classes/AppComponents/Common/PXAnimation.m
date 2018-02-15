//
//  PXAnimation.m
//  PaxusApp-C
//
//  Created by Jithin on 15/2/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//

#import "PXAnimation.h"

@implementation PXAnimation

@synthesize completionHandler;

static PXAnimation *sharedMyManager = nil;

+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}
#pragma mark - Method to show image animation
- (void) playAnimationWithImageView:(UIImageView *)imageView completion:(AnimationCompletionBlock)completionBlock {
    if (completionBlock) {
        self.completionHandler = completionBlock;
    }
    NSMutableArray *images = [[NSMutableArray alloc] init];
    NSInteger animationImageCount = 8;
    for (int i = 1; i <= animationImageCount; i++) {
        // Images are numbered IndexedImagesInMyAnimation0, 1, 2, etc...
        [images addObject:(id)[UIImage imageNamed:[NSString stringWithFormat:@"animationImage%d", i]].CGImage];
    }
    //NSLog(@"%@",images);
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    animation.calculationMode = kCAAnimationDiscrete;
    animation.duration = 3.0;
    animation.values = images;
    animation.repeatCount = 1;
    animation.delegate = self;
    [imageView.layer addAnimation:animation forKey:@"animation"];
}
#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
    completionHandler(flag);
}
@end
