import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void showConnectivityWidget(BuildContext context, Function onRetry) {
  var theme = Theme.of(context)
      .textTheme
      .display1
      .copyWith(color: Theme.of(context).accentColor);
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Pas de connexion"),
      content: Text("Vous avez besoin d'internet pour utiliser D-makla"),
      actions: <Widget>[
        FlatButton(
            child: Text(
              "Quitter",
              style: theme,
            ),
            onPressed: () {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            }),
        FlatButton(
            child: Text(
              "Réessayer",
              style: theme,
            ),
            onPressed: onRetry)
      ],
    ),
  );
}
