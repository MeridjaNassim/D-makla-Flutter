import 'package:flutter/material.dart';

class LoadingImage extends StatelessWidget {
  final double size;

  LoadingImage({this.size = 35 });

  @override
  Widget build(BuildContext context) {
    return Center(child: Icon(Icons.image,size: this.size, color: Theme.of(context).accentColor,),);
  }
}


class LoadingIndicator extends StatelessWidget {
  final String loadingText;

  LoadingIndicator({@required this.loadingText});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            this.loadingText,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .merge(TextStyle(color: Theme.of(context).accentColor)),
          ),
        ),
      ],
    );
  }
}