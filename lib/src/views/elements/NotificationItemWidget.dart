import 'package:flutter/material.dart';
import 'package:restaurant_rlutter_ui/src/models/notification.dart' as model;

class NotificationItemWidget extends StatelessWidget {
  NotificationItemWidget({Key key, this.notification}) : super(key: key);
  model.Notification notification;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 75,
          width: 75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            image: DecorationImage(image: AssetImage(this.notification.image), fit: BoxFit.cover),
          ),
        ),
        SizedBox(width: 15),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                this.notification.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: Theme.of(context).textTheme.body2,
              ),
              Text(
                this.notification.time,
                style: Theme.of(context).textTheme.caption,
              )
            ],
          ),
        )
      ],
    );
  }
}
