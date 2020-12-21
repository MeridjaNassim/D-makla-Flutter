import 'package:flutter/material.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/common/image.dart' as businessImage;
ImageProvider getImageProvider(businessImage.Image image){
  if(image == null) return null;
  if( image is businessImage.NetworkImage) return NetworkImage(image.url);
}
String getImageUrl(businessImage.Image image) {

  if( image is businessImage.NetworkImage) return image.url;
  return "";
}