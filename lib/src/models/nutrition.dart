class Nutrition {
  String id;
  String name;
  double quantity;

  Nutrition(this.id, this.name, this.quantity);
}

class NutritionList {
  List<Nutrition> _nutritionList;

  List<Nutrition> get nutritionList => _nutritionList;

  NutritionList() {
    this._nutritionList = [
      new Nutrition('nut0', 'Vitamin', 4566),
      new Nutrition('nut1', 'Calories', 458),
      new Nutrition('nut2', 'Sodium', 788),
      new Nutrition('nut3', 'Fat', 98),
      new Nutrition('nut4', 'Sugar', 958),
      new Nutrition('nut5', 'Protein', 555),
      new Nutrition('nut6', 'Oil', 565),
    ];
  }
}
