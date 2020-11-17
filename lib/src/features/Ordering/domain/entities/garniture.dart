import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Garniture extends Equatable {
  final String id;
  final String designation;
  final double price;
  final String photoUrl;
  Garniture({@required this.id, @required this.designation, @required this.price,this.photoUrl});

  @override
  List<Object> get props {
    return [id,designation,price];
  }
}