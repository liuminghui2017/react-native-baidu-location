# react-native-baidu-location

## Getting started

`$ npm install gitUrl --save`

## 集成
### RN >= 0.60
	不需执行react-native link操作
#### IOS

`$ cd ios && pod install` 

##### 1.引入系统库文件
	CoreLocation.framework
	SystemConfiguration.framework
	Security.framework
	libsqlite3.0.tbd（xcode7以前为 libsqlite3.0.dylib）
	CoreTelephony.framework
	libc++.tbd（因需适配iOS12，需要将libstdc++.6.0.9.tbd 更新为libc++.tbd）
	AdSupport.framework
在 TARGETS->General->Linked Frameworks and Libraries 中点击“+”，依次查找上述文件，添加到工程中，完成系统库文件的引入操作。
##### 2.申请权限
- NSLocationWhenInUseUsageDescription：表示应用在前台的时候可以搜到更新的位置信息；

- NSLocationAlwaysUsageDescription：表示应用在前台和后台（suspend 或 terminated）都可以获取到更新的位置数据；

- NSLocationAlwaysAndWhenInUseUsageDescription：申请永久定位权限，以便应用在前台和后台都可以获取位置数据；

不需要后台定位时只配置第一个权限即可

#### 3.环境配置
	在TARGETS->Build Settings->Other Linker Flags 中添加-ObjC。

#### Android
##### 1.添加AK
	在AndroidManifest.xml文件中的Application标签里添加：
	<meta-data
		android:name="com.baidu.lbsapi.API_KEY"
		android:value="AK" >
	</meta-data>

##### 2.添加权限
	<!-- 这个权限用于进行网络定位-->
	<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"></uses-permission>
	<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"></uses-permission>
	<uses-permission android:name="android.permission.ACCESS_WIFI_STATE"></uses-permission>
	<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"></uses-permission>
	<uses-permission android:name="android.permission.CHANGE_WIFI_STATE"></uses-permission>
	<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"></uses-permission>
	<uses-permission android:name="android.permission.INTERNET" /></uses-permission>

##### 3.添加service
	<service android:name="com.baidu.location.f" android:enabled="true" android:process=":remote"> </service>

## Usage
```javascript
import BaiduLocation from 'react-native-baidu-location';

	class App extends Component {
		componentDidMounted() {
			if (platform === 'ios') {
				BaiduLocation.setup('AK').then(res => {
					if (res.success) {
						// success
					}
				})
			}
		}

		// 单次定位
		getLocation() {
			BaiduLocation.getLocation().then(res => {
				res = {
					code, // 200成功
					latitude, // gcj
					longitude, // gcj
					addr, // 地址
					msg, // 获取定位失败错误信息
				}
			})
		}
	}
BaiduLocation;
```
