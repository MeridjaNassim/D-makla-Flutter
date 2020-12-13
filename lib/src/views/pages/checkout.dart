import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/auth/auth.bloc.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/auth/auth.state.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/cart/cart.bloc.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/cart/cart.state.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/delivery/delivery.cubit.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/common/wilaya.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/delivery.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/user.dart';
import 'package:restaurant_rlutter_ui/src/views/elements/common/loading.dart';

class CheckoutWidget extends StatefulWidget {
  @override
  _CheckoutWidgetState createState() => _CheckoutWidgetState();
}

class _CheckoutWidgetState extends State<CheckoutWidget> {
  String _addressValue;
  String _phoneNumberValue;
  TextEditingController _addressController;
  TextEditingController _phoneNumberController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    User user = (BlocProvider.of<AuthenticationBloc>(context).state as AuthenticationAuthenticated).user;
    _addressValue = user.address;
    _phoneNumberValue = user.phoneNumber;
    _addressController = new TextEditingController();
    _phoneNumberController = new TextEditingController();
    _addressController.text = _addressValue;
    _phoneNumberController.text = _phoneNumberValue;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
  }

  Widget _buildScreen() {
    final today = DateTime.now();
    final maxDeliveryTimeFromToday = today.add(Duration(days: 30));
    return BlocConsumer<DeliveryCubit,DeliveryState>(
      listener: (context,state) async{
        if(state is ApprovedDeliveryState) {
          await BlocProvider.of<DeliveryCubit>(context).resetDelivery();
          Navigator.of(context).pushReplacementNamed(("/Delivery"));
        }
      },
      builder:(context,state) {
        if(state is ConfirmingDeliveryState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LoadingIndicator(loadingText: "confirming delivery ...")],
          );
        }
        if(state is LoadingDeliveryState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LoadingIndicator(loadingText: "loading cart ...")],
          );
        }
        if(state is LoadedDeliveryState) {
          return SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 10),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      leading: Icon(
                        Icons.delivery_dining,
                        color: Theme.of(context).hintColor,
                      ),
                      title: Text(
                        'Livraison',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.display1,
                      ),
                      subtitle: Text(
                        'Séléctionner vos options de livraison',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: DropdownButtonFormField<Commune>(
                        hint: Text("Commune de livraison"),
                        value: state.selectedCommune,
                        icon: Icon(Icons.map,
                            color: Theme.of(context).accentColor),
                        isExpanded: true,
                        iconSize: 24,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                        ),
                        elevation: 16,
                        style: TextStyle(color: Theme.of(context).accentColor),
                        onChanged: (Commune newCommune) {
                          BlocProvider.of<DeliveryCubit>(context).setSelectedCommune(newCommune);
                        },
                        items: state.deliveryLocations
                            .map<DropdownMenuItem<Commune>>((Commune value) {
                          return DropdownMenuItem<Commune>(
                            value: value,
                            child: Text(
                              value.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          );
                        }).toList()),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: DropdownButtonFormField<DeliveryZone>(
                        hint: Text("Zone de livraison"),
                        value: state.selectedZone,
                        icon: Icon(Icons.add_location_alt,
                            color: Theme.of(context).accentColor),
                        isExpanded: true,
                        iconSize: 24,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                        ),
                        elevation: 16,
                        style: TextStyle(color: Theme.of(context).accentColor),
                        onChanged: (DeliveryZone newZone) {
                          BlocProvider.of<DeliveryCubit>(context).setDeliveryZone(newZone);
                        },
                        items: state.selectedCommune.zones
                            .map<DropdownMenuItem<DeliveryZone>>((DeliveryZone value) {
                          return DropdownMenuItem<DeliveryZone>(
                            value: value,
                            child: Text(
                              value.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          );
                        }).toList()),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      autofocus: false,
                      onChanged: (value) {
                        this.setState(() {
                          _addressValue = value;
                        });
                      },
                      keyboardType: TextInputType.streetAddress,
                      controller: _addressController,
                      decoration: InputDecoration(
                        labelText: "Adresse",
                        errorText: null,
                        labelStyle:
                        TextStyle(color: Theme.of(context).accentColor),
                        contentPadding: EdgeInsets.all(12),
                        hintText: 'Votre adresse',
                        hintStyle: TextStyle(
                            color: Theme.of(context).focusColor.withOpacity(0.7)),
                        suffixIcon: Icon(Icons.home,
                            color: Theme.of(context).accentColor),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.2))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.5))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.2))),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      autofocus: false,
                      onChanged: (value) {
                        this.setState(() {
                          _phoneNumberValue = value;
                        });
                      },
                      keyboardType: TextInputType.phone,
                      controller: _phoneNumberController,
                      decoration: InputDecoration(
                        labelText: "Mobile N° de reception",
                        errorText: null,
                        labelStyle:
                        TextStyle(color: Theme.of(context).accentColor),
                        contentPadding: EdgeInsets.all(12),
                        hintText: '0123456789',
                        hintStyle: TextStyle(
                            color: Theme.of(context).focusColor.withOpacity(0.7)),
                        suffixIcon: Icon(Icons.phone,
                            color: Theme.of(context).accentColor),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.2))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.5))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.2))),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: FlatButton(
                      onPressed: () {
                        DatePicker.showDateTimePicker(context,
                            theme: DatePickerTheme(
                              cancelStyle: Theme.of(context).textTheme.body2,
                              doneStyle: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontWeight: FontWeight.bold),
                              itemStyle:
                              TextStyle(color: Theme.of(context).accentColor),
                            ),
                            showTitleActions: true,
                            minTime: today,
                            maxTime: maxDeliveryTimeFromToday, onChanged: (date) {
                              print('change $date');
                            }, onConfirm: (date) {
                              print('confirm $date');
                              BlocProvider.of<DeliveryCubit>(context).setDeliveryTime(DeliveryTime(date));
                            }, currentTime: DateTime.now(), locale: LocaleType.fr);
                      },
                      padding: EdgeInsets.symmetric(vertical: 14),
                      color: Theme.of(context).accentColor,
                      child: Container(
                          width: double.infinity,
                          child: ListTile(
                            trailing: Icon(Icons.calendar_today_rounded, color: Theme.of(context).primaryColor,),
                            title:  Text(
                              'Livrer le ${getDeliveryDateText(state.deliveryTime)} à ${getDeliveryTimeText(state.deliveryTime)}',
                              textAlign: TextAlign.start,
                              style: TextStyle(color: Theme.of(context).primaryColor),
                            ),
                          )
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        leading: Icon(
                          Icons.shopping_cart,
                          color: Theme.of(context).hintColor,
                        ),
                        title: Text(
                          'Frais de Commande',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.display1,
                        ),
                        trailing: BlocBuilder<CartBloc,CartState>(
                          builder:(context,state)=> Text(
                            (state is LoadedCartState) ? state.currentCartPrice.toString()+ "DA" : "...",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.display3,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        leading: Icon(
                          Icons.delivery_dining,
                          color: Theme.of(context).hintColor,
                        ),
                        title: Text(
                          'Frais de livraison',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.display1,
                        ),
                        trailing: Text(
                          (state.zonePrice+state.timePrice).toStringAsFixed(2)+"DA",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.display3,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  Stack(
                    fit: StackFit.loose,
                    alignment: AlignmentDirectional.centerEnd,
                    children: <Widget>[
                      SizedBox(
                        width: 320,
                        child: FlatButton(
                          onPressed: () {
                            BlocProvider.of<DeliveryCubit>(context).confirmDelivery();
                          },
                          padding: EdgeInsets.symmetric(vertical: 14),
                          color: Theme.of(context).accentColor,
                          shape: StadiumBorder(),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Confirm Order',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: BlocBuilder<CartBloc, CartState>(
                          builder: (context, cartState) => Text(
                            (cartState is LoadedCartState)
                                ? getFullPrice(cartState,state)
                                : "Loading cart",
                            style: Theme.of(context).textTheme.display1.merge(
                                TextStyle(color: Theme.of(context).primaryColor)),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )
          );
        }
        return  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LoadingIndicator(loadingText: "loading delivery ...")],
        );
      }
    );
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
          'Checkout',
          style: Theme.of(context)
              .textTheme
              .title
              .merge(TextStyle(letterSpacing: 1.3)),
        ),
      ),
      body: _buildScreen(),
    );
  }
  String getFullPrice(CartState cartState,DeliveryState deliveryState) {
    final cartPrice = (cartState as LoadedCartState).currentCartPrice;
    final deliveryPrice = (deliveryState as LoadedDeliveryState).zonePrice + (deliveryState as LoadedDeliveryState).timePrice;
    return (cartPrice+ deliveryPrice).toStringAsFixed(2)+"DA";
  }
}

String getDeliveryTimeText(DeliveryTime deliveryTime) {
  final time = deliveryTime.dateTime;
  return time.hour.toString().padLeft(2,"0") + " : " + time.minute.toString().padLeft(2,"0");
}

String getDeliveryDateText(DeliveryTime deliveryTime) {
  final time = deliveryTime.dateTime;
  return "${time.day}-${time.month}-${time.year}";
}
