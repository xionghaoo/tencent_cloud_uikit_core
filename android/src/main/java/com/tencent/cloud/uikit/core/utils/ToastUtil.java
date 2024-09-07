package com.tencent.cloud.uikit.core.utils;

import android.content.Context;
import android.os.Build;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

public class ToastUtil {
    private static boolean enableToast = true;

    public static void show(Context context, String message, boolean isLong, int gravity) {
        if (!enableToast) {
            return;
        }
        showToast(createToast(context, message, isLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT, gravity));
    }

    private static void showToast(final Toast toast) {
        if (toast != null) {
            toast.show();
        }
    }

    private static Toast createToast(Context context, String message, int duration, int gravity) {
        Toast toast = Toast.makeText(context, message, duration);
        toast.setGravity(gravity, 0, 0);
        View view = toast.getView();
        if (view != null) {
            TextView textView = view.findViewById(android.R.id.message);
            if (textView != null) {
                textView.setGravity(gravity);
            }
        }

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            toast.addCallback(new Toast.Callback() {
                @Override
                public void onToastHidden() {
                    super.onToastHidden();
                    showToast(null);
                }
            });
        }

        return toast;
    }
}
