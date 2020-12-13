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
                child: CircleAvatar(backgroundImage: NetworkImage("https://scontent-mrs2-1.xx.fbcdn.net/v/t1.0-9/122888655_3372270699531336_6370712605901791845_o.jpg?_nc_cat=103&ccb=2&_nc_sid=09cbfe&_nc_eui2=AeHapRva2R9He4oumoMrJJm9fgocCY-Uglp-ChwJj5SCWg6_mcr6BdS3kFYHsEjoRMcamc4z3Y6DW77xbN5vu6XI&_nc_ohc=8l5LLZzkdJwAX-hka4b&_nc_ht=scontent-mrs2-1.xx&oh=9e42b268ed79aabbcce8cc25f6cf0ffe&oe=5FE6B13E")),
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
          'Meridja Nassim',
          style: Theme.of(context).textTheme.headline,
        ),
        Text(
          'Alger, Algeria',
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}
