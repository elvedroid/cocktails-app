import 'dart:async';

import 'package:cocktail_app/bloc/bloc.dart';
import 'package:cocktail_app/model/drink.dart';
import 'package:cocktail_app/model/user.dart';
import 'package:cocktail_app/repo/drink_repo.dart';

class FavoriteDrinksBloc implements Bloc {
  final _controller = StreamController<List<Drink>>();
  final _repo = DrinkRepo();

  Stream<List<Drink>> get favoriteDrinksStream => _controller.stream;

  void getFavoriteDrinks(User user) async {
    final favoriteDrinks = await _repo.getFavoriteDrinks(user);
    _controller.sink.add(favoriteDrinks);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
