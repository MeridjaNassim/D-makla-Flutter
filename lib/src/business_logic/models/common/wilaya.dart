

import 'package:equatable/equatable.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/delivery.dart';

class Wilaya extends Equatable{
  final String code;
  final String name;
  final List<Commune> communes;
  Wilaya({this.code, this.name, this.communes});

  @override
  List<Object> get props {
    return [code];
  }
}

class Commune extends Equatable{
  final String id;
  final String name;
  final List<DeliveryZone> zones;
  Commune({this.id, this.name,this.zones});

  @override
  List<Object> get props {
    return [id,name];
  }
}