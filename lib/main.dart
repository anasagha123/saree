import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:saree/network/local/local_db.dart';
import 'package:saree/screens/loading_screen.dart';

import 'config/device_locale.dart';
import 'config/device_size.dart';
import 'config/navigation.dart';
import 'config/theme.dart';
import 'network/local/my_shared_preferences.dart';
import 'network/remote/dio_helper.dart';
import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/location_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    DeviceSize.init(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        theme: MyTheme.appTheme(context),
        supportedLocales: const [Locale("ar"), Locale("en")],
        locale: const Locale('ar'),
        routes: Navigation.routes,
        home: Navigation.initialRoute == LoadingScreen.routeName? LoadingScreen(LoadingScreenArguments(getUserData: true)): null,
        initialRoute: Navigation.initialRoute,
      ),
    );
  }
}

Future<void> init() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await SharedPreferencesHelper.init();
  await DioHelper.getUserTokenFromCache();
  DeviceLocale.init();
  if (DioHelper.User_Token != null) {
    Navigation.initialRoute = LoadingScreen.routeName;
  }
  await MyDatabase.init();
}
