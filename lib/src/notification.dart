typedef ITUINotificationCallback = void Function(dynamic arg);

class ITUINotification {
  ITUINotification._newObject();

  static final ITUINotification _singleton = ITUINotification._newObject();

  factory ITUINotification() => _singleton;

  final _messageQueue = <Object, List<ITUINotificationCallback>>{};

  void register(String eventName, ITUINotificationCallback? callback) {
    if (eventName != null && callback != null) {
      if (_messageQueue[eventName] == null) {
        _messageQueue[eventName] = <ITUINotificationCallback>[];
      }
      _messageQueue[eventName]?.add(callback);
    }
  }

  void unregister(String eventName, ITUINotificationCallback? callback) {
    if (eventName != null && callback != null) {
      var list = _messageQueue[eventName];
      if (list != null) {
        list.remove(callback);
      }
    }
  }

  void notify(String eventName, [Map<String, dynamic>? arg]) {
    var list = _messageQueue[eventName];
    if (list != null && list.isNotEmpty) {
      for (var i = 0; i < list.length; i++) {
        list[i](arg);
      }
    }
  }
}

const loginSuccessEvent = 'LOGIN_SUCCESS_EVENT';
const logoutSuccessEvent = 'LOGOUT_SUCCESS_EVENT';
const imSDKInitSuccessEvent = 'IM_SDK_INIT_SUCCESS_EVENT';