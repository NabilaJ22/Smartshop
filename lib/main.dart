import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utils/shared_prefs.dart';
import 'providers/cart_provider.dart';
import 'providers/favourites_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/splash_screen.dart';
import 'utils/theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init(); // Initialize SharedPreferences
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => FavouritesProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'Flutter Shop',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeProvider.isDark ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
