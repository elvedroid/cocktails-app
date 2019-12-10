import 'dart:async';

import 'package:cocktail_app/bloc/bloc.dart';
import 'package:cocktail_app/model/drink.dart';
import 'package:cocktail_app/model/user.dart';
import 'package:cocktail_app/repo/drink_repo.dart';

class RecommendedDrinksBloc implements Bloc {
  final _controller = StreamController<List<Drink>>();
  final _repo = DrinkRepo();

  Stream<List<Drink>> get recommendedDrinksStream => _controller.stream;

  void getRecommendedDrinks(User user) async {
    final favoriteDrinks = await _repo.getRecommendedDrinks(user);
    _controller.sink.add(favoriteDrinks);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
