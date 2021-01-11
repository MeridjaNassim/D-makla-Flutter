import 'package:dmakla/src/views/blocs/tabNavigation.cubit.dart';
import 'package:dmakla/src/views/constants/navigation.dart';
import 'package:dmakla/src/views/elements/common/loading.dart';
import 'package:dmakla/src/views/pages/privacy.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dmakla/src/business_logic/blocs/auth/auth.bloc.dart';
import 'package:dmakla/src/business_logic/blocs/auth/auth.event.dart';
import 'package:dmakla/src/business_logic/blocs/auth/auth.state.dart';
import 'package:dmakla/src/business_logic/models/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
                backgroundImage: AssetImage("img/dmakla-logo.png")),
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
              "Accueil",
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
              "Mes commandes",
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
              "Profil",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            dense: true,
            title: Text(
              "Options",
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
              final privacyUrl = DotEnv().env["PRIVACY_URL"];
              Navigator.of(context).pushNamed("/Privacy",
                  arguments: ConfidentialityArguments(privacyUrl));
            },
            leading: Icon(
              Icons.privacy_tip,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Confidentialité",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            onTap: () {
              showAboutDialog(
                  context: context,
                  applicationVersion: "0.9.0 - beta",
                  applicationName: "D-makla",
                  applicationLegalese:
                      "Service de livraison de nourritures par Sirius Net, contactez le développeur a : ha_meridja@esi.dz",
                  applicationIcon: Container(
                    height: 100,
                    width: 100,
                    child: OctoImage(
                      progressIndicatorBuilder: (context, event) =>
                          LoadingImage(),
                      image: AssetImage("img/dmakla-logo.png"),
                    ),
                  ));
            },
            leading: Icon(
              Icons.help,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "A propos",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            onTap: () async {
              await _onLogOut();
              Navigator.of(context).pushReplacementNamed('/Login');
            },
            leading: Icon(
              Icons.logout,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Déconnecter",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            onTap: () async {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
            leading: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Quitter",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            dense: true,
            title: Text(
              "Version 0.9.0 - beta",
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
