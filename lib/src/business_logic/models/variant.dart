import 'package:equatable/equatable.dart';

class Variant extends Equatable{
  final String id;
  final String name;
  final String description;


  Variant(
      {this.id,
        this.name,
        this.description,
      });

  @override
  List<Object> get props {
    return [id,name];
  }

}
abstract class VariantList {
  int size();
  Variant getVariantById(String id);
  Variant getVariantByName(String name);
  Variant getVariantByIndex(int index);
}
class VariantListImpl extends VariantList {
  final List<Variant> _items;


  VariantListImpl(List<Variant> variants) : this._items = variants;

  @override
  Variant getVariantById(String id) {
    // TODO: implement getVariantById
    throw UnimplementedError();
  }

  @override
  Variant getVariantByIndex(int index) {
   if(_items.length > index) return _items[index];
   return null;
  }

  @override
  Variant getVariantByName(String name) {
    // TODO: implement getVariantByName
    throw UnimplementedError();
  }

  @override
  int size() {
    return this._items.length;
  }



}
