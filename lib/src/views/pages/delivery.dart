import 'package:flutter/material.dart';

class DeliveryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Delivery',
          style: Theme.of(context)
              .textTheme
              .title
              .merge(TextStyle(letterSpacing: 1.3)),
        ),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.check,
              color: Theme.of(context).accentColor,
              size: 50,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Approved delivery",
              style: Theme.of(context).textTheme.display2,
              textAlign: TextAlign.center,
            )
          ]),
    );
  }
}
