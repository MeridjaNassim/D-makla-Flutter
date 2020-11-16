class Category {
  String id;
  String name;
  String image;

  Category(this.id, this.name, this.image);
}

class CategoriesList {
  List<Category> _categoriesList;

  List<Category> get categoriesList => _categoriesList;

  CategoriesList() {
    this._categoriesList = [
      new Category('cat0', 'Rice dishes', 'img/food0.jpg'),
      new Category('cat1', 'Sandwiches', 'img/food1.jpg'),
      new Category('cat2', 'Sausages', 'img/food2.jpg'),
      new Category('cat3', 'Cheeses', 'img/food3.jpg'),
      new Category('cat4', 'Rice dishes', 'img/food4.jpg'),
      new Category('cat5', 'Sandwiches', 'img/food5.jpg'),
      new Category('cat6', 'Bergenost', 'img/food1.jpg'),
      new Category('cat7', 'Desserts', 'img/food3.jpg'),
      new Category('cat8', 'Cream', 'img/food2.jpg'),
      new Category('cat9', 'Cheeses', 'img/food0.jpg'),
    ];
  }
}
