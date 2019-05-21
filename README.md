
# react-native-baidu-location

### 自动安装

`$ react-native link react-native-baidu-location`

### 部分需手动安装

#### iOS
1. 将目录下的BMKLocationKit.framework拖拽到主工程目录到Frameworks下；
2. 引入系统库
    SystemConfiguration.framework
		Security.framework
		libsqlite3.0.tbd（xcode7以前为 libsqlite3.0.dylib）
		CoreTelephony.framework
		libc++.tbd（因需适配iOS12，需要将libstdc++.6.0.9.tbd 更新为libc++.tbd）
3. 到info.plist添加权限：
    - NSLocationWhenInUseUsageDescription：表示应用在前台的时候可以搜到更新的位置信息；
	  - NSLocationAlwaysUsageDescription：表示应用在前台和后台（suspend 或 terminated）都可以获取到更新的位置数据；
	  - NSLocationAlwaysAndWhenInUseUsageDescription：申请永久定位权限，以便应用在前台和后台都可以获取位置数据
4. target -> Build Settings -> Apple Clang - Language  
    Precompile Prefix Header改yes
		Prefix Header设 $(SRCROOT)/../node_modules/react-native-baidu-location/ios/BackgroundLocationFix.pch
5. target -> Build Settings -> Framework Search Paths: $(PROJECT_DIR)
##### 注意：本项目使用到是bitcode无idfa版本的framework，可到官方下载替换
[百度定位SDK下载](http://lbsyun.baidu.com/index.php?title=ios-locsdk/getsdk-ios-download)
[环境配置官方文档](http://lbsyun.baidu.com/index.php?title=ios-locsdk/guide/create-project/manual-create)


#### Android
1. Insert the following lines in `android/app/build.gradle`:
  	```
			defaultConfig {
				//...
				manifestPlaceholders = [ // here
					BAIDU_AK: "百度AK"
				]
			}

			dependencies {
				compile project(':react-native-baidu-location') // here
				//...
			}
  	```
2. Insert the following lines in `AndroidManifest.xml`
		
			<application>
				//...
				<meta-data
					android:name="com.baidu.lbsapi.API_KEY"
					android:value="${BAIDU_AK}" >
				</meta-data>
				
				<service android:name="com.baidu.location.f" android:enabled="true" android:process=":remote"> </service>
				//...
			</application>
		

## API
### setup(AK) (ios)
ios使用时需在根组件加载完毕时调用一次
```javascript
	RNBaiduLocation.setup().then(res => {
		if (res.success) { /*success*/}
		else {/*failed*/}
	})
```
### remove()
```javascript
	RNBaiduLocation.remove()
```
需在根组件unmount时调用一次
### getLocation()
```javascript
  RNBaiduLocation.getLocation().then(res => {
    if (res.code == 200) { // success
      // res: {
      //  code,
      //  latitude,
      //  longitude,
      //  addr,
      //  msg,
      // }
    } else {
      // falied
    }
  })
```


## Usage
```javascript
  // App.js
  import RNBaiduLocation from'react-native-baidu-location';

  componentDidMount() {
    Platform.OS == 'ios' && RNBaiduLocation.setup()
  }

  componentWillUnMount() {
    RNBaiduLocation.remove()
  }
```


```javascript
import RNBaiduLocation from 'react-native-baidu-location';

RNBaiduLocation.getLocation().then(res => {
  if (res.code == 200) {
    // success
    // res: {
    //  code,
    //  latitude,
    //  longitude,
    //  addr,
    //  msg,
    // }
  } else {
    // failed
  }
});

```
  
