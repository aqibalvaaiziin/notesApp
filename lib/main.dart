import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notesapp/screen/home_page/home.dart';
import 'package:notesapp/widgets/page_transition.dart';
import 'package:notesapp/widgets/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    new Future.delayed(const Duration(seconds: 4),
        () => Navigator.of(context).pushReplacement(createRoute(HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          width: screenSize.width,
          height: screenSize.height,
          child: splashSreen(context)),
    );
  }
}
