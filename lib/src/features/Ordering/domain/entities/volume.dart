import 'package:equatable/equatable.dart';

class Volume extends Equatable{
  final String id;
  final String designation;

  Volume(this.id, this.designation);

  @override
  List<Object> get props {
    return [id,designation];
  }
}