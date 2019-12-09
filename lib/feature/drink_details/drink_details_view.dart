import 'package:cocktail_app/bloc/bloc_provider.dart';
import 'package:cocktail_app/bloc/drink_details_block.dart';
import 'package:cocktail_app/model/drink.dart';
import 'package:flutter/material.dart';

class DrinkDetails extends StatefulWidget {
  final Drink drink;

  const DrinkDetails(this.drink, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DrinkDetailsState();
}

class DrinkDetailsState extends State<DrinkDetails> {
  final drinkDetailsBloc = DrinkDetailsBloc();

  @override
  void initState() {
    super.initState();
    drinkDetailsBloc.getDrinkDetails(widget.drink);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DrinkDetailsBloc>(
      bloc: drinkDetailsBloc,
      child: _buildResults(drinkDetailsBloc),
    );
  }
}

Widget _buildResults(DrinkDetailsBloc bloc) {
  return StreamBuilder<List<Drink>>(
    stream: bloc.drinkDetailsStream,
    builder: (context, snapshot) {
      final results = snapshot.data;

      if (results == null) {
        return Center(child: Text(''));
      }

      if (results.isEmpty) {
        return Center(child: Text('No Results'));
      }

      return _buildDrinkDetails(results);
    },
  );
}

Widget _buildDrinkDetails(List<Drink> results) {
  return Container(
    color: Color(0xffF5F2E8),
    child: ListView(children: <Widget>[
      Container(
        color: Color(0xffF5F2E8),
        child: FadeInImage.assetNetwork(
            height: 250,
            placeholderScale: 5,
            fit: BoxFit.cover,
            placeholder: 'images/cocktail_anim.gif',
            image: results[0].strDrinkThumb),
      ),
      Container(
        color: Color(0x88000000),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(results[0].strDrink,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontSize: 28,
                )),
          ),
        ),
      ),
      Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 36, 8.0, 0),
          child: Text('Category: ' + results[0].strCategory,
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.black,
                fontSize: 18,
              )),
        ),
      ),
      Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
          child: Text('Glass: ' + results[0].strGlass,
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.black,
                fontSize: 18,
              )),
        ),
      ),
      Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
          child: Text(
              'Alcoholic: ' +
                  (results[0].strAlcoholic == 'Alcoholic' ? 'yes' : 'no'),
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.black,
                fontSize: 18,
              )),
        ),
      )
    ]),
  );
}
