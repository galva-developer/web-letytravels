import 'package:flutter/material.dart';
import 'package:by_lety_travels/presentation/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'By Lety Travels',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        fontFamily: 'LetyTravelsFont', // Set the default font family
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF314A63)),
        appBarTheme: const AppBarTheme(
          // Define default text style for AppBar elements
          titleTextStyle: TextStyle(
            fontFamily:
                'LetyTravelsFont', // Apply custom font to AppBar titles/text
            color:
                Colors
                    .white, // Default color for AppBar text, can be overridden
            fontSize: 18.0, // Default font size for AppBar text
          ),
          toolbarTextStyle: TextStyle(
            fontFamily:
                'LetyTravelsFont', // Apply custom font to AppBar toolbar elements
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
