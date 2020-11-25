import 'package:restaurant_rlutter_ui/src/business_logic/models/common/localisation.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/common/wilaya.dart';

class DeliveryLocation {
final Wilaya wilaya;
final Commune commune;
final Coordinates coordinates;

DeliveryLocation({this.wilaya, this.commune,this.coordinates});
}

class DeliveryTime {
  final DateTime dateTime;

  DeliveryTime(this.dateTime);
}
