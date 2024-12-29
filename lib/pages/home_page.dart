import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habittracker/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Habit Tracker',
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Center(
          child: CupertinoSwitch(
            value: context.watch<ThemeProvider>().isDarkMode,
            onChanged: (value) {
              context.read<ThemeProvider>().toggleTheme();
            },
          ),
        ),
      ),
    );
  }
}
