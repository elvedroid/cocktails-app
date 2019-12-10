import 'package:cocktail_app/feature/bottom_navigation/bottom_navigation.dart';
import 'package:cocktail_app/feature/bottom_navigation/bottom_navigator.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Cocktail app',
        theme: ThemeData(
            primarySwatch: primaryBlack, textTheme: Typography().white),
        home: MyHomePage(title: 'Cocktails'));
  }
}

const MaterialColor primaryBlack = MaterialColor(
  _blackPrimaryValue,
  <int, Color>{
    50: Color(0xFF000000),
    100: Color(0xFF000000),
    200: Color(0xFF000000),
    300: Color(0xFF000000),
    400: Color(0xFF000000),
    500: Color(_blackPrimaryValue),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);
const int _blackPrimaryValue = 0xFF000000;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  Map<int, GlobalKey<NavigatorState>> navigatorKeys = {
    0: GlobalKey<NavigatorState>(),
    1: GlobalKey<NavigatorState>(),
    2: GlobalKey<NavigatorState>(),
  };

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[_selectedIndex].currentState.maybePop(),
      child: Scaffold(
        appBar: AppBar(
          title:
              Text(widget.title, style: TextStyle(fontFamily: 'ComicSansMS')),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.add_shopping_cart),
              tooltip: 'Orders cart',
              onPressed: _openCart,
              iconSize: 28,
            ),
          ],
        ),
        bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
                canvasColor: Colors.black,
                textTheme: Theme.of(context)
                    .textTheme
                    .copyWith(caption: TextStyle(color: Colors.black54))),
            child: BottomNavigationBar(
              items: CocktailsBottomNavigation.getBottomNavigationBarItems(),
              currentIndex: _selectedIndex,
              selectedItemColor: Color(0xfff2003c),
              unselectedItemColor: Colors.white,
              onTap: _onItemTapped,
            )),
        body: Stack(children: <Widget>[
          _buildOffstageNavigator(0),
          _buildOffstageNavigator(1),
          _buildOffstageNavigator(2),
        ]),
      ),
    );
  }

  Widget _buildOffstageNavigator(int selectedIndex) {
    return Offstage(
      offstage: _selectedIndex != selectedIndex,
      child: BottomNavigator(
        navigatorKey: navigatorKeys[selectedIndex],
        selectedIndex: selectedIndex,
      ),
    );
  }

  Widget _openCart() {
    // return a widget representing a page
    return null;
  }
}
