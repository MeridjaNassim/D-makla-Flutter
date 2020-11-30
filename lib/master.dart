import 'package:equatable/equatable.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/topping.dart';

Future<void> main() async {
  EquatableConfig.stringify = true;
  ToppingList toppingList1 = ToppingListImpl([
    Topping(id: "1",name: "topping1",price: 10),
    Topping(id: "2",name: "topping2",price: 12),
  ]);
  ToppingList toppingList2 = ToppingListImpl([
    Topping(id: "1",name: "topping1",price: 10),
    Topping(id: "2",name: "topping2",price: 13),
  ]);

  print("list 1: " + toppingList1.toString());
  print("list 2 : " + toppingList2.toString());
  print("==: "+ (toppingList1 == toppingList2).toString());
}


