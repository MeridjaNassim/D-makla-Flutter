import 'package:equatable/equatable.dart';
import 'package:dmakla/src/business_logic/models/common/wilaya.dart';

class DeliveryLocation extends Equatable {
final Wilaya wilaya;
final DeliveryZone zone;
DeliveryLocation({this.wilaya,this.zone});

@override
  // TODO: implement props
  List<Object> get props => [wilaya,zone];
}

class DeliveryZone extends Equatable{
  final String id;
  final String name;

  DeliveryZone({this.id, this.name});

  @override
  // TODO: implement props
  List<Object> get props => [id,name];
}

class DeliveryTime extends Equatable {
  final DateTime dateTime;

  DeliveryTime(this.dateTime);
  @override
  // TODO: implement props
  List<Object> get props => [dateTime.millisecondsSinceEpoch];

  static DeliveryTime  getNextClosestDeliveryTime() {
    final time = DateTime.now().add(Duration(minutes: 30));
    return DeliveryTime(time);
  }
}
