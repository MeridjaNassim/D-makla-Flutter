import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/store/order.cubit.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/menu.dart';
import 'package:restaurant_rlutter_ui/src/models/food.dart';
import 'package:restaurant_rlutter_ui/src/models/route_argument.dart';
import 'package:restaurant_rlutter_ui/src/views/utils/image_handling.dart';

class FoodsCarouselItemWidget extends StatelessWidget {
  double marginLeft;
  Food food;
  Menu menu;
  String heroTag;

  FoodsCarouselItemWidget({Key key, this.heroTag, this.marginLeft, this.food,this.menu}) : super(key: key);

  void _setSelectedMenu(BuildContext context) {
    BlocProvider.of<OrderCubit>(context).setCurrentMenu(this.menu);
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      highlightColor: Colors.transparent,
      onTap: () {
        _setSelectedMenu(context);
        Navigator.of(context).pushNamed('/Food', arguments: RouteArgument(id: menu.id, heroTag: heroTag));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Stack(
            alignment: AlignmentDirectional.topEnd,
            children: <Widget>[
              Hero(
                tag: heroTag + menu.id,
                child: Container(
                  margin: EdgeInsets.only(left: this.marginLeft, right: 20),
                  width: 100,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: getImageProvider(menu.image),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 25, top: 5),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)), color: Theme.of(context).accentColor),
                alignment: AlignmentDirectional.topEnd,
                child: Text(
                  menu.pricings.getPriceOfVariant(menu.variants.getVariantByIndex(0)).toString()+ "DA",
                  style: Theme.of(context).textTheme.body2.merge(TextStyle(color: Theme.of(context).primaryColor)),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Container(
              width: 100,
              margin: EdgeInsets.only(left: this.marginLeft, right: 20),
              child: Column(
                children: <Widget>[
                  Text(
                    this.menu.name,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: Theme.of(context).textTheme.body1,
                  ),
                  Text(
                    menu.restaurant_name,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
