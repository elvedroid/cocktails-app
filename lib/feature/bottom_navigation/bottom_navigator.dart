import 'package:cocktail_app/feature/drink_details/drink_details_view.dart';
import 'package:cocktail_app/feature/drinks_by_category/drinks_by_category.dart';
import 'package:cocktail_app/feature/explore_coctails/explore_coctails.dart';
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

class BottomNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  final int selectedIndex;

  BottomNavigator({this.navigatorKey, this.selectedIndex});

  void _explorePush(BuildContext context, String exploreRoute,
      {DrinkCategory drinkCategory: null, Drink drink: null}) {
    var routeBuilders =
        _exploreRouteBuilders(context, drinkCategory: drinkCategory, drink: drink);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => routeBuilders[exploreRoute](context)));
  }

  Map<String, WidgetBuilder> _exploreRouteBuilders(BuildContext context,
      {DrinkCategory drinkCategory: null, Drink drink: null}) {
    return {
      ExploreRoute.root: (context) => ExploreCocktails(
            onPush: (category) => _explorePush(context, ExploreRoute.drinks,
                drinkCategory: drinkCategory),
          ),
      ExploreRoute.drinks: (context) => DrinksByCategory(
            drinkCategory,
            onPush: (drink) =>
                _explorePush(context, ExploreRoute.drink_details, drink: drink),
          ),
      ExploreRoute.drink_details: (context) => DrinkDetails(
            drink,
          ),
    };
  }

  @override
  Widget build(BuildContext context) {
    if (selectedIndex == 1) {
      var routeBuilders = _exploreRouteBuilders(context);
      return Navigator(
          key: navigatorKey,
          initialRoute: ExploreRoute.root,
          onGenerateRoute: (routeSettings) {
            return MaterialPageRoute(
                builder: (context) =>
                    routeBuilders[routeSettings.name](context));
          });
    } else {
      return CocktailsBottomNavigation.widgetOptions.elementAt(selectedIndex);
    }
  }
}
