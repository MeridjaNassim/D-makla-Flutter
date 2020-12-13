import 'package:equatable/equatable.dart';


abstract class Image extends Equatable {

}

class NetworkImage extends Image{
  final String url;

  NetworkImage({this.url});

  @override
  // TODO: implement props
  List<Object> get props => [url];

}