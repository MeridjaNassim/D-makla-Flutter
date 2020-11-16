import 'package:flutter/material.dart';
import 'package:restaurant_rlutter_ui/src/elements/DrawerWidget.dart';
import 'package:restaurant_rlutter_ui/src/elements/FaqItemWidget.dart';
import 'package:restaurant_rlutter_ui/src/elements/ShoppingCartButtonWidget.dart';

class HelpWidget extends StatefulWidget {
  @override
  _HelpWidgetState createState() => _HelpWidgetState();
}

class _HelpWidgetState extends State<HelpWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    return Scaffold(
//      drawer: DrawerWidget(),
//      appBar: AppBar(
//        backgroundColor: Colors.transparent,
//        elevation: 0,
//        centerTitle: true,
//        title: Text(
//          'Faq',
//          style: Theme.of(context).textTheme.title.merge(TextStyle(letterSpacing: 1.3)),
//        ),
//        actions: <Widget>[
//          new ShoppingCartButtonWidget(
//              iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
//        ],
//      ),
//      body: SingleChildScrollView(
//        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          mainAxisAlignment: MainAxisAlignment.start,
//          mainAxisSize: MainAxisSize.max,
//          children: <Widget>[
//            TextField(
//              decoration: InputDecoration(
//                contentPadding: EdgeInsets.all(12),
//                hintText: 'Search',
//                prefixIcon: Icon(Icons.search, color: Theme.of(context).accentColor),
//                suffixIcon: Icon(Icons.mic_none, color: Theme.of(context).focusColor.withOpacity(0.7)),
//                border:
//                    OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
//                focusedBorder:
//                    OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
//                enabledBorder:
//                    OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
//              ),
//            ),
//            SizedBox(height: 15),
//            ListTile(
//              contentPadding: EdgeInsets.symmetric(vertical: 0),
//              leading: Icon(
//                Icons.help,
//                color: Theme.of(context).hintColor,
//              ),
//              title: Text(
//                'Help & Supports',
//                maxLines: 1,
//                overflow: TextOverflow.ellipsis,
//                style: Theme.of(context).textTheme.display1,
//              ),
//            ),
//            ListView.separated(
//              padding: EdgeInsets.symmetric(vertical: 15),
//              scrollDirection: Axis.vertical,
//              shrinkWrap: true,
//              primary: false,
//              itemCount: 10,
//              separatorBuilder: (context, index) {
//                return SizedBox(height: 15);
//              },
//              itemBuilder: (context, index) {
//                return FaqItemWidget(index: index);
//              },
//            ),
//          ],
//        ),
//      ),
//    );
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        drawer: DrawerWidget(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).focusColor,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Services'),
              Tab(text: 'Delivery'),
              Tab(text: 'Menu'),
              Tab(text: 'Misc'),
            ],
            labelColor: Theme.of(context).primaryColor,
          ),
          title: Text(
            'Faq',
            style: Theme.of(context)
                .textTheme
                .title
                .merge(TextStyle(letterSpacing: 1.3, color: Theme.of(context).primaryColor)),
          ),
          actions: <Widget>[
            new ShoppingCartButtonWidget(
                iconColor: Theme.of(context).primaryColor, labelColor: Theme.of(context).accentColor),
          ],
        ),
        body: TabBarView(
          children: List.generate(4, (index) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                      prefixIcon: Icon(Icons.search, color: Theme.of(context).accentColor),
                      suffixIcon: Icon(Icons.mic_none, color: Theme.of(context).focusColor.withOpacity(0.7)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                    ),
                  ),
                  SizedBox(height: 15),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    leading: Icon(
                      Icons.help,
                      color: Theme.of(context).hintColor,
                    ),
                    title: Text(
                      'Help & Supports',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.display1,
                    ),
                  ),
                  ListView.separated(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    primary: false,
                    itemCount: 10,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 15);
                    },
                    itemBuilder: (context, index) {
                      return FaqItemWidget(index: index);
                    },
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
