
import 'package:equatable/equatable.dart';

import 'common/image.dart';

class Category extends Equatable{
  final String id;
  final String name;
  final String description;
  final Image image;

  Category(
      {this.id,
        this.name,
        this.description,
        this.image
      });

  @override
  List<Object> get props {
    return [id,name];
  }

}