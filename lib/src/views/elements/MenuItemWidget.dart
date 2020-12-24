
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/store/order.cubit.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/menu.dart';
import 'package:restaurant_rlutter_ui/src/models/route_argument.dart';
import 'package:restaurant_rlutter_ui/src/views/utils/image_handling.dart';

import 'package:octo_image/octo_image.dart';

import 'common/loading.dart';
class MenuItemWidget extends StatelessWidget {
  final String heroTag;
  final Menu menu;

  const MenuItemWidget({Key key, this.menu, this.heroTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).accentColor,
      focusColor: Theme.of(context).accentColor,
      highlightColor: Theme.of(context).primaryColor,
      onTap: () {
        //Navigator.of(context).pushNamed('/Tracking');
        BlocProvider.of<OrderCubit>(context).setCurrentMenu(menu);
        Navigator.of(context).pushNamed('/Food', arguments: RouteArgument(id: menu.id, heroTag: heroTag));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.9),
          boxShadow: [
            BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 5, offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: heroTag + menu.id,
              child: Container(
                height: 60,
                width: 60,
                child: OctoImage(
                  placeholderBuilder: (context)=> LoadingImage(),
                  errorBuilder: (context,obj,trace)=> Image(image: NetworkImage("https://scontent-mrs2-2.xx.fbcdn.net/v/t1.0-9/122494003_105148951389175_3661855520522376578_n.jpg?_nc_cat=102&ccb=2&_nc_sid=09cbfe&_nc_eui2=AeFxcuRlac4GH3vpvnSMNWlJTwaMXICKbSVPBoxcgIptJfrGHjEXcfBlob9Lk5qIFCD9_84FZKPBIPxDzuh8-L_Z&_nc_ohc=GnQTehWWkuUAX9YpUPA&_nc_ht=scontent-mrs2-2.xx&oh=5b069011fd606cd7b3182cd228beb4f1&oe=600723C1"),
                  ),
                  fit: BoxFit.cover,
                  image: getImageProvider(menu.image),
                ),
              ),
              // child: Container(
              //   height: 60,
              //   width: 60,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.all(Radius.circular(5)),
              //     image: DecorationImage(image: getImageProvider(menu.image), fit: BoxFit.cover),
              //   ),
              // ),
              // child: SizedBox(
              //   height: 60,
              //   width: 60,
              //   child: OptimizedCacheImage(
              //     imageUrl: getImageUrl(menu.image),
              //     placeholder: (context, url) => CircularProgressIndicator(),
              //     errorWidget: (context,url,error)=> Image(image: NetworkImage("https://scontent-mrs2-2.xx.fbcdn.net/v/t1.0-9/122494003_105148951389175_3661855520522376578_n.jpg?_nc_cat=102&ccb=2&_nc_sid=09cbfe&_nc_eui2=AeFxcuRlac4GH3vpvnSMNWlJTwaMXICKbSVPBoxcgIptJfrGHjEXcfBlob9Lk5qIFCD9_84FZKPBIPxDzuh8-L_Z&_nc_ohc=GnQTehWWkuUAX9YpUPA&_nc_ht=scontent-mrs2-2.xx&oh=5b069011fd606cd7b3182cd228beb4f1&oe=600723C1"),
              //         ),
              //     // errorWidget: (context, url, error) => Container(
              //     //     child: Icon(Icons.image, color: Theme.of(context).accentColor,)),
              //     imageBuilder: (context,imageProvider) =>Container(
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.all(Radius.circular(5)),
              //         image: DecorationImage(
              //           fit: BoxFit.cover,
              //           image: imageProvider,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ),
            SizedBox(width: 15),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          menu.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.subhead,
                        ),
                        Text(
                          menu.restaurant_name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(menu.getBasePrice().toString()+"DA", style: Theme.of(context).textTheme.display1),

                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
