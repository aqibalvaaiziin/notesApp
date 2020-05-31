import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:notesapp/redux/model/app_state_model.dart';
import 'package:notesapp/redux/store.dart';
import 'package:notesapp/screen/home_page/home_page.dart';
import 'package:notesapp/widgets/page_transition.dart';
import 'package:notesapp/widgets/splash_screen.dart';
import 'package:redux/redux.dart';

void main() async {
  Store<AppState> _store = await createStore();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp(store: _store));
  });
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  MyApp({this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
      ),
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
