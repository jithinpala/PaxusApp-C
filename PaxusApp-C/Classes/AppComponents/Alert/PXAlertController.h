//
//  PXAlertController.h
//  PaxusApp-C
//
//  Created by Jithin on 15/2/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSString+StringExtension.h"

@interface PXAlertController : NSObject
+ (void)showSimpleAlertWithMessage:(NSString *)message inController:(UIViewController *)viewController;
@end
