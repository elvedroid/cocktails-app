class DrinkCategory {
  final String strCategory;

  DrinkCategory({this.strCategory});

  factory DrinkCategory.fromJson(Map<String, dynamic> json) {
    return DrinkCategory(
      strCategory: json['strCategory'],
    );
  }
}
