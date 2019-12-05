import 'dart:async';

import 'package:cocktail_app/bloc/bloc.dart';
import 'package:cocktail_app/model/drink.dart';
import 'package:cocktail_app/repo/drink_repo.dart';

class DrinkQueryBloc implements Bloc {
  final _controller = StreamController<List<Drink>>();
  final _repo = DrinkRepo();

  Stream<List<Drink>> get searchDrinksStream => _controller.stream;

  void submitQuery(String query) async {
    final drinks = await _repo.searchDrinks(query);
    _controller.sink.add(drinks);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
