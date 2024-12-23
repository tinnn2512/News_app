import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:news_app/provider/app_provider.dart';
import 'package:news_app/views/custom_bar/custom_bar.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Permission.camera.request();
  // await Permission.microphone.request();
  // await Permission.storage.request();

  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
    await InAppWebViewController.setWebContentsDebuggingEnabled(kDebugMode);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  initLoading() {
    var init = EasyLoading.init();
    EasyLoading.instance
      ..maskType = EasyLoadingMaskType.black
      ..animationStyle = EasyLoadingAnimationStyle.opacity
      ..userInteractions = false;
    return init;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppProvider>(
      create: ((context) => AppProvider()),
      child: MaterialApp(
        title: 'Newscape',
        builder: initLoading(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const CustomBar(),
      ),
    );
  }
}
