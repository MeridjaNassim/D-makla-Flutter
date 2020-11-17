import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Client extends Equatable{
  final String id;

  Client({@required this.id});

  @override
  List<Object> get props {
    return [id];
  }
}