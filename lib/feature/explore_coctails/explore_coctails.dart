import 'package:cocktail_app/bloc/bloc_provider.dart';
import 'package:cocktail_app/bloc/drink_categories_bloc.dart';
import 'package:cocktail_app/feature/drinks_by_category/drinks_by_category.dart';
import 'package:cocktail_app/model/drink_category.dart';
import 'package:flutter/material.dart';

class ExploreCocktails extends StatefulWidget {
  const ExploreCocktails({Key key}) : super(key: key);

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
      child: _buildResults(drinkCategoriesBloc),
    );
  }
}

Widget _buildResults(DrinkCategoriesBloc bloc) {
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

      return _buildCategories(results);
    },
  );
}

Widget _buildCategories(List<DrinkCategory> results) {
  return CustomScrollView(slivers: <Widget>[
    SliverToBoxAdapter(
      child: SizedBox(
        height: 50,
        child: Center(
          child: Text(
            'Categories',
            style: TextStyle(fontSize: 20),
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
          childAspectRatio: 2.0
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final category = results[index];
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => DrinksByCategory(category)));
              },
              child: Container(
                alignment: Alignment.center,
                color: Colors.red[(100 * (index % 9)) + 100],
                child: Text(category.strCategory),

              ),
            );
          },
          childCount: results.length,
        ),
      ),
    ),
  ]);
}
