import 'package:dmakla/src/business_logic/blocs/auth/auth.bloc.dart';
import 'package:dmakla/src/business_logic/blocs/auth/auth.state.dart';
import 'package:flutter/material.dart';
import 'package:dmakla/src/models/order.dart';
import 'package:dmakla/src/views/elements/OrderItemWidget.dart';
import 'package:dmakla/src/views/elements/ProfileAvatarWidget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileWidget extends StatelessWidget {
  OrdersList _ordersList = new OrdersList();
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
                          "N/A",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.display2,
                        ),
                      ),
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
