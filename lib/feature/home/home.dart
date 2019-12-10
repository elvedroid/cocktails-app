import 'package:cocktail_app/bloc/bloc_provider.dart';
import 'package:cocktail_app/bloc/favorite_drinks_bloc.dart';
import 'package:cocktail_app/bloc/recommended_drinks_bloc.dart';
import 'package:cocktail_app/model/drink.dart';
import 'package:cocktail_app/model/user.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final ValueChanged<Drink> onPush;

  const Home({Key key, this.onPush}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  final recommendedDrinksBloc = FavoriteDrinksBloc();

  @override
  void initState() {
    super.initState();
    recommendedDrinksBloc.getFavoriteDrinks(User());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoriteDrinksBloc>(
      bloc: recommendedDrinksBloc,
      child: _buildResults(recommendedDrinksBloc, widget.onPush),
    );
  }

  @override
  void dispose() {
    recommendedDrinksBloc.dispose();
    super.dispose();
  }
}

Widget _buildResults(FavoriteDrinksBloc bloc, onPush) {
  return StreamBuilder<List<Drink>>(
    stream: bloc.favoriteDrinksStream,
    builder: (context, snapshot) {
      final results = snapshot.data;

      if (results == null) {
        return Center(child: Text('Loading...'));
      }

      if (results.isEmpty) {
        return Center(child: Text('No Results'));
      }

      return _buildDrinks(results, context, onPush);
    },
  );
}

Widget _buildDrinks(List<Drink> results, BuildContext context, onPush) {
  return Container(
    color: Colors.black87,
    child: GridView.count(
      crossAxisCount: 2,
      children: List.generate(results.length, (index) {
        Drink drink = results[index];
        return Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  onPush(drink);
                },
                child: Center(
                  child: FadeInImage.assetNetwork(
                      placeholderScale: 5,
                      placeholder: 'images/cocktail_anim.gif',
                      image: drink.strDrinkThumb),
                ),
              ),
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
//              Positioned(
//                top: 0,
//                left: 0,
//                right: 0,
//                child: Container(
//                  alignment: AlignmentDirectional.centerEnd,
//                  color: Color(0x88000000),
//                  child: Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: Icon(Icons.shopping_cart,
//                        color: Color(0xfff56040), size: 28),
//                  ),
//                ),
//              ),
//              Positioned(
//                top: 0,
//                right: 36,
//                child: Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: Icon(Icons.favorite_border,
//                      color: Color(0xfff2003c), size: 28),
//                ),
//              ),
            ]);
      }),
    ),
  );
}
