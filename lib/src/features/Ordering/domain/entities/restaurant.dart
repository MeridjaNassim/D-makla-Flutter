import 'package:equatable/equatable.dart';

import 'menu.dart';

class Restaurant extends Equatable{
  final String id;
  final String designation;
  final Coordinates coordinates;
  final List<OpeningTimePeriod> openingTimes;
  final List<Menu> menus;

  Restaurant(
      {this.id,
      this.designation,
      this.coordinates,
      this.openingTimes,
      this.menus});

  @override
  List<Object> get props {
    return [id,coordinates,designation];
  }
}

class Coordinates extends Equatable {
  final double latitude;
  final double longitude;

  Coordinates({this.latitude, this.longitude});

  @override
  List<Object> get props {
    return [latitude,longitude];
  }
}

class OpeningTimePeriod extends Equatable{
  final String day;
  final String openingHour;
  final String closingHour;

  OpeningTimePeriod({this.day, this.openingHour, this.closingHour});

  @override
  List<Object> get props {
    return [day,openingHour,closingHour];
  }
}