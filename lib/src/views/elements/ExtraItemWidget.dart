import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dmakla/src/business_logic/blocs/store/order.cubit.dart';
import 'package:dmakla/src/business_logic/models/topping.dart';
import 'package:dmakla/src/views/utils/image_handling.dart';

class ExtraItemWidget extends StatefulWidget {
  Topping topping;
  bool isSelected;
  ExtraItemWidget({
    Key key,
    this.isSelected = false,
    this.topping,
  }) : super(key: key);

  @override
  _ExtraItemWidgetState createState() => _ExtraItemWidgetState();
}

class _ExtraItemWidgetState extends State<ExtraItemWidget>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;
  Animation<double> sizeCheckAnimation;
  Animation<double> rotateCheckAnimation;
  Animation<double> opacityAnimation;
  Animation opacityCheckAnimation;
  bool checked;

  @override
  void initState() {
    //print("hello init state");
    super.initState();
    checked = widget.isSelected;
    animationController =
        AnimationController(duration: Duration(milliseconds: 350), vsync: this);
    CurvedAnimation curve =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);
    animation = Tween(begin: 0.0, end: 60.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });
    opacityAnimation = Tween(begin: 0.0, end: 0.5).animate(curve)
      ..addListener(() {
        setState(() {});
      });
    opacityCheckAnimation = Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });
    rotateCheckAnimation = Tween(begin: 2.0, end: 0.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });
    sizeCheckAnimation = Tween<double>(begin: 0, end: 36).animate(curve)
      ..addListener(() {
        setState(() {});
      });
    if (checked) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //print('Extra added: ' + widget.topping.toString());
        BlocProvider.of<OrderCubit>(context).toggleTopping(widget.topping);
        if (checked) {
          animationController.reverse();
        } else {
          animationController.forward();
        }
        checked = !checked;
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(60)),
                  image: DecorationImage(
                      image: getImageProvider(widget.topping.image),
                      fit: BoxFit.cover),
                ),
              ),
              Container(
                height: animation.value,
                width: animation.value,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(60)),
                  color: Theme.of(context)
                      .accentColor
                      .withOpacity(opacityAnimation.value),
                ),
                child: Transform.rotate(
                  angle: rotateCheckAnimation.value,
                  child: Icon(
                    Icons.check,
                    size: sizeCheckAnimation.value,
                    color: Theme.of(context)
                        .primaryColor
                        .withOpacity(opacityCheckAnimation.value),
                  ),
                ),
              ),
            ],
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
                        widget.topping.name ?? "name",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.subhead,
                      ),
                      Text(
                        widget.topping.description ?? "clicker pour ajouter",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                Text(widget.topping.price.toInt().toString() + "DA",
                    style: Theme.of(context).textTheme.display1),
              ],
            ),
          )
        ],
      ),
    );
  }
}
