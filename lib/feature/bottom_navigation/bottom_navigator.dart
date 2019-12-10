import 'package:cocktail_app/feature/drink_details/drink_details_view.dart';
import 'package:cocktail_app/feature/drinks_by_category/drinks_by_category.dart';
import 'package:cocktail_app/feature/explore_coctails/explore_coctails.dart';
import 'package:cocktail_app/feature/favorites/favorite_drinks.dart';
import 'package:cocktail_app/feature/home/home.dart';
import 'package:cocktail_app/feature/search/search.dart';
import 'package:cocktail_app/model/drink.dart';
import 'package:cocktail_app/model/drink_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bottom_navigation.dart';

class ExploreRoute {
  static const String root = '/';
  static const String drinks = '/drinks';
  static const String drink_details = '/drink_details';
}

class HomeRoute {
  static const String root = '/';
  static const String drink_details = '/drink_details';
}

class SearchRoute {
  static const String root = '/';
  static const String drink_details = '/drink_details';
}

class BottomNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  final int selectedIndex;

  final ValueChanged<String> changeTitle;

  BottomNavigator({this.navigatorKey, this.selectedIndex, this.changeTitle});

  void _explorePush(BuildContext context, String exploreRoute,
      {DrinkCategory drinkCategory: null, Drink drink: null}) {
    var routeBuilders = _exploreRouteBuilders(context,
        drinkCategory: drinkCategory, drink: drink);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => routeBuilders[exploreRoute](context)));
  }

  Map<String, WidgetBuilder> _exploreRouteBuilders(BuildContext context,
      {DrinkCategory drinkCategory: null, Drink drink: null}) {
    return {
      ExploreRoute.root: (context) => ExploreCocktails(
          onPush: (DrinkCategory category) => {
                _explorePush(context, ExploreRoute.drinks,
                    drinkCategory: category),
                changeTitle(category.strCategory)
              }),
      ExploreRoute.drinks: (context) => DrinksByCategory(
            drinkCategory,
            onPush: (Drink drink) => {
              changeTitle(drink.strDrink),
              _explorePush(context, ExploreRoute.drink_details, drink: drink),
            },
          ),
      ExploreRoute.drink_details: (context) => DrinkDetails(drink),
    };
  }

  @override
  Widget build(BuildContext context) {
    if (selectedIndex == 20) {
      var routeBuilders = _homeRouteBuilders(context);
      return Navigator(
          key: navigatorKey,
          initialRoute: HomeRoute.root,
          onGenerateRoute: (routeSettings) {
            return MaterialPageRoute(
                builder: (context) =>
                    routeBuilders[routeSettings.name](context));
          });
    } else if (selectedIndex == 1) {
      var routeBuilders = _exploreRouteBuilders(context);
      return Navigator(
          key: navigatorKey,
          initialRoute: ExploreRoute.root,
          onGenerateRoute: (routeSettings) {
            return MaterialPageRoute(
                builder: (context) =>
                    routeBuilders[routeSettings.name](context));
          });
    } else if (selectedIndex == 4) {
      var routeBuilders = _searchRouteBuilders(context);
      return Navigator(
          key: navigatorKey,
          initialRoute: SearchRoute.root,
          onGenerateRoute: (routeSettings) {
            return MaterialPageRoute(
                builder: (context) =>
                    routeBuilders[routeSettings.name](context));
          });
    } else {
      return CocktailsBottomNavigation.widgetOptions.elementAt(selectedIndex);
    }
  }

  Map<String, WidgetBuilder> _homeRouteBuilders(BuildContext context,
      {Drink drink: null}) {
    return {
      HomeRoute.root: (context) => Home(
          onPush: (Drink drink) => {
                _homePush(context, HomeRoute.drink_details, drink: drink),
                changeTitle(drink.strDrink)
              }),
      HomeRoute.drink_details: (context) => DrinkDetails(drink),
    };
  }

  void _homePush(BuildContext context, String homeRoute, {Drink drink: null}) {
    var routeBuilders = _homeRouteBuilders(context, drink: drink);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => routeBuilders[homeRoute](context)));
  }

  Map<String, WidgetBuilder> _searchRouteBuilders(BuildContext context,
      {Drink drink: null}) {
    return {
      SearchRoute.root: (context) => SearchView(
          onPush: (Drink drink) => {
                _searchPush(context, SearchRoute.drink_details, drink: drink),
                changeTitle(drink.strDrink)
              }),
      SearchRoute.drink_details: (context) => DrinkDetails(drink),
    };
  }

  void _searchPush(BuildContext context, String searchROute,
      {Drink drink: null}) {
    var routeBuilders = _searchRouteBuilders(context, drink: drink);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => routeBuilders[searchROute](context)));
  }
}
