#import <React/RCTBridgeModule.h>
#import <BMKLocationKit/BMKLocationComponent.h>


@interface LocationHelper : NSObject <BMKLocationManagerDelegate, BMKLocationAuthDelegate> {
    RCTPromiseResolveBlock setupResolver;
    RCTPromiseResolveBlock locationResolver;
}
    @property(nonatomic, strong) BMKLocationManager *locationManager;
    @property(nonatomic, copy) BMKLocatingCompletionBlock completionBlock;
    @property bool isLocationAuthed;
    @property (nonatomic, strong)CLLocationManager *manager;
@end


@interface BaiduLocation : NSObject <RCTBridgeModule>
@property LocationHelper *helper;
@end
