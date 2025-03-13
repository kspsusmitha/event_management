import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/splash_screen.dart';
import 'utils/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Force dark theme by setting system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: AppTheme.darkBackground,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  // Force immersive mode
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Red Carpet',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark, // Force dark theme
      darkTheme: AppTheme.darkTheme, // Use our custom dark theme
      theme: AppTheme.darkTheme, // Use same dark theme even in light mode
      home: const SplashScreen(),
    );
  }
}
