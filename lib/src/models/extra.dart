class Extra {
  String id;
  String name;
  String description;
  double price;
  String image;

  Extra(this.id, this.name, this.description, this.price, this.image);

  String getPrice() {
    return '\$${this.price}';
  }
}

class ExtrasList {
  List<Extra> _extrasList;

  List<Extra> get extrasList => _extrasList;

  ExtrasList() {
    this._extrasList = [
      new Extra('extra0', 'Rice dishes', 'Add some tuna', 4.32, 'img/food0.jpg'),
      new Extra('extra1', 'Sandwiches', 'Add some tuna', 6.23, 'img/food1.jpg'),
      new Extra('extra3', 'Cheeses', 'Add some tuna', 3.89, 'img/food3.jpg'),
      new Extra('extra4', 'Bergenost', 'Add some tuna', 2.68, 'img/food4.jpg'),
    ];
  }
}
