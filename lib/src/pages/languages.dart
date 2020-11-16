import 'package:flutter/material.dart';
import 'package:restaurant_rlutter_ui/src/elements/LanguageItemWidget.dart';
import 'package:restaurant_rlutter_ui/src/elements/ShoppingCartButtonWidget.dart';
import 'package:restaurant_rlutter_ui/src/models/language.dart';

class LanguagesWidget extends StatefulWidget {
  @override
  _LanguagesWidgetState createState() => _LanguagesWidgetState();
}

class _LanguagesWidgetState extends State<LanguagesWidget> {
  LanguagesList languagesList;
  @override
  void initState() {
    languagesList = new LanguagesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Languages',
          style: Theme.of(context).textTheme.title.merge(TextStyle(letterSpacing: 1.3)),
        ),
        actions: <Widget>[
          new ShoppingCartButtonWidget(
              iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                  prefixIcon: Icon(Icons.search, color: Theme.of(context).accentColor),
                  suffixIcon: Icon(Icons.mic_none, color: Theme.of(context).focusColor.withOpacity(0.7)),
                  border:
                      OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                  focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                ),
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                leading: Icon(
                  Icons.translate,
                  color: Theme.of(context).hintColor,
                ),
                title: Text(
                  'App Language',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.display1,
                ),
              ),
            ),
            SizedBox(height: 10),
            ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              itemCount: languagesList.languages.length,
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemBuilder: (context, index) {
                return LanguageItemWidget(language: languagesList.languages.elementAt(index));
              },
            ),
          ],
        ),
      ),
    );
  }
}
