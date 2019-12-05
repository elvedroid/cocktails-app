import 'dart:async';

import 'package:cocktail_app/bloc/bloc.dart';
import 'package:cocktail_app/model/drink_category.dart';
import 'package:cocktail_app/repo/drink_repo.dart';

class DrinkCategoriesBloc implements Bloc {
  final _controller = StreamController<List<DrinkCategory>>();
  final _repo = DrinkRepo();

  Stream<List<DrinkCategory>> get drinkCategoriesStream => _controller.stream;

  void getCategories() async {
    final categories = await _repo.getCategories();
    _controller.sink.add(categories);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
