import 'package:flutter/material.dart';
import 'package:h_flutter_example_project/views/AddNumberScreen.dart';
import 'package:h_flutter_example_project/views/FavoriteNumberListScreen.dart';
import 'package:h_flutter_example_project/views/RootScreen.dart';
import 'package:provider/provider.dart';

import '../themes/ThemeProvider.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  LayoutState createState() => LayoutState();
}

class LayoutState extends State<Layout> {
  int _currentIndex = 0; // 변수명 수정

  final List<Widget> _pages = [
    const Rootscreen(),
     FavoriteNumberListScreen(),
     AddNumberScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
          title: const Text("전화번호"),
        actions: [
          IconButton(
            icon: Icon(themeProvider.themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "main",
          ),
        ],
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
