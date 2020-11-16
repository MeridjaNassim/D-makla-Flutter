import 'package:flutter/material.dart';
import 'package:restaurant_rlutter_ui/src/elements/FavoriteGridItemWidget.dart';
import 'package:restaurant_rlutter_ui/src/elements/FavoriteListItemWidget.dart';
import 'package:restaurant_rlutter_ui/src/models/food.dart';

class FavoritesWidget extends StatefulWidget {
  @override
  _FavoritesWidgetState createState() => _FavoritesWidgetState();
}

class _FavoritesWidgetState extends State<FavoritesWidget> {
  String layout = 'grid';
  FoodsList _foodsList = new FoodsList();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                leading: Icon(
                  Icons.favorite,
                  color: Theme.of(context).hintColor,
                ),
                title: Text(
                  'Favorite Foods',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.display1,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        setState(() {
                          this.layout = 'list';
                        });
                      },
                      icon: Icon(
                        Icons.format_list_bulleted,
                        color: this.layout == 'list' ? Theme.of(context).accentColor : Theme.of(context).focusColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          this.layout = 'grid';
                        });
                      },
                      icon: Icon(
                        Icons.apps,
                        color: this.layout == 'grid' ? Theme.of(context).accentColor : Theme.of(context).focusColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Offstage(
              offstage: this.layout != 'list',
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                itemCount: _foodsList.favoritesList.length,
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
                itemBuilder: (context, index) {
                  return FavoriteListItemWidget(
                    heroTag: 'favorites_list',
                    food: _foodsList.favoritesList.elementAt(index),
                  );
                },
              ),
            ),
            Offstage(
              offstage: this.layout != 'grid',
              child: GridView.count(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
                padding: EdgeInsets.symmetric(horizontal: 20),

                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this produces 2 rows.
                crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4,
                // Generate 100 widgets that display their index in the List.
                children: List.generate(6, (index) {
                  return FavoriteGridItemWidget(
                    heroTag: 'favorites_grid',
                    food: _foodsList.favoritesList.elementAt(index),
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
