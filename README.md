# react-native-baidu-location

## Getting started

`$ npm install gitUrl --save`

## Link

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


### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-baidu-location` and add `BaiduLocation.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libBaiduLocation.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainApplication.java`
  - Add `import com.reactlibrary.BaiduLocationPackage;` to the imports at the top of the file
  - Add `new BaiduLocationPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-baidu-location'
  	project(':react-native-baidu-location').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-baidu-location/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-baidu-location')
  	```


## Usage
```javascript
import BaiduLocation from 'react-native-baidu-location';

// TODO: What to do with the module?
BaiduLocation;
```
