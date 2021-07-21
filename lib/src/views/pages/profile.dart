import 'package:dmakla/src/business_logic/blocs/auth/auth.bloc.dart';
import 'package:dmakla/src/business_logic/blocs/auth/auth.state.dart';
import 'package:flutter/material.dart';
import 'package:dmakla/src/models/order.dart';
import 'package:dmakla/src/views/elements/OrderItemWidget.dart';
import 'package:dmakla/src/views/elements/ProfileAvatarWidget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dmakla/src/business_logic/utils/constants/wilaya.dart';
import 'package:dmakla/src/business_logic/models/user.dart';
import 'package:dmakla/src/business_logic/models/common/wilaya.dart';
class ProfileWidget extends StatefulWidget {
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  String _selectedWilaya;
  User _user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AuthenticationAuthenticated state = BlocProvider.of<AuthenticationBloc>(context).state;
    _user = state.user;
    _selectedWilaya = WILAYA_MAP[_user.wilaya.code];
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Column(
        children: <Widget>[
          ProfileAvatarWidget(),
          // ListTile(
          //   contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //   leading: Icon(
          //     Icons.person,
          //     color: Theme.of(context).hintColor,
          //   ),
          //   title: Text(
          //     'About',
          //     style: Theme.of(context).textTheme.display1,
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: Text(
          //     'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical professor Read More',
          //     style: Theme.of(context).textTheme.body1,
          //   ),
          // ),
          // ListTile(
          //   contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //   leading: Icon(
          //     Icons.shopping_basket,
          //     color: Theme.of(context).hintColor,
          //   ),
          //   title: Text(
          //     'Recent Orders',
          //     style: Theme.of(context).textTheme.display1,
          //   ),
          // ),
          // ListView.separated(
          //   scrollDirection: Axis.vertical,
          //   shrinkWrap: true,
          //   primary: false,
          //   itemCount: _ordersList.recentOrderedList.length,
          //   separatorBuilder: (context, index) {
          //     return SizedBox(height: 10);
          //   },
          //   itemBuilder: (context, index) {
          //     return OrderItemWidget(
          //       heroTag: 'profile_orders',
          //       order: _ordersList.recentOrderedList.elementAt(index),
          //     );
          //   },
          // ),
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
            if (state is AuthenticationAuthenticated) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Theme.of(context).primaryColor.withOpacity(0.9),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).focusColor.withOpacity(0.2),
                          blurRadius: 5,
                          offset: Offset(0, 2)),
                    ],
                  ),
                  child: Column(

                    children: [
                      ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        leading: Icon(
                          Icons.phone,
                          color: Theme.of(context).accentColor,
                        ),
                        title: Text(
                          'Mobile No.',
                          style: Theme.of(context)
                              .textTheme
                              .display1
                              .copyWith(color: Theme.of(context).accentColor),
                        ),
                        trailing: Text(
                          state.user.phoneNumber,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.display2,
                        ),
                      ),
                      ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        leading: Icon(
                          Icons.wallet_membership,
                          color: Theme.of(context).accentColor,
                        ),
                        title: Text(
                          'Wallet',
                          style: Theme.of(context)
                              .textTheme
                              .display1
                              .copyWith(color: Theme.of(context).accentColor),
                        ),
                        trailing: Text(
                          _user.wallet == null ? "N/A" : _user.wallet.currentBalance.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.display2,
                        ),
                      ),
                  SizedBox(height: 10,),
                  Text(
                    "Votre wilaya courante",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                      DropdownButtonFormField<String>(
                          value: _selectedWilaya,
                          isExpanded: true,
                          iconSize: 24,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                    Theme.of(context).focusColor.withOpacity(0.2))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                    Theme.of(context).focusColor.withOpacity(0.5))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                    Theme.of(context).focusColor.withOpacity(0.2))),
                          ),
                          elevation: 16,
                          style: TextStyle(color: Theme.of(context).accentColor),
                          onChanged: (String newValue) {
                            setState(() {
                              _selectedWilaya = newValue;
                              _user.wilaya = Wilaya.fromName(_selectedWilaya);
                            });
                          },
                          items: WILAYA_MAP.values
                              .toList()
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            );
                          }).toList()),
                    ],
                  ),
                ),
              );
            }
            return Container();
          })
        ],
      ),
    );
  }
}
