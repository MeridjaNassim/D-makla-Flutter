import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' as material;

abstract class Image extends Equatable {
  material.ImageProvider getImageProvider();
}

class NetworkImage extends Image{
  final String url;

  NetworkImage({this.url});

  @override
  // TODO: implement props
  List<Object> get props => [url];

  @override
  material.ImageProvider<Object> getImageProvider() {
    return  material.NetworkImage(this.url);
  }

}