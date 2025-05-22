import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:note/app/routes/app_pages.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill; // Required for delegate


import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(402, 874),
      builder: (context, child) {
        return GetMaterialApp.router(
          scaffoldMessengerKey: rootScaffoldMessengerKey,
          theme: ThemeData(
            fontFamily: 'ferdoka',
            scaffoldBackgroundColor: const Color(0xfffafafa),
            pageTransitionsTheme: PageTransitionsTheme(
              builders:
                  Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
                    TargetPlatform.values,
                    value: (_) => const FadeForwardsPageTransitionsBuilder(),
                  ),
            ),
          ),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            quill.FlutterQuillLocalizations.delegate,
          ],
          scrollBehavior: CupertinoScrollBehavior(),
          routerDelegate: AppPages.router.routerDelegate,
          routeInformationParser: AppPages.router.routeInformationParser,
          routeInformationProvider: AppPages.router.routeInformationProvider,
        );
      },
    );
  }
}
