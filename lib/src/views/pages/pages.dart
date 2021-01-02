import 'package:dmakla_flutter/src/business_logic/blocs/orders/orders.cubit.dart';
import 'package:dmakla_flutter/src/views/blocs/tabNavigation.cubit.dart';
import 'package:dmakla_flutter/src/views/constants/navigation.dart';
import 'package:flutter/material.dart';
import 'package:dmakla_flutter/src/views/elements/DrawerWidget.dart';
import 'package:dmakla_flutter/src/views/elements/ShoppingCartButtonWidget.dart';
import 'package:dmakla_flutter/src/views/pages/home.dart';
import 'package:dmakla_flutter/src/views/pages/profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'favorites.dart';
import 'notifications.dart';
import 'orders.dart';


// ignore: must_be_immutable
class PagesTestWidget extends StatefulWidget {
  String currentTitle;
  Widget currentPage;

  PagesTestWidget({
    Key key,
  }) : super(key: key);

  @override
  _PagesTestWidgetState createState() {
    return _PagesTestWidgetState();
  }
}

class _PagesTestWidgetState extends State<PagesTestWidget> {
  String currentTitle;
  Widget currentPage;

  initState() {
    super.initState();
    final tabIndex = BlocProvider.of<TabNavigationCubit>(context).state.tabIndex;
    _selectTab(tabIndex);
  }

  void _selectTab(int tabItem) {
    BlocProvider.of<TabNavigationCubit>(context).setTabIndex(tabItem);
    setState(() {
      switch (tabItem) {
        // case 0:
        //   widget.currentTitle = 'Notifications';
        //   widget.currentPage = NotificationsWidget();
        //   break;
        case PROFILE_TAB_INDEX:
          currentTitle = 'Profile';
         currentPage = ProfileWidget();
          break;
        case HOME_TAB_INDEX:
         currentTitle = 'Home';
          currentPage = HomeWidget();
          break;
        case ORDERS_TAB_INDEX:
          currentTitle = 'My Orders';
          BlocProvider.of<OrdersCubit>(context).loadOrders();
          currentPage = OrdersWidget();
          break;
        // case 4:
        //   widget.currentTitle = 'Favorites';
        //   widget.currentPage = FavoritesWidget();
        //   break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: DrawerWidget(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            this.currentTitle,
            style: Theme.of(context).textTheme.title.merge(TextStyle(letterSpacing: 1.3)),
          ),
          actions: <Widget>[
            new ShoppingCartButtonWidget(
                iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
          ],
        ),
        body: this.currentPage,
        bottomNavigationBar: BlocConsumer<TabNavigationCubit,TabNavigationState>(
          listener: (context,state){
            _selectTab(state.tabIndex);
          },
          builder:(context,state)=> BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Theme.of(context).accentColor,
            selectedFontSize: 0,
            unselectedFontSize: 0,
            iconSize: 22,
            elevation: 0,
            backgroundColor: Colors.transparent,
            selectedIconTheme: IconThemeData(size: 28),
            unselectedItemColor: Theme.of(context).focusColor.withOpacity(1),
            currentIndex: state.tabIndex,
            onTap: (int i) {
              this._selectTab(i);
            },
            // this will be set when a new tab is tapped
            items: [
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.notifications),
              //   title: new Container(height: 0.0),
              // ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: new Container(height: 0.0),
              ),
              BottomNavigationBarItem(
                  title: new Container(height: 5.0),
                  icon: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).accentColor.withOpacity(0.4), blurRadius: 40, offset: Offset(0, 15)),
                        BoxShadow(
                            color: Theme.of(context).accentColor.withOpacity(0.4), blurRadius: 13, offset: Offset(0, 3))
                      ],
                    ),
                    child: new Icon(Icons.home, color: Theme.of(context).primaryColor),
                  )),
              BottomNavigationBarItem(
                icon: new Icon(Icons.fastfood),
                title: new Container(height: 0.0),
              ),
              // BottomNavigationBarItem(
              //   icon: new Icon(Icons.favorite),
              //   title: new Container(height: 0.0),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
