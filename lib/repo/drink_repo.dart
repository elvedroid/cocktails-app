import 'dart:convert';

import 'package:cocktail_app/model/drink.dart';
import 'package:cocktail_app/model/drink_category.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class DrinkRepo {
  Future<List<Drink>> searchDrinks(String query) async {
    final response = await http.get(
        "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=" + query);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var drinks = data["drinks"] as List;
      return drinks.map<Drink>((json) => Drink.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load drinks!");
    }
  }

  Future<List<DrinkCategory>> getCategories() async {
    final response = await http
        .get("https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list");
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var drinks = data["drinks"] as List;
      return drinks
          .map<DrinkCategory>((json) => DrinkCategory.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load categories!");
    }
  }

  Future<List<Drink>> getFilteredDrinksByCategory(DrinkCategory category) async {
    final response = await http
        .get("https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=" + category.strCategory);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var drinks = data["drinks"] as List;
      return drinks
          .map<Drink>((json) => Drink.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load drinks from this category!");
    }
  }
}
