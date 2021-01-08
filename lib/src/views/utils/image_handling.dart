import 'package:flutter/material.dart';
import 'package:dmakla/src/business_logic/models/common/image.dart' as businessImage;
ImageProvider getImageProvider(businessImage.Image image){
  if(image == null) return null;
  if( image is businessImage.NetworkImage) return NetworkImage(image.url);
}
String getImageUrl(businessImage.Image image) {
  print("getting image");
  print(image);
  if( image is businessImage.NetworkImage) return image.url;
  return "";
}