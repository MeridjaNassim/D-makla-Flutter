
import 'package:equatable/equatable.dart';

import 'common/image.dart';

class Topping extends Equatable{
  final String id;
  final String name;
  final String description;
  final double price;
  final Image image;
  Topping(
      {this.id,
        this.name,
        this.description,
        this.price,
        this.image
      });

  @override
  List<Object> get props {
    return [id,name];
  }

}

abstract class ToppingList {
  Topping getToppingById(String id);
  Topping getToppingByName(String name);
  Topping getToppingByIndex(int index);
  double getListPrice();
}
class ToppingListImpl extends ToppingList {
  final List<Topping> _items;



  ToppingListImpl(List<Topping> toppings) : this._items = toppings;

  @override
  Topping getToppingById(String id) {
    // TODO: implement getToppingById
    throw UnimplementedError();
  }

  @override
  Topping getToppingByIndex(int index) {
    // TODO: implement getToppingByIndex
    throw UnimplementedError();
  }

  @override
  Topping getToppingByName(String name) {
    // TODO: implement getToppingByName
    throw UnimplementedError();
  }

  @override
  double getListPrice() {
    double price = 0;
    final items = this._items;
    final prices = items.map((e) => e.price).toList();
    price = prices.reduce((value, element) => value + element);
    return price;
  }




}
