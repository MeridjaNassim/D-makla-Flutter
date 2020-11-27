import 'package:flutter/material.dart';

import 'package:restaurant_rlutter_ui/src/models/user.dart';
import 'package:restaurant_rlutter_ui/src/views/elements/ProfileSettingsDialog.dart';
import 'package:restaurant_rlutter_ui/src/views/elements/SearchBarWidget.dart';
import 'package:restaurant_rlutter_ui/src/views/elements/ShoppingCartButtonWidget.dart';

class AccountWidget extends StatefulWidget {
  @override
  _AccountWidgetState createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  User _user = new User.init().getCurrentUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Settings',
            style: Theme.of(context).textTheme.title.merge(TextStyle(letterSpacing: 1.3)),
          ),
          actions: <Widget>[
            new ShoppingCartButtonWidget(
                iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 7),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SearchBarWidget(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            _user.name,
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.display2,
                          ),
                          Text(
                            _user.email,
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                    SizedBox(
                        width: 55,
                        height: 55,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(300),
                          onTap: () {
                            Navigator.of(context).pushNamed('/Tabs', arguments: 1);
                          },
                          child: CircleAvatar(
                            backgroundImage: NetworkImage("https://scontent-mrs2-1.xx.fbcdn.net/v/t1.0-9/122888655_3372270699531336_6370712605901791845_o.jpg?_nc_cat=103&ccb=2&_nc_sid=09cbfe&_nc_eui2=AeHapRva2R9He4oumoMrJJm9fgocCY-Uglp-ChwJj5SCWg6_mcr6BdS3kFYHsEjoRMcamc4z3Y6DW77xbN5vu6XI&_nc_ohc=8l5LLZzkdJwAX-hka4b&_nc_ht=scontent-mrs2-1.xx&oh=9e42b268ed79aabbcce8cc25f6cf0ffe&oe=5FE6B13E"),
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).hintColor.withOpacity(0.15), offset: Offset(0, 3), blurRadius: 10)
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/Tabs', arguments: 4);
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.favorite,
                              color: Theme.of(context).hintColor,
                            ),
                            Text(
                              'Wish List',
                              style: Theme.of(context).textTheme.body1,
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: FlatButton(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/Tabs', arguments: 0);
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: Theme.of(context).hintColor,
                            ),
                            Text(
                              'Following',
                              style: Theme.of(context).textTheme.body1,
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: FlatButton(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/Messages');
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.chat,
                              color: Theme.of(context).hintColor,
                            ),
                            Text(
                              'Messages',
                              style: Theme.of(context).textTheme.body1,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).hintColor.withOpacity(0.15), offset: Offset(0, 3), blurRadius: 10)
                  ],
                ),
                child: ListView(
                  shrinkWrap: true,
                  primary: false,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.fastfood),
                      title: Text(
                        'My Orders',
                        style: Theme.of(context).textTheme.body2,
                      ),
                      trailing: ButtonTheme(
                        padding: EdgeInsets.all(0),
                        minWidth: 50.0,
                        height: 25.0,
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/Orders');
                          },
                          child: Text(
                            "View all",
                            style: Theme.of(context).textTheme.body1,
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed('/Orders');
                      },
                      dense: true,
                      title: Text(
                        'Unpaid',
                        style: Theme.of(context).textTheme.body1,
                      ),
                      trailing: Chip(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        backgroundColor: Colors.transparent,
                        shape: StadiumBorder(side: BorderSide(color: Theme.of(context).focusColor)),
                        label: Text(
                          '1',
                          style: TextStyle(color: Theme.of(context).focusColor),
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed('/Orders');
                      },
                      dense: true,
                      title: Text(
                        'To be shipped',
                        style: Theme.of(context).textTheme.body1,
                      ),
                      trailing: Chip(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        backgroundColor: Colors.transparent,
                        shape: StadiumBorder(side: BorderSide(color: Theme.of(context).focusColor)),
                        label: Text(
                          '5',
                          style: TextStyle(color: Theme.of(context).focusColor),
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed('/Orders');
                      },
                      dense: true,
                      title: Text(
                        'Shipped',
                        style: Theme.of(context).textTheme.body1,
                      ),
                      trailing: Chip(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        backgroundColor: Colors.transparent,
                        shape: StadiumBorder(side: BorderSide(color: Theme.of(context).focusColor)),
                        label: Text(
                          '3',
                          style: TextStyle(color: Theme.of(context).focusColor),
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed('/Orders');
                      },
                      dense: true,
                      title: Text(
                        'In dispute',
                        style: Theme.of(context).textTheme.body1,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).hintColor.withOpacity(0.15), offset: Offset(0, 3), blurRadius: 10)
                  ],
                ),
                child: ListView(
                  shrinkWrap: true,
                  primary: false,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text(
                        'Profile Settings',
                        style: Theme.of(context).textTheme.body2,
                      ),
                      trailing: ButtonTheme(
                        padding: EdgeInsets.all(0),
                        minWidth: 50.0,
                        height: 25.0,
                        child: ProfileSettingsDialog(
                          user: this._user,
                          onChanged: () {
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      dense: true,
                      title: Text(
                        'Full name',
                        style: Theme.of(context).textTheme.body1,
                      ),
                      trailing: Text(
                        _user.name,
                        style: TextStyle(color: Theme.of(context).focusColor),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      dense: true,
                      title: Text(
                        'Email',
                        style: Theme.of(context).textTheme.body1,
                      ),
                      trailing: Text(
                        _user.email,
                        style: TextStyle(color: Theme.of(context).focusColor),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      dense: true,
                      title: Text(
                        'Gender',
                        style: Theme.of(context).textTheme.body1,
                      ),
                      trailing: Text(
                        _user.gender,
                        style: TextStyle(color: Theme.of(context).focusColor),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      dense: true,
                      title: Text(
                        'Birth Date',
                        style: Theme.of(context).textTheme.body1,
                      ),
                      trailing: Text(
                        _user.getDateOfBirth(),
                        style: TextStyle(color: Theme.of(context).focusColor),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).hintColor.withOpacity(0.15), offset: Offset(0, 3), blurRadius: 10)
                  ],
                ),
                child: ListView(
                  shrinkWrap: true,
                  primary: false,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text(
                        'Account Settings',
                        style: Theme.of(context).textTheme.body2,
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      dense: true,
                      title: Row(
                        children: <Widget>[
                          Icon(
                            Icons.place,
                            size: 22,
                            color: Theme.of(context).focusColor,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Shipping Adresses',
                            style: Theme.of(context).textTheme.body1,
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed('/Languages');
                      },
                      dense: true,
                      title: Row(
                        children: <Widget>[
                          Icon(
                            Icons.translate,
                            size: 22,
                            color: Theme.of(context).focusColor,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Languages',
                            style: Theme.of(context).textTheme.body1,
                          ),
                        ],
                      ),
                      trailing: Text(
                        'English',
                        style: TextStyle(color: Theme.of(context).focusColor),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed('/Help');
                      },
                      dense: true,
                      title: Row(
                        children: <Widget>[
                          Icon(
                            Icons.info,
                            size: 22,
                            color: Theme.of(context).focusColor,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Help & Support',
                            style: Theme.of(context).textTheme.body1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
