import 'package:flutter/material.dart';
import 'package:flutter_application_3/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_3/theme/them_provider.dart';
import 'package:flutter_application_3/models/playlist.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ThemProvider()),
    ChangeNotifierProvider(create: (context) => Playlistprovider()),
  ],
  child: const MyApp(),
  ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: Provider.of<ThemProvider>(context).themeData,
    );
  }
}
