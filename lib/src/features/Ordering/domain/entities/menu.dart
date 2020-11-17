import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_rlutter_ui/src/features/Ordering/domain/entities/volume.dart';

import 'garniture.dart';

class Menu extends Equatable {
  final String id;
  final String designation;
  final List<Volume> volumes;
  final Category category;
  final List<Garniture> garnitures;
  final Map<Volume,double> pricings;
  Menu(
      {@required this.id,
  @required this.designation,
  @required this.volumes,
  @required this.category,
  @required this.garnitures,
  @required this.pricings
      });

  @override
  List<Object> get props {
    return [id,designation];
  }
}
