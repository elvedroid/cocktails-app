import 'package:cocktail_app/bloc/bloc_provider.dart';
import 'package:cocktail_app/bloc/favorite_drinks_bloc.dart';
import 'package:cocktail_app/model/drink.dart';
import 'package:cocktail_app/model/user.dart';
import 'package:flutter/material.dart';

class FavoriteDrinks extends StatefulWidget {
  final User user;

  const FavoriteDrinks({this.user, Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => FavoriteDrinksState();
}

class FavoriteDrinksState extends State<FavoriteDrinks> {
  final favoriteDrinksBloc = FavoriteDrinksBloc();

  @override
  void initState() {
    super.initState();
    favoriteDrinksBloc.getFavoriteDrinks(widget.user);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider<FavoriteDrinksBloc>(
      bloc: favoriteDrinksBloc,
      child: _buildResults(favoriteDrinksBloc),
    );
  }
}

Widget _buildResults(FavoriteDrinksBloc bloc) {
  return StreamBuilder<List<Drink>>(
    stream: bloc.favoriteDrinksStream,
    builder: (context, snapshot) {
      final results = snapshot.data;

      if (results == null) {
        return Center(child: Text(''));
      }

      if (results.isEmpty) {
        return Center(child: Text('No Results'));
      }

      return _buildFavoriteDrinks(results);
    },
  );
}

Widget _buildFavoriteDrinks(List<Drink> results) {
  return GridView.count(
    crossAxisCount: 2,
    children: List.generate(results.length, (index) {
      Drink drink = results[index];
      return Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            FadeInImage.assetNetwork(
                placeholderScale: null,
                placeholder: 'images/cocktail_anim.gif',
                image: drink.strDrinkThumb),
            Positioned(
              height: 50,
              left: 0.0,
              right: 0.0,
              child: Container(
                color: Color(0x88000000),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(drink.strDrink,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontSize: 15.0,
                        )),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                alignment: AlignmentDirectional.centerEnd,
                color: Color(0x88000000),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      Icon(Icons.shopping_cart, color: Color(0xfff56040), size: 28),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 36,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Icon(Icons.favorite, color: Color(0xfff2003c), size: 28),
              ),
            ),
          ]);
    }),
  );
}
