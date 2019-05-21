
#if __has_include("RCTBridgeModule.h")
#import "RCTBridgeModule.h"
#else
#import <React/RCTBridgeModule.h>
#endif

#import <BMKLocationKit/BMKLocationComponent.h>

@interface LocationHelper : NSObject <BMKLocationManagerDelegate, BMKLocationAuthDelegate> {
    RCTPromiseResolveBlock setupResolver;
    RCTPromiseResolveBlock locationResolver;
}
@property(nonatomic, strong) BMKLocationManager *locationManager;
@property(nonatomic, copy) BMKLocatingCompletionBlock completionBlock;
@end

@interface RNBaiduLocation : NSObject <RCTBridgeModule>
@property LocationHelper *helper;
@end

