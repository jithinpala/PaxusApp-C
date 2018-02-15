//
//  PXAlertController.m
//  PaxusApp-C
//
//  Created by Jithin on 15/2/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//

#import "PXAlertController.h"

@implementation PXAlertController
#pragma mark - Show alert on viewcontroller

static PXAlertController *sharedMyManager = nil;
+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

+ (void)showSimpleAlertWithMessage:(NSString *)message inController:(UIViewController *)viewController {
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:[NSString localizedString:@"Product.Display.Name"]
                                                                   message:[NSString localizedString:message]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    [alertController addAction:defaultAction];
    [viewController presentViewController:alertController animated:true completion:nil];

}

- (void)showSimpleAlert:(NSString *)message inController:(UIViewController *)viewController {
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:[NSString localizedString:@"Product.Display.Name"]
                                                                             message:[NSString localizedString:message]
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    [alertController addAction:defaultAction];
    [viewController presentViewController:alertController animated:true completion:nil];
}

@end
