import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:tencent_cloud_uikit_core/platform/tuicore_method_channel.dart';
import 'package:tencent_cloud_uikit_core/src/tuicore_define.dart';

abstract class TUICorePlatform extends PlatformInterface {
  /// Constructs a TencentImBasePlatform.
  TUICorePlatform() : super(token: _token);

  static final Object _token = Object();

  static TUICorePlatform _instance = MethodChannelTUICore();

  /// The default instance of [TUICorePlatform] to use.
  ///
  /// Defaults to [MethodChannelTUICore].
  static TUICorePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TUICorePlatform] when
  /// they register themselves.
  static set instance(TUICorePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> showToast(
      String content, TUIDuration duration, TUIGravity gravity) async {
    await instance.showToast(content, duration, gravity);
  }
}
