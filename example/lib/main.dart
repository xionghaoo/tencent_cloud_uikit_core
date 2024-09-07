import 'package:flutter/material.dart';
import 'dart:async';
import 'package:tencent_cloud_uikit_core/tencent_cloud_uikit_core.dart';
import 'generate_test_user_sig.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool enableFloatWindow = false;
  final _tencentImBaseTUICore = TUICore.instance;
  final _tencentImBaseTUILogin = TUILogin.instance;

   Widget? joinWidget;
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SizedBox(
          child: ListView(
            padding: const EdgeInsets.all(40), //沿主轴方向居中
            children: <Widget>[
              Container(
                height: 50.0,
                child: ElevatedButton(
                  child: const Text("getService"),
                  onPressed: () {
                    TUIToast.show(content: "getService: ${_tencentImBaseTUICore.getService(TUICALLKIT_SERVICE_NAME)}");
                  },
                ),
              ),
              Container(
                height: 50.0,
                padding: const EdgeInsets.only(top: 5),
                child: ElevatedButton(
                  child: const Text("callService-singlecall"),
                  onPressed: () {
                    setState(() {
                      _tencentImBaseTUICore.callService(
                          TUICALLKIT_SERVICE_NAME, METHOD_NAME_CALL, {
                        PARAM_NAME_TYPE: TYPE_AUDIO,
                        PARAM_NAME_USERIDS: ["8558"],
                        PARAM_NAME_GROUPID: ""
                      });
                    });
                  },
                ),
              ),
              Container(
                height: 50.0,
                padding: const EdgeInsets.only(top: 5),
                child: ElevatedButton(
                  child: const Text("callService-groupcall"),
                  onPressed: () {
                    setState(() {
                      _tencentImBaseTUICore.callService(
                          TUICALLKIT_SERVICE_NAME, METHOD_NAME_CALL, {
                        PARAM_NAME_TYPE: TYPE_VIDEO,
                        PARAM_NAME_USERIDS: ["6696", "8558"],
                        PARAM_NAME_GROUPID: "@TGS#1EMAACGNK"
                      });
                    });
                  },
                ),
              ),
              Container(
                height: 50.0,
                padding: const EdgeInsets.only(top: 5),
                child: ElevatedButton(
                  child: const Text("callService-floatWindow"),
                  onPressed: () {
                    setState(() {
                      enableFloatWindow = !enableFloatWindow;
                      if (enableFloatWindow) {
                        TUIToast.show(content: "show float window");
                      } else {
                        TUIToast.show(content: "hide float window");
                      }
                      _tencentImBaseTUICore.callService(
                          TUICALLKIT_SERVICE_NAME,
                          METHOD_NAME_ENABLE_FLOAT_WINDOW,
                          {PARAM_NAME_ENABLE_FLOAT_WINDOW: enableFloatWindow});
                    });
                  },
                ),
              ),
              Container(
                height: 50.0,
                padding: const EdgeInsets.only(top: 5),
                child: ElevatedButton(
                  child: const Text("login"),
                  onPressed: () {
                      TUILogin.instance.login(
                          GenerateTestUserSig.sdkAppId,
                          "8558",
                          GenerateTestUserSig.genTestSig("8558"), TUICallback());
                      setState(() {});
                  },
                ),
              ),
              Container(
                height: 50.0,
                padding: const EdgeInsets.only(top: 5),
                child: ElevatedButton(
                  child: const Text("logout"),
                  onPressed: () {
                    setState(() {
                      _tencentImBaseTUILogin.logout(TUICallback(onSuccess: () {
                        TUIToast.show(content: "logout success");
                      }, onError: (int code, String message) {
                        TUIToast.show(content: "logout fail, code:${code} message:${message}");
                      }));
                      joinWidget = null;
                    });
                  },
                ),
              ),
              Container(
                height: 50.0,
                padding: const EdgeInsets.only(top: 5),
                child: ElevatedButton(
                  child: const Text("Toast-Center"),
                  onPressed: () {
                    TUIToast.show(content: "success", duration: TUIDuration.short, gravity: TUIGravity.center);
                  },
                ),
              ),
            Container(
              height: 50.0,
              padding: const EdgeInsets.only(top: 5),
              child: ElevatedButton(
                child: const Text("Toast-Bottom"),
                onPressed: () {
                  TUIToast.show(content: "success", duration: TUIDuration.short, gravity: TUIGravity.bottom);
                },
              )
            ),
            Container(
                height: 50.0,
                padding: const EdgeInsets.only(top: 5),
                child: ElevatedButton(
                  child: const Text("Toast-Top"),
                  onPressed: () {
                    TUIToast.show(content: "success", duration: TUIDuration.short, gravity: TUIGravity.top);
                  },
                )
            ),
            Container(
                height: 50.0,
                padding: const EdgeInsets.only(top: 5),
                child: ElevatedButton(
                  child: const Text("Toast-None"),
                  onPressed: () {
                    TUIToast.show(content: "success");
                  },
                )
            ),
              Container(
                  height: 50.0,
                  padding: const EdgeInsets.only(top: 5),
                  child: ElevatedButton(
                    child: const Text("Check Group Call"),
                    onPressed: () async {
                      joinWidget = await TUICore.instance.raiseExtension(TUIExtensionID.joinInGroup, {GROUP_ID: '@TGS#15HPAZDOZ'});
                      setState(() {});
                    },
                  ),
              ),
              joinWidget != null ? joinWidget! : const SizedBox()
          ],
        ),
      ),
    ));
  }
}
