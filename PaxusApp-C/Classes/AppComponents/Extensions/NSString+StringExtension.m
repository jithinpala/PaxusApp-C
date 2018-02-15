//
//  NSString+StringExtension.m
//  PaxusApp-C
//
//  Created by Jithin on 15/2/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//

#import "NSString+StringExtension.h"

@implementation NSString (StringExtension)
#pragma mark - Method to get localized string
+ (NSString *)localizedString:(NSString *)string {
   return NSLocalizedStringFromTableInBundle(string, nil, NSBundle.mainBundle, "");
}

@end
