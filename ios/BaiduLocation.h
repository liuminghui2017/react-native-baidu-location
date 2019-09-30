#import <React/RCTBridgeModule.h>
#import <BMKLocationKit/BMKLocationComponent.h>


@interface LocationHelper : NSObject <BMKLocationManagerDelegate, BMKLocationAuthDelegate> {
    RCTPromiseResolveBlock setupResolver;
    RCTPromiseResolveBlock locationResolver;
}
    @property(nonatomic, strong) BMKLocationManager *locationManager;
    @property(nonatomic, copy) BMKLocatingCompletionBlock completionBlock;
@end


@interface BaiduLocation : NSObject <RCTBridgeModule>
@property LocationHelper *helper;
@end
