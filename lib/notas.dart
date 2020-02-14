// import 'package:flutter/material.dart';
// import 'package:flare_flutter/asset_provider.dart';
// import 'package:flare_flutter/cache.dart';
// import 'package:flare_flutter/cache_asset.dart';
// import 'package:flare_flutter/flare.dart';
// import 'package:flare_flutter/flare_actor.dart';
// import 'package:flare_flutter/flare_cache.dart';
// import 'package:flare_flutter/flare_cache_asset.dart';
// import 'package:flare_flutter/flare_cache_builder.dart';
// import 'package:flare_flutter/flare_controller.dart';
// import 'package:flare_flutter/flare_controls.dart';
// import 'package:flare_flutter/flare_render_box.dart';
// import 'package:flare_flutter/flare_testing.dart';
// import 'package:flare_flutter/provider/asset_flare.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(title: 'Flare Welcome', home: SplashScreen());
//   }
// }

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration(seconds: 4), () {
//       Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => HomeView(),
//           ));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FlareActor("lib/style/splash.flr",
//           alignment: Alignment.center, fit: BoxFit.contain, animation: "Alarm"),
//     );
//   }
// }

// class HomeView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xff181818),
//       body: Center(
//         child: Text(
//           'Home View',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//     );
//   }
// }
