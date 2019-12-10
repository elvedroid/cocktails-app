import 'package:cocktail_app/bloc/bloc_provider.dart';
import 'package:cocktail_app/bloc/drink_categories_bloc.dart';
import 'package:cocktail_app/model/drink_category.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ExploreCocktails extends StatefulWidget {
  final ValueChanged<DrinkCategory> onPush;

  const ExploreCocktails({Key key, this.onPush}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ExploreCocktailsState();
}

class ExploreCocktailsState extends State<ExploreCocktails> {
  final drinkCategoriesBloc = DrinkCategoriesBloc();

  @override
  void initState() {
    super.initState();
    drinkCategoriesBloc.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider<DrinkCategoriesBloc>(
      bloc: drinkCategoriesBloc,
      child: _buildResults(drinkCategoriesBloc, widget.onPush),
    );
  }
}

Widget _buildResults(DrinkCategoriesBloc bloc, onPush) {
  return StreamBuilder<List<DrinkCategory>>(
    stream: bloc.drinkCategoriesStream,
    builder: (context, snapshot) {
      final results = snapshot.data;

      if (results == null) {
        return Center(child: Text('Loading...'));
      }

      if (results.isEmpty) {
        return Center(child: Text('No Results'));
      }

      return _buildCategories(results, onPush);
    },
  );
}

Widget _buildCategories(List<DrinkCategory> results, onPush) {
  return Container(
    color: Color(0xffF5F2E8),
    child: CustomScrollView(slivers: <Widget>[
      SliverToBoxAdapter(
        child: SizedBox(
          height: 50,
          child: Center(
            child: Text(
              'Categories',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.all(8.0),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150.0,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 2.0),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              final category = results[index];
              return InkWell(
                onTap: () {
                  onPush(category);
                },
                child: Container(
                    alignment: Alignment.center,
                    color: ((index / 3).floor()) % 2 == 1
                        ? Color(0xfff56040)
                        : Color(0xfff2003c),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(category.strCategory,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    )),
              );
            },
            childCount: results.length,
          ),
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.all(8.0),
        sliver: SliverFillRemaining(
          child: Image.asset('images/cocktail_background.png'),
        ),
      )
    ]),
  );
}
