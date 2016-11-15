# Cordova DataManager plugin

for iOS and Android, by [ktb](https://github.com/hongyukico)

## Description
数据缓存处理插件，支持android、ios平台


* 1.0.0 Works with Cordova 3.x
* 1.0.1+ Works with Cordova >= 4.0

## Installation

```
cordova plugin add cordova-plugin-ktb-dataManager
```

### iOS specifics
* Uses the MPMoviePlayerController.
* Tested on iOS 7. (If someone has an iOS 6 device, please report back to me how it does.)

### Android specifics
* Uses VideoView and MediaPlayer.
* Creates two activities in your AndroidManifest.xml file.
* Tested on Android 4.0+. (If someone has a Gingerbread device, please report back to me how it does.)

## Usage

```javascript
 
	var exec = require('cordova/exec');

	// 改
	exports.postMethod = function(arg0, success, error) {
		exec(success, error, "DataManager", "postData", [arg0]);
	};

	// 查
	exports.getMethod = function(arg0, success, error) {
		exec(success, error, "DataManager", "getData", [arg0]);
	};

	// 删除
	exports.deleteMethod = function(arg0, success, error) {
		exec(success, error, "DataManager", "deleteData", [arg0]);
	};


```
