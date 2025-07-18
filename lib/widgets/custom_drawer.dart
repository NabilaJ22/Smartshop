import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../utils/shared_prefs.dart';
import '../screens/home_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/favourite_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/login_screen.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    void _logout() async {
      await SharedPrefs.clear();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
            (route) => false,
      );
    }

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Text('Flutter Shop', style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen())),
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Cart'),
            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => CartScreen())),
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favourites'),
            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => FavouritesScreen())),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ProfileScreen())),
          ),
          Divider(),
          SwitchListTile(
            title: Text('Dark Theme'),
            value: themeProvider.isDark,
            onChanged: (val) => themeProvider.toggleTheme(),
            secondary: Icon(themeProvider.isDark ? Icons.dark_mode : Icons.light_mode),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: _logout,
          ),
        ],
      ),
    );
  }
}
