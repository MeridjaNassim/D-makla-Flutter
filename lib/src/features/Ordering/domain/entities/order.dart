import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_rlutter_ui/src/features/Ordering/domain/entities/client.dart';
import 'package:restaurant_rlutter_ui/src/features/Ordering/domain/entities/garniture.dart';
import 'package:restaurant_rlutter_ui/src/features/Ordering/domain/entities/restaurant.dart';
import 'package:restaurant_rlutter_ui/src/features/Ordering/domain/entities/volume.dart';

import 'menu.dart';

class Order extends Equatable{
  final Client client;
  final Restaurant restaurant;
  final Menu menu;
  final Volume volume;
  final List<Garniture> garnitures;

  Order(
      {@required this.client,
      @required this.restaurant,
      @required this.menu,
      @required this.volume,
      @required this.garnitures});

  @override
  List<Object> get props {
    return [client,restaurant,menu,volume,garnitures];
  }
}
