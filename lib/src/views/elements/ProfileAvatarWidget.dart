import 'package:dmakla/src/business_logic/blocs/auth/auth.bloc.dart';
import 'package:dmakla/src/business_logic/blocs/auth/auth.state.dart';
import 'package:dmakla/src/views/elements/common/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileAvatarWidget extends StatelessWidget {
  const ProfileAvatarWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      if (state is AuthenticationAuthenticated) {
        return Column(
          children: <Widget>[
            Container(
              height: 160,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // SizedBox(
                  //   width: 50,
                  //   height: 50,
                  //   child: FlatButton(
                  //     padding: EdgeInsets.all(0),
                  //     onPressed: () {},
                  //     child: Icon(Icons.add, color: Theme.of(context).primaryColor),
                  //     color: Theme.of(context).accentColor,
                  //     shape: StadiumBorder(),
                  //   ),
                  // ),
                  SizedBox(
                      width: 135,
                      height: 135,
                      child: CircleAvatar(
                          backgroundImage: AssetImage("img/dmakla-logo.png"))),
                  // SizedBox(
                  //   width: 50,
                  //   height: 50,
                  //   child: FlatButton(
                  //     padding: EdgeInsets.all(0),
                  //     onPressed: () {},
                  //     child: Icon(Icons.chat, color: Theme.of(context).primaryColor),
                  //     color: Theme.of(context).accentColor,
                  //     shape: StadiumBorder(),
                  //   ),
                  // ),
                ],
              ),
            ),
            Text(
              state.user.fullName,
              style: Theme.of(context).textTheme.headline,
            ),
            Text(
              state.user.wilaya.name ?? "wilaya non spécifié",
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        );
      }
      return Container();
    });
  }
}
