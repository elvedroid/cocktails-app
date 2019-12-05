import 'package:cocktail_app/feature/explore_coctails/explore_coctails.dart';
import 'package:cocktail_app/feature/home/home.dart';
import 'package:flutter/material.dart';

class CocktailsBottomNavigation {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> widgetOptions = <Widget>[
    Home(),
    ExploreCocktails(),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: School',
      style: optionStyle,
    ),
  ];

  static List<BottomNavigationBarItem> getBottomNavigationBarItems() {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text("Home"),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.beach_access),
        title: Text("Explore"),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        title: Text("Favorites"),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.more_horiz),
        title: Text("More"),
      ),
    ];
  }
}
