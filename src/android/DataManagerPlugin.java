package com.ktb.plugin;

import com.ktb.simplecache.ACache;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;


/**
 * 项目名称：android
 * 类描述：
 * 创建人：HONGYU.LIU
 * 创建时间：2016/10/19 10:23
 * 修改人：HONGYU.LIU
 * 修改时间：2016/10/19 10:23
 * 修改备注：
 */

public class DataManagerPlugin extends CordovaPlugin {
    final String postData_TAG = "postData";
    final String getData_TAG = "getData";
    final String deleteData_TAG = "deleteData";
    ACache aCache;

    /**
     * Constructor.
     */
    public DataManagerPlugin() {
    }

    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);
        aCache = ACache.get(cordova.getActivity());
    }

    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (postData_TAG.equals(action)) {//存
            JSONObject params = args.getJSONObject(0);
            String key = params.getString("key");
            String dataSource = params.getString("dataSource");
            aCache.put(key, dataSource);
            callbackContext.success();
            return true;

        } else if (getData_TAG.equals(action)) {//取
            JSONObject params = args.getJSONObject(0);
            String key = params.getString("key");
            String result = aCache.getAsString(key);
            callbackContext.success(result);
            return true;
        } else if (deleteData_TAG.equals(action)) {//移除
            JSONObject params = args.getJSONObject(0);
            String key = params.getString("key");
            aCache.remove(key);
            callbackContext.success();
            return true;

        }
        return false;
    }
}