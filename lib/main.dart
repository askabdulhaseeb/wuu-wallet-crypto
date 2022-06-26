import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/app_theme.dart';
import 'screens/auth/signin_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/intro_screen/intro_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // ignore: always_specify_types
      providers: [
        ChangeNotifierProvider<AppThemeProvider>.value(
          value: AppThemeProvider(),
        ),
      ],
      child: Consumer<AppThemeProvider>(
          builder: (BuildContext context, AppThemeProvider theme, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Muu Wallet',
          theme: AppThemes.light,
          darkTheme: AppThemes.dark,
          themeMode: theme.themeMode,
          home: const IntroScreen(),
          routes: <String, WidgetBuilder>{
            SigninScreen.routeName: (_) => const SigninScreen(),
            SignupScreen.routeName: (_) => const SignupScreen(),
          },
        );
      }),
    );
  }
}
