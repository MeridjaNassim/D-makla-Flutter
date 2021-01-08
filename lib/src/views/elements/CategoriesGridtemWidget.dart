import 'package:flutter/material.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:dmakla/src/business_logic/models/category.dart';
import 'package:dmakla/src/views/elements/common/loading.dart';
import 'package:dmakla/src/views/utils/image_handling.dart';

// ignore: must_be_immutable
class CategoriesGridItemWidget extends StatelessWidget {
  Category category;
  String heroTagPrefix;
  CategoriesGridItemWidget({Key key, this.category}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Hero(
        //   tag: category.id,
        //   // child: Container(
        //   //   width: 100,
        //   //   height: 100,
        //   //   decoration: BoxDecoration(
        //   //     borderRadius: BorderRadius.all(Radius.circular(5)),
        //   //     image: DecorationImage(
        //   //       fit: BoxFit.cover,
        //   //       image: getImageProvider(category.image),
        //   //     ),
        //   //   ),
        //   // ),
        //   child: Container(
        //       width: 100,
        //       height: 100,
        //     child: OptimizedCacheImage(
        //       imageUrl: getImageUrl(category.image),
        //       placeholder: (context, url) => CircularProgressIndicator(),
        //       errorWidget: (context, url, error) => Icon(Icons.error),
        //       imageBuilder: (context,imageProvider) =>Container(
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.all(Radius.circular(5)),
        //             image: DecorationImage(
        //               fit: BoxFit.cover,
        //               image: imageProvider,
        //             ),
        //           ),
        //         ),
        //     ),
        //   ),
        // ),
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Container(
            width: 100,
            height: 100,
            child: OptimizedCacheImage(
              imageUrl: getImageUrl(category.image),
              placeholder: (context, url) => LoadingImage(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              imageBuilder: (context,imageProvider) =>Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: imageProvider,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          child: Text(
            category.name,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.body2,
          ),
        ),
      ],
    );
  }
}
