#import <React/RCTLog.h>
#import "BaiduLocation.h"

@implementation LocationHelper

-(id)init {
    self = [super init];
    return self;
}

//  配置百度AK
- (void) setup: (NSString *)AK andResolver: (RCTPromiseResolveBlock)resolve {
    self->setupResolver = resolve;
    [[BMKLocationAuth sharedInstance] checkPermisionWithKey:AK authDelegate:self];
    [self initLocationManager];
    [self initBlock];
}

// 初始化LocationManager
- (void) initLocationManager {
    _locationManager = [[BMKLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.coordinateType = BMKLocationCoordinateTypeGCJ02;
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    _locationManager.activityType = CLActivityTypeAutomotiveNavigation;
    _locationManager.pausesLocationUpdatesAutomatically = NO;
    _locationManager.allowsBackgroundLocationUpdates = YES;
    _locationManager.locationTimeout = 10;
    _locationManager.reGeocodeTimeout = 10;
}

// 定位结果回调
-(void)initBlock
{
    __weak LocationHelper *weakSelf = self;
    self.completionBlock = ^(BMKLocation *location, BMKLocationNetworkState state, NSError *error)
    {
        NSDictionary *res;
        if (error)
        {
            res = @{@"code": @(error.code), @"msg": error.localizedDescription};
            RCTLogInfo(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
        }
        
        if (location.location) {
            NSString * addr = [[NSString alloc] initWithFormat:@"%@%@%@%@",
                               location.rgcData.province, location.rgcData.city, location.rgcData.district, location.rgcData.street];
            
            res = @{
                    @"code": @(200),
                    @"latitude": @(location.location.coordinate.latitude),
                    @"longitude": @(location.location.coordinate.longitude),
                    @"addr": addr
                    };
            RCTLogInfo(@"LOC = %@",location.location);
        }
        
        if (location.rgcData) {
            RCTLogInfo(@"rgc = %@",[location.rgcData description]);
        }
        
        RCTLogInfo(@"netstate = %d",state);
        LocationHelper *strongSelf = weakSelf;
        strongSelf->locationResolver(res);
    };
}

// 授权结果回调
// 鉴权状态0：成功； 1：网络错误； 2：授权失败
- (void)onCheckPermissionState:(BMKLocationAuthErrorCode)iError {
    NSDictionary *res;
    if (iError != 0) {
        RCTLogInfo(@"BaiduLocation checkPermisionWithKey fail!");
        res = @{@"success":@(false)};
    } else {
        RCTLogInfo(@"BaiduLocation checkPermisionWithKey success!");
        res = @{@"success":@(true)};
    }
    self->setupResolver(res);
}

// 发起定位
-(void)getLocation: (RCTPromiseResolveBlock)resolve {
    self->locationResolver = resolve;
    [_locationManager requestLocationWithReGeocode:YES withNetworkState:YES completionBlock:self.completionBlock];
}

-(void) remove{
    [_locationManager stopUpdatingLocation];
    _locationManager.delegate = nil;
}
@end


@implementation BaiduLocation

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE()


// 获取定位
RCT_REMAP_METHOD(getLocation,
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
    [self.helper getLocation: resolve];
}

// 初始化
RCT_REMAP_METHOD(setup,
                 BaiDuAK:(NSString *)AK
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
    if (self.helper == nil) {
        self.helper = [[LocationHelper alloc] init];
        [self.helper setup:AK andResolver:resolve];
    }
}

RCT_EXPORT_METHOD(remove) {
    [self.helper remove];
}

@end
