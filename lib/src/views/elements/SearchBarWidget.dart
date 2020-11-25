import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final String title;
  const SearchBarWidget({
    this.title,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(12),
        hintText: this.title,
        hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
        prefixIcon: Icon(Icons.search, color: Theme.of(context).accentColor),
        suffixIcon: Icon(Icons.mic_none, color: Theme.of(context).focusColor.withOpacity(0.7)),
        border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
      ),
    );
  }
}
