// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
//
// import '../providers/authentication_provider.dart';
// import '../resources/routes_manager.dart';
// import '../resources/theme_manager.dart';
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
//     return ScreenUtilInit(
//         designSize: Size(414, 896),
//         minTextAdapt: true,
//         splitScreenMode: true,
//         builder: () => MultiProvider(
//           providers: [
//             ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
//
//           ],
//           child: MaterialApp(
//             debugShowCheckedModeBanner: false,
//             onGenerateRoute: RouteGenerator.getRoute,
//             initialRoute: Routes.splashRoute,
//             theme: getApplicationTheme(),
//             builder: (context, widget) {
//               //add this line
//               ScreenUtil.setContext(context);
//               return MediaQuery(
//                 //Setting font does not change with system font size
//                 data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
//                 child: widget!,
//               );
//             },
//
//           ),
//         )
//
//     );
//
//     //   ScreenUtilInit(
//     //   designSize: const Size(414, 896),
//     //   minTextAdapt: true,
//     //   splitScreenMode: true,
//     //
//     //   builder: (child) {
//     //     return MaterialApp(
//     //       debugShowCheckedModeBanner: false,
//     //       title: 'First Method',
//     //       // You can use the library anywhere in the app even in theme
//     //       theme: getApplicationTheme(),
//     //
//     //       home: child,
//     //     );
//     //   },
//     //   child: const SplashView(),
//     // );
//
//
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/routes_manager.dart';
import '../resources/theme_manager.dart';
import '../resources/value_manager.dart';
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(AppSize.designWidth, AppSize.designHeight),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_) => MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: Routes.splashRoute,
          theme: getApplicationTheme(),
        ));
  }
}
