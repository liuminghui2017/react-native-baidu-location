//
//  CLLocationManager+ZHExtension.m
//  RNBaiduLocation
//
//  Created by 刘明辉 on 2019/5/21.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "CLLocationManager+ZHExtension.h"
#import <objc/runtime.h>

@implementation CLLocationManager (ZHExtension)


+ (void)load {
    if ([UIDevice currentDevice].systemVersion.floatValue >= 9.0) {
        method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"setAllowsBackgroundLocationUpdates:")), class_getInstanceMethod(self.class, @selector(swizzledSetAllowsBackgroundLocationUpdates:)));
    }
}

- (void)swizzledSetAllowsBackgroundLocationUpdates:(BOOL)allow {
    if (allow) {
        NSArray *backgroundModes = [[NSBundle mainBundle].infoDictionary objectForKey:@"UIBackgroundModes"];
        if( backgroundModes && [backgroundModes containsObject:@"location"]) {
            [self swizzledSetAllowsBackgroundLocationUpdates:allow];
        } else {
            NSLog(@"APP想设置后台定位，但APP的info.plist里并没有申请后台定位");
        }
    } else {
        [self swizzledSetAllowsBackgroundLocationUpdates:allow];
    }
}
//    作者：weixin_34292959
//    来源：CSDN
//    原文：https://blog.csdn.net/weixin_34292959/article/details/87506840
@end
