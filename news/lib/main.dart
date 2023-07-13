import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news/providers/theme_provider.dart';
import 'package:news/providers/auth_provider.dart';
import 'package:news/screens/auth_screen/auth_screen.dart';
import 'package:news/screens/favourite_screen/favourites_screen.dart';
import 'package:news/screens/news_detail_screen/news_detail_web_view.dart';
import 'package:news/screens/news_detail_screen/news_details_screen.dart';
import 'package:provider/provider.dart';
import 'providers/news_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeProvider themeProvider = ThemeProvider();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => NewsProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'News app',
          home: const AuthScreen(),
          routes: {
            FavouriteScreen.routeName: (context) => const FavouriteScreen(),
            NewsDetailWebView.routeName: (context) => const NewsDetailWebView(),
            NewsDetailsScreen.routeName: (context) => const NewsDetailsScreen(),
          },
        ),
      ),
    );
  }
}
