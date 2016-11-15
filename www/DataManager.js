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
