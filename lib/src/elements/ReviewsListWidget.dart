import 'package:flutter/material.dart';
import 'package:restaurant_rlutter_ui/src/elements/ReviewItemWidget.dart';
import 'package:restaurant_rlutter_ui/src/models/review.dart';

// ignore: must_be_immutable
class ReviewsListWidget extends StatelessWidget {
  ReviewsList _reviewsList = new ReviewsList();

  ReviewsListWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return ReviewItemWidget(review: _reviewsList.reviewsList.elementAt(index));
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 20);
      },
      itemCount: 3,
      primary: false,
      shrinkWrap: true,
    );
  }
}
