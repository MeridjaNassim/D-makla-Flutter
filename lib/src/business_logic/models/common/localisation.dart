import 'package:equatable/equatable.dart';

class Coordinates extends Equatable{
  final double latitude ;
  final double longitude;

  Coordinates({this.latitude, this.longitude});

  @override
  List<Object> get props {
    return [latitude,longitude];
  }
}