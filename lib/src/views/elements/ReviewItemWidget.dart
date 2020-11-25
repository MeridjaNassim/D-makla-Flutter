import 'package:flutter/material.dart';
import 'package:restaurant_rlutter_ui/src/models/review.dart';

// ignore: must_be_immutable
class ReviewItemWidget extends StatelessWidget {
  Review review;

  ReviewItemWidget({Key key, this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Wrap(
        direction: Axis.horizontal,
        runSpacing: 10,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  image: DecorationImage(image: AssetImage(this.review.image), fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 15),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            review.name,
                            overflow: TextOverflow.fade,
                            softWrap: false,
                            maxLines: 2,
                            style:
                                Theme.of(context).textTheme.title.merge(TextStyle(color: Theme.of(context).hintColor)),
                          ),
                        ),
                        SizedBox(
                          width: 35,
                          height: 35,
                          child: FlatButton(
                            padding: EdgeInsets.all(0),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(review.rate,
                                    style: Theme.of(context)
                                        .textTheme
                                        .body2
                                        .merge(TextStyle(color: Theme.of(context).primaryColor))),
                                Icon(
                                  Icons.star_border,
                                  color: Theme.of(context).primaryColor,
                                  size: 16,
                                ),
                              ],
                            ),
                            color: Theme.of(context).accentColor.withOpacity(0.9),
                            shape: StadiumBorder(),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${review.reviewsNumber} Reviews, ${review.followersNumber} Followers',
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
              )
            ],
          ),
          Text(
            review.review,
            style: Theme.of(context).textTheme.body1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            maxLines: 3,
          )
        ],
      ),
    );
  }
}
