import 'package:flutter/material.dart';

class ProfileAvatarWidget extends StatelessWidget {
  const ProfileAvatarWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 160,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                width: 50,
                height: 50,
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {},
                  child: Icon(Icons.add, color: Theme.of(context).primaryColor),
                  color: Theme.of(context).accentColor,
                  shape: StadiumBorder(),
                ),
              ),
              SizedBox(
                width: 135,
                height: 135,
                child: CircleAvatar(backgroundImage: AssetImage('img/user1.jpg')),
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {},
                  child: Icon(Icons.chat, color: Theme.of(context).primaryColor),
                  color: Theme.of(context).accentColor,
                  shape: StadiumBorder(),
                ),
              ),
            ],
          ),
        ),
        Text(
          'Bloomberg',
          style: Theme.of(context).textTheme.headline,
        ),
        Text(
          'Berlin, Germany',
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}
