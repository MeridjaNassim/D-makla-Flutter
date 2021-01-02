import 'package:flutter/material.dart';
import 'package:dmakla_flutter/src/models/conversation.dart' as model;
import 'package:dmakla_flutter/src/views/elements/EmptyMessagesWidget.dart';
import 'package:dmakla_flutter/src/views/elements/MessageItemWidget.dart';
import 'package:dmakla_flutter/src/views/elements/SearchBarWidget.dart';
import 'package:dmakla_flutter/src/views/elements/ShoppingCartButtonWidget.dart';

class MessagesWidget extends StatefulWidget {
  @override
  _MessagesWidgetState createState() => _MessagesWidgetState();
}

class _MessagesWidgetState extends State<MessagesWidget> {
  model.ConversationsList _conversationList;

  @override
  void initState() {
    this._conversationList = new model.ConversationsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Messages',
            style: Theme.of(context).textTheme.title.merge(TextStyle(letterSpacing: 1.3)),
          ),
          actions: <Widget>[
            new ShoppingCartButtonWidget(
                iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 7),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SearchBarWidget(),
              ),
              Offstage(
                offstage: _conversationList.conversations.isEmpty,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shrinkWrap: true,
                  primary: false,
                  itemCount: _conversationList.conversations.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 7);
                  },
                  itemBuilder: (context, index) {
                    return MessageItemWidget(
                      message: _conversationList.conversations.elementAt(index),
                      onDismissed: (conversation) {
                        setState(() {
                          _conversationList.conversations.removeAt(index);
                        });
                      },
                    );
                  },
                ),
              ),
              Offstage(
                offstage: _conversationList.conversations.isNotEmpty,
                child: EmptyMessagesWidget(),
              )
            ],
          ),
        ));
  }
}
