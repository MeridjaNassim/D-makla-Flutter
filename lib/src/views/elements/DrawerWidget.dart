import 'package:dmakla_flutter/src/views/blocs/tabNavigation.cubit.dart';
import 'package:dmakla_flutter/src/views/constants/navigation.dart';
import 'package:dmakla_flutter/src/views/elements/common/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dmakla_flutter/src/business_logic/blocs/auth/auth.bloc.dart';
import 'package:dmakla_flutter/src/business_logic/blocs/auth/auth.event.dart';
import 'package:dmakla_flutter/src/business_logic/blocs/auth/auth.state.dart';
import 'package:dmakla_flutter/src/business_logic/models/user.dart';
import 'package:octo_image/octo_image.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  User user;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    final authState = BlocProvider.of<AuthenticationBloc>(context).state;
    if (authState is AuthenticationAuthenticated) user = authState.user;
  }

  Future<void> _onLogOut() async {
    BlocProvider.of<AuthenticationBloc>(context).add(UserLoggedOut());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage("img/food5.jpg"))
//              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35)),
                ),
            currentAccountPicture: CircleAvatar(
                backgroundColor: Theme.of(context).accentColor,
                backgroundImage: NetworkImage(
                    "https://scontent-mrs2-2.xx.fbcdn.net/v/t1.0-9/122494003_105148951389175_3661855520522376578_n.jpg?_nc_cat=102&ccb=2&_nc_sid=09cbfe&_nc_eui2=AeFxcuRlac4GH3vpvnSMNWlJTwaMXICKbSVPBoxcgIptJfrGHjEXcfBlob9Lk5qIFCD9_84FZKPBIPxDzuh8-L_Z&_nc_ohc=UxyCB4YJtzkAX9vPEzU&_nc_ht=scontent-mrs2-2.xx&oh=2b84f309b844e2c823fb231fbbda8b47&oe=6016F5C1")),
          ),
          ListTile(
            onTap: () {
              _setTab(HOME_TAB_INDEX);
              final navigator = Navigator.of(context);
              navigator.pop();
              if (navigator.canPop()) navigator.pop();
            },
            leading: Icon(
              Icons.home,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Home",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          // ListTile(
          //   onTap: () {
          //     Navigator.of(context).pushNamed('/Pages', arguments: 0);
          //   },
          //   leading: Icon(
          //     Icons.notifications,
          //     color: Theme.of(context).focusColor.withOpacity(1),
          //   ),
          //   title: Text(
          //     "Notifications",
          //     style: Theme.of(context).textTheme.subhead,
          //   ),
          // ),
          ListTile(
            onTap: () {
              _setTab(ORDERS_TAB_INDEX);
              final navigator = Navigator.of(context);
              navigator.pop();
              if (navigator.canPop()) navigator.pop();
            },
            leading: Icon(
              Icons.fastfood,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "My Orders",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            onTap: () {
              _setTab(PROFILE_TAB_INDEX);
              final navigator = Navigator.of(context);
              navigator.pop();
              if (navigator.canPop()) navigator.pop();
            },
            leading: Icon(
              Icons.person,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Profile",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            dense: true,
            title: Text(
              "Application Preferences",
              style: Theme.of(context).textTheme.body1,
            ),
            trailing: Icon(
              Icons.remove,
              color: Theme.of(context).focusColor.withOpacity(0.3),
            ),
          ),
          // ListTile(
          //   onTap: () {
          //     Navigator.of(context).pushNamed('/Settings');
          //   },
          //   leading: Icon(
          //     Icons.settings,
          //     color: Theme.of(context).focusColor.withOpacity(1),
          //   ),
          //   title: Text(
          //     "Settings",
          //     style: Theme.of(context).textTheme.subhead,
          //   ),
          // ),
          ListTile(
            onTap: () {
              showAboutDialog(
                  context: context,
                  applicationVersion: "0.1.0",
                  applicationName: "D-makla",
                  applicationLegalese: "Food Delivery service by Sirius Net",
                  applicationIcon: Container(
                    height: 100,
                    width: 100,
                    child: OctoImage(
                      progressIndicatorBuilder: (context, event) =>
                          LoadingImage(),
                      image: NetworkImage(
                          "https://img.apksum.com/3f/se.onlinepizza/5.19.1/icon.png"),
                    ),
                  ));
            },
            leading: Icon(
              Icons.help,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "About Dmakla",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            onTap: () async {
              await _onLogOut();
              Navigator.of(context).pushReplacementNamed('/Login');
            },
            leading: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Log out",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            dense: true,
            title: Text(
              "Version 0.0.1",
              style: Theme.of(context).textTheme.body1,
            ),
            trailing: Icon(
              Icons.remove,
              color: Theme.of(context).focusColor.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }

  void _setTab(int index) {
    BlocProvider.of<TabNavigationCubit>(context).setTabIndex(index);
  }
}
