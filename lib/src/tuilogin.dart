import 'package:tencent_cloud_chat_sdk/enum/V2TimSDKListener.dart';
import 'package:tencent_cloud_chat_sdk/enum/log_level_enum.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_callback.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_value_callback.dart';
import 'package:tencent_cloud_chat_sdk/tencent_im_sdk_plugin.dart';
import 'package:tencent_cloud_uikit_core/src/notification.dart';
import 'package:tencent_cloud_uikit_core/src/tuicallback.dart';
import 'package:tencent_cloud_uikit_core/src/tuicore.dart';

class TUILogin {
  TUILogin._newObject();
  factory TUILogin() => _instance;
  static final TUILogin _instance = TUILogin._newObject();
  static TUILogin get instance => _instance;

  /// login IM
  ///
  /// @param sdkAppId      sdkAppId
  /// @param userId        userId
  /// @param userSig       userSig
  Future<void> login(
      int sdkAppId, String userId, String userSig, TUICallback callback, [V2TimSDKListener? listener]) async {
    V2TimValueCallback<bool> isInit = await TencentImSDKPlugin.v2TIMManager.initSDK(sdkAppID: sdkAppId, loglevel: LogLevelEnum.V2TIM_LOG_INFO, listener: listener ?? V2TimSDKListener());

    if (isInit.data == false) {
      callback.onError!(-1, ' Login Fail: IM SDK init fail');
      return;
    }
    TUICore.instance.notifyEvent(imSDKInitSuccessEvent, {});

    V2TimCallback res = await TencentImSDKPlugin.v2TIMManager.login(userID: userId, userSig: userSig);
    if (res.code == 0) {
      TUICore.instance.notifyEvent(loginSuccessEvent, {'sdkAppId': sdkAppId, 'userId': userId, 'userSig': userSig});
      callback.onSuccess!();
    } else {
      callback.onError!(res.code,res.desc);
    }
  }

  /// logout IM
  Future<void> logout(TUICallback callback) async {
    V2TimCallback res = await TencentImSDKPlugin.v2TIMManager.logout();

    if (res.code == 0) {
      await TencentImSDKPlugin.v2TIMManager.unInitSDK();
      TUICore.instance.notifyEvent(logoutSuccessEvent);
      callback.onSuccess!();
    } else {
      callback.onError!(res.code,res.desc);
    }
  }
}
