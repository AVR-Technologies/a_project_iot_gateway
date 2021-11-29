import 'package:flutter/material.dart';
import 'package:gateway/pages/home_page.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await DbHandler().connect();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
        appBarTheme: ThemeData.light().appBarTheme.copyWith(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          foregroundColor: Colors.grey.shade800,
          shape: Border(
            bottom: BorderSide(width: 1, color: Colors.grey.shade300,),
          ),
        ),
        switchTheme: ThemeData.light().switchTheme.copyWith(
        ),
        scaffoldBackgroundColor: Colors.white,
        cardTheme: ThemeData.light().cardTheme.copyWith(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(width: 1, color: Colors.grey.shade400,),
          ),
          elevation: 0,
        ),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      home: const HomePage(),
    );
  }
}
