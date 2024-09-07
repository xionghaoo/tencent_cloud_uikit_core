import 'package:flutter/cupertino.dart';
import 'package:tencent_cloud_uikit_core/src/tuicore_define.dart';
import 'package:tencent_cloud_uikit_core/src/abstract.dart';
import 'package:tencent_cloud_uikit_core/src/notification.dart';

class TUICore {
  TUICore._newObject();
  factory TUICore() => _instance;
  static final TUICore _instance = TUICore._newObject();
  static TUICore get instance => _instance;

  final Map<String, AbstractTUIService> _serviceMap = {};
  final Map<TUIExtensionID, AbstractTUIExtension> _extensionMap = {};

  void registerService(String serviceName, AbstractTUIService object) {
    _serviceMap[serviceName] = object;
  }

  void unregisterService(String serviceName) {
    _serviceMap.remove(serviceName);
  }

  /// check Service is exist
  ///
  /// @param serviceName      serviceName
  Future<bool> getService(String serviceName) {
    if (_serviceMap.containsKey(serviceName)) {
      return Future<bool>.value(true);
    }
    return Future<bool>.value(false);
  }

  /// call Service method
  ///
  /// @param serviceName      service name
  /// @param method           method name
  /// @param param            method param
  ///
  /// for example:
  ///
  /// use callKit single video call（groupId is "" meaning sing call）：
  /// callService(TUICALLKIT_SERVICE_NAME, METHOD_NAME_CALL, {
  ///                         PARAM_NAME_TYPE: TYPE_VIDEO,
  ///                         PARAM_NAME_USERIDS: ["111"],
  ///                         PARAM_NAME_GROUPID: ""
  ///                       });
  ///
  /// use callKit group video call（groupId is not "" meaning sing call）：
  /// callService(TUICALLKIT_SERVICE_NAME, METHOD_NAME_CALL, {
  ///                         PARAM_NAME_TYPE: TYPE_VIDEO,
  ///                         PARAM_NAME_USERIDS: ["111","222","333"],
  ///                         PARAM_NAME_GROUPID: "1234"
  ///                       });
  ///
  /// use callKit and set enable floating window:
  /// callService(TUICALLKIT_SERVICE_NAME, METHOD_NAME_ENABLE_FLOAT_WINDOW, {
  ///                         PARAM_NAME_ENABLE_FLOAT_WINDOW: true
  ///                       });
  ///
  /// the method name and method param please refer to tuicore_define.dart
  void callService(
      String serviceName, String method, Map<String, dynamic> param) async {

    if (!_serviceMap.containsKey(serviceName)) {
      return;
    }

    AbstractTUIService? service = _serviceMap[serviceName];
    service?.onCall(serviceName, method, param);
  }

  void registerExtension(TUIExtensionID extensionID, AbstractTUIExtension object) {
    _extensionMap[extensionID] = object;
  }

  void unregisterExtension(TUIExtensionID extensionID) {
    _extensionMap.remove(extensionID);
  }

  Future<Widget> raiseExtension(TUIExtensionID extensionID, Map<String, dynamic> param) {
    if (!_extensionMap.containsKey(extensionID)) {
      return  Future<Widget>.value(const SizedBox());
    }

    AbstractTUIExtension? service = _extensionMap[extensionID];
    return service!.onRaiseExtension(extensionID, param);
  }

  void registerEvent(String eventName, ITUINotificationCallback? callback) {
    ITUINotification().register(eventName, callback);
  }

  void unregisterEvent(String eventName, ITUINotificationCallback? callback) {
    ITUINotification().unregister(eventName, callback);
  }

  void notifyEvent(String eventName, [Map<String, dynamic>? arg]) {
    ITUINotification().notify(eventName, arg);
  }
}
