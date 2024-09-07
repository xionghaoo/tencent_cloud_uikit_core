package com.tencent.cloud.uikit.core;
import android.content.Context;
import android.text.TextUtils;
import android.util.Log;
import android.view.Gravity;

import androidx.annotation.NonNull;
import com.tencent.cloud.uikit.core.utils.MethodUtils;
import com.tencent.cloud.uikit.core.utils.ToastUtil;

import java.lang.reflect.Method;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class TUICorePlugin implements FlutterPlugin, MethodCallHandler {

    private static final String TAG                      = "TUICorePlugin";
    private static final int    ERROR_CODE_NULL_PARAM    = -1001;
    private static final int    ERROR_CODE_INVALID_PARAM = -1002;

    private MethodChannel mMethodChannel;
    private Context       mContext;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        mMethodChannel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "tuicore");
        mMethodChannel.setMethodCallHandler(this);
        mContext = flutterPluginBinding.getApplicationContext();
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        Log.i(TAG, "onMethodCall -> method:" + call.method + ", arguments:" + call.arguments);
        try {
            Method method = TUICorePlugin.class.getDeclaredMethod(call.method, MethodCall.class,
                    MethodChannel.Result.class);
            method.invoke(this, call, result);
        } catch (NoSuchMethodException e) {
            Log.e(TAG, "onMethodCall |method=" + call.method + "|arguments=" + call.arguments + "|error=" + e);
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            Log.e(TAG, "onMethodCall |method=" + call.method + "|arguments=" + call.arguments + "|error=" + e);
            e.printStackTrace();
        } catch (Exception e) {
            Log.e(TAG, "onMethodCall |method=" + call.method + "|arguments=" + call.arguments + "|error=" + e);
            e.printStackTrace();
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        mMethodChannel.setMethodCallHandler(null);
    }

    public void showToast(MethodCall call, MethodChannel.Result result) {
        String content = MethodUtils.getMethodParam(call, "content");
        if (TextUtils.isEmpty(content)) {
            result.error("" + ERROR_CODE_INVALID_PARAM, "content is empty", "");
            return;
        }
        int durationIndex = MethodUtils.getMethodParam(call, "duration");
        boolean duration = getDurationByIndex(durationIndex);
        int gravityIndex = MethodUtils.getMethodParam(call, "gravity");
        int gravity = getGravityByIndex(gravityIndex);

        ToastUtil.show(mContext, content, duration, gravity);
    }

    private int getGravityByIndex(int gravityIndex) {
        switch (gravityIndex) {
            case 0:
                return Gravity.TOP;
            case 2:
                return Gravity.CENTER;
            default:
                return Gravity.BOTTOM;
        }
    }

    private boolean getDurationByIndex(int durationIndex) {
        if (durationIndex == android.widget.Toast.LENGTH_LONG) {
            return true;
        } else {
            return false;
        }
    }
}

