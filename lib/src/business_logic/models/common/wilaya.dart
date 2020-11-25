

import 'package:equatable/equatable.dart';

class Wilaya extends Equatable{
  final String code;
  final String name;
  final List<Commune> communes;
  Wilaya({this.code, this.name, this.communes});

  @override
  List<Object> get props {
    return [code,name];
  }
}

class Commune extends Equatable{
  final String id;
  final String name;

  Commune({this.id, this.name});

  @override
  List<Object> get props {
    return [id,name];
  }
}