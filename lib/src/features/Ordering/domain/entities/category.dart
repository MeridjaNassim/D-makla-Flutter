import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Category extends Equatable{
  final String id;
  final String designation;
  final String photoUrl;
  Category({@required this.id, @required this.designation,this.photoUrl});

  @override
  List<Object> get props {
    return [id,designation];
  }
}