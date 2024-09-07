import 'package:tencent_cloud_uikit_core/src/tuicore_define.dart';
import 'package:flutter/cupertino.dart';

abstract class AbstractTUIExtension {
  Future<Widget> onRaiseExtension(TUIExtensionID extensionID, Map<String, dynamic> param);
}

abstract class AbstractTUIService {
  void onCall(String serviceName, String method, Map<String, dynamic> param);
}