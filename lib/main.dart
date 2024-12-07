import 'package:cas_house/main_global.dart';
import 'package:cas_house/providers/dasboard_provider.dart';
import 'package:cas_house/providers/family_provider.dart';
import 'package:cas_house/providers/home_provider.dart';
import 'package:cas_house/providers/shopping_provider.dart';
import 'package:cas_house/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:cas_house/nav_bar/nav_bar_main.dart';
import 'package:cas_house/sections/section_main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => DashboardProvider()),
    ChangeNotifierProvider(create: (_) => HomeProvider()),
    ChangeNotifierProvider(create: (_) => ShoppingProvider()),
    ChangeNotifierProvider(create: (_) => FamilyProvider()),
    ChangeNotifierProvider(create: (_) => UserProvider())
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: chosenMode,
        builder: (context, themeMode, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: themeMode,
            home: Scaffold(body: HelloButton()),
          );
        });
  }
}

class HelloButton extends StatefulWidget {
  @override
  _HelloButtonState createState() => _HelloButtonState();
}

class _HelloButtonState extends State<HelloButton> {
  String message = "Press the button to fetch data";

  Future<void> fetchMessage() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/api/hello'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          message = data['message'];
        });
      } else {
        setState(() {
          message = 'Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        message = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          // Pass chosenSection and rebuild SectionMain when it changes
          ValueListenableBuilder<MainViews>(
        valueListenable:
            currentSite, // Observing the global `currentSite` for changes.
        builder: (context, currentSiteValue, child) {
          return _buildBody(); // Dynamically build the screen based on the selected view.
        },
      ),
      bottomNavigationBar: NavBarMain(),
    );
  }

  Widget _buildBody() {
    switch (currentSite.value) {
      case MainViews.slask:
        return Text("slask");
      case MainViews.news:
        return Text('news');
      case MainViews.events:
        return Text("events");
      case MainViews.explore:
        return Text("explore");
      default:
        return const Center(
            child: Text('Unknown section', style: TextStyle(fontSize: 24)));
    }
  }
}
