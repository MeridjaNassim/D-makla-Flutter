import 'package:equatable/equatable.dart';
import 'file:///D:/Projects/flutter/d_makla2/d_makla/lib/src/business_logic/models/common/wilaya.dart';
import 'common/localisation.dart';
import 'common/image.dart';
import 'menu.dart';
class Restaurant extends Equatable {
  final String id;
  final String name;
  final Image image;
  final MenuList menus;
  final Wilaya wilaya;
  final Commune commune;
  final Coordinates coordinates;
  final OpeningTimePeriod openingTimePeriod;
  final Rating rating;

  Restaurant(
      {this.id,
      this.name,
      this.image,
      this.menus,
      this.wilaya,
      this.commune,
      this.coordinates,
      this.openingTimePeriod,
      this.rating});

  @override
  List<Object> get props {
    return [id,name,wilaya,commune];
  }
}


class OpeningTimePeriod extends Equatable {
  final String day;
  final String openingHour;
  final String closingHour;

  OpeningTimePeriod({this.day, this.openingHour, this.closingHour});

  @override
  List<Object> get props {
    return [day, openingHour, closingHour];
  }
}

class Rating {
  final double score;

  Rating({this.score});
}
