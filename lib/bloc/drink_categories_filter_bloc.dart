import 'dart:async';

import 'package:cocktail_app/bloc/bloc.dart';
import 'package:cocktail_app/model/drink.dart';
import 'package:cocktail_app/model/drink_category.dart';
import 'package:cocktail_app/repo/drink_repo.dart';

class DrinkCategoriesFilterBloc implements Bloc {
  final _controller = StreamController<List<Drink>>();
  final _repo = DrinkRepo();

  Stream<List<Drink>> get drinkCategoriesFilterStream => _controller.stream;

  void getFilteredDrinksByCategory(DrinkCategory category) async {
    final filteredDrinksByCategory = await _repo.getFilteredDrinksByCategory(category);
    _controller.sink.add(filteredDrinksByCategory);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
