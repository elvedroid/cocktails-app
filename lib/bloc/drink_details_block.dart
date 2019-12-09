import 'dart:async';

import 'package:cocktail_app/bloc/bloc.dart';
import 'package:cocktail_app/model/drink.dart';
import 'package:cocktail_app/model/drink_category.dart';
import 'package:cocktail_app/repo/drink_repo.dart';

class DrinkDetailsBloc implements Bloc {
  final _controller = StreamController<List<Drink>>();
  final _repo = DrinkRepo();

  Stream<List<Drink>> get drinkDetailsStream => _controller.stream;

  void getDrinkDetails(Drink drink) async {
    final drinkDetails = await _repo.getDrinkDetails(drink);
    _controller.sink.add(drinkDetails);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
