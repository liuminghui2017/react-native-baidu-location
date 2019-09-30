//
//  CLLocationManager+ZHExtension.m
//  react-native-baidu-location
//
//  Created by 刘明辉 on 2019/9/29.
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
    NSLog(@"allow %@", allow ? @"yes" : @"no");
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
@end
