import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:tencent_cloud_uikit_core/platform/tuicore_platform_interface.dart';
import 'package:tencent_cloud_uikit_core/tencent_cloud_uikit_core.dart';

/// An implementation of [TUICorePlatform] that uses method channels.
class MethodChannelTUICore extends TUICorePlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('tuicore');

  @override
  Future<void> showToast(
      String content, TUIDuration duration, TUIGravity gravity) async {
    if (!kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      await methodChannel.invokeMethod('showToast', {
        'content': content,
        'duration': duration.index,
        'gravity': gravity.index
      });
    }
  }
}
