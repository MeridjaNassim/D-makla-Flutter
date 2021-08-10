

import 'package:equatable/equatable.dart';
import 'package:dmakla/src/business_logic/models/delivery.dart';
import 'package:dmakla/src/business_logic/utils/constants/wilaya.dart';
class Wilaya extends Equatable{
  final String code;
  final String name;
  final List<Commune> communes;
  Wilaya({this.code, this.name, this.communes});
  factory Wilaya.fromName(String wilayaName) {
    String code;
    WILAYA_MAP.forEach((key, value) {
      if(value == wilayaName)
        code = key;
    });
    return Wilaya(code: code,name: wilayaName);
  }
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