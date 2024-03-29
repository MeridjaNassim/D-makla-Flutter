
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

abstract class ToppingList  extends Equatable{
  List<Topping> getItemsList();
  void toggle(Topping topping);
  bool contains(Topping topping);
  int size();
  void addTopping(Topping topping);
  void removeTopping(Topping topping);
  Topping getToppingById(String id);
  Topping getToppingByName(String name);
  Topping getToppingByIndex(int index);
  double getListPrice();
  List<dynamic> toJson();
}
class ToppingListImpl extends ToppingList {
  final List<Topping> _items;



  ToppingListImpl(List<Topping> toppings) : this._items = toppings;

  @override
  // TODO: implement props
  List<Object> get props => _items;
  @override
  Topping getToppingById(String id) {
    // TODO: implement getToppingById
    throw UnimplementedError();
  }

  @override
  Topping getToppingByIndex(int index) {
   if(this._items != null &&  this._items.length > index) return this._items[index];
   return null;
  }

  @override
  Topping getToppingByName(String name) {
    // TODO: implement getToppingByName
    throw UnimplementedError();
  }

  @override
  double getListPrice() {

    final items = this._items;
    final prices = items.map((e) => e.price).toList();
    if(prices.isEmpty) return 0;
    double price = prices.reduce((value, element) => value + element);
    return price;
  }

  @override
  int size() {
    return this._items.length;
  }

  @override
  bool contains(Topping topping) {
    return this._items.contains(topping);
  }

  @override
  void toggle(Topping topping) {
    if(this._items.isEmpty){
      this._items.add(topping);
      return;
    }
    final toppings = this._items;
    final _topping = toppings.firstWhere((element) => element ==topping,orElse: ()=>null);
    if(_topping != null) {
      this._items.remove(_topping);
      return;
    }
    this._items.add(topping);
  }

  @override
  List<Topping> getItemsList() {
  return this._items;
  }

  @override
  void addTopping(Topping topping) {
    this._items.add(topping);
  }

  @override
  void removeTopping(Topping topping) {
    this._items.remove(topping);
  }

  @override
  List<dynamic> toJson() {
    return this._items.map((e) => {
      "id" : e.id,
      "name" : e.name
    }).toList();
  }




}
