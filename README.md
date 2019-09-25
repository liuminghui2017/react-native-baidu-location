# react-native-baidu-location

## Getting started

`$ npm install react-native-baidu-location --save`

### Mostly automatic installation

`$ react-native link react-native-baidu-location`

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
