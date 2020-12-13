import 'package:equatable/equatable.dart';
import 'common/image.dart';
import 'topping.dart';

import 'category.dart';
import 'variant.dart';

class Menu extends Equatable {
  final String id;
  final String name;
  final String restaurant_name;
  final String description;
  final VariantList variants;
  final Image image;
  final Category category;
  final ToppingList toppings;
  final PricingsPerVariant pricings;

  Menu(
      {this.id,
      this.name,
      this.restaurant_name,
      this.description,
      this.variants,
      this.image,
      this.category,
      this.pricings,
      this.toppings});

  @override
  List<Object> get props {
    return [id, name,restaurant_name];
  }
  double getBasePrice() {
    final firstVariant = variants.getVariantByIndex(0);
    return pricings.getPriceOfVariant(firstVariant);
  }
}

abstract class MenuList {
  Menu getMenuById(String id);

  Menu getMenuByName(String name);

  Menu getMenuByIndex(int index);
}

class MenuListImpl extends MenuList {
  final List<Menu> _items;

  MenuListImpl(List<Menu> menus) : this._items = menus;

  @override
  Menu getMenuById(String id) {
    // TODO: implement getMenuById
    throw UnimplementedError();
  }

  @override
  Menu getMenuByIndex(int index) {
    // TODO: implement getMenuByIndex
    throw UnimplementedError();
  }

  @override
  Menu getMenuByName(String name) {
    // TODO: implement getMenuByName
    throw UnimplementedError();
  }
}

abstract class PricingsPerVariant {
  void setPriceForVariant(Variant variant, double price);

  double getPriceOfVariant(Variant variant);
}

class PricingsPerVariantImpl extends PricingsPerVariant {
  Map<Variant, double> _princings;

  PricingsPerVariantImpl() : this._princings = Map<Variant, double>();

  PricingsPerVariantImpl.fromMap(Map<Variant, double> pricings) {
    this._princings = pricings;
  }

  @override
  double getPriceOfVariant(Variant variant) {
    if (this._princings == null) throw Exception("pricings are null");
    double price = this._princings[variant];
    if (price == null) return 0;
    return price;
  }

  @override
  void setPriceForVariant(Variant variant, double price) {
    if (this._princings == null) throw Exception("pricings are null");
    this._princings.putIfAbsent(variant, () => price);
  }
}
