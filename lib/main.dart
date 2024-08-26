import 'package:flutter/material.dart';
import 'coffescreen/Editpage.dart';
import 'coffescreen/LayoutWidget.dart';
import 'model/CoffeItem.dart';
import 'coffescreen/DetailPage.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MainApp> {
  int _currentIndex = 0;
  List<CoffeItem> coffeeList = [];
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  List<Widget> get _pages {
    return [
      LayoutWidget(
        coffeeList: coffeeList,
        onFavoriteToggle: _toggleFavorite,
      ),
      LayoutWidget(
        coffeeList: coffeeList.where((item) => item.isFavorite).toList(),
        onFavoriteToggle: _toggleFavorite,
      ),
    ];
  }

  void _toggleFavorite(CoffeItem item) {
    setState(() {
      item.isFavorite = !item.isFavorite;
    });
  }

  void addCoffeeItem(CoffeItem newItem) {
    setState(() {
      coffeeList.add(newItem);
    });
  }

  void _onItemTapped(int index) {
    if (index == 2) {
      // + 버튼이 눌렸을 때
      _navigateToEditPage();
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  void _navigateToEditPage() async {
    final result = await navigatorKey.currentState!.push(
      MaterialPageRoute(
        builder: (context) => Editpage(),
      ),
    );

    if (result != null && result is CoffeItem) {
      addCoffeeItem(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: "Coffe Cards",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Coffe Cards"),
        ),
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "홈",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "좋아요",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: "추가",
            ),
          ],
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
