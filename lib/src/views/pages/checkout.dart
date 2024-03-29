import 'package:dmakla/src/views/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dmakla/config/app_config.dart' as config;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:dmakla/src/business_logic/blocs/auth/auth.bloc.dart';
import 'package:dmakla/src/business_logic/blocs/auth/auth.state.dart';
import 'package:dmakla/src/business_logic/blocs/cart/cart.bloc.dart';
import 'package:dmakla/src/business_logic/blocs/cart/cart.state.dart';
import 'package:dmakla/src/business_logic/blocs/delivery/delivery.cubit.dart';
import 'package:dmakla/src/business_logic/models/common/wilaya.dart';
import 'package:dmakla/src/business_logic/models/delivery.dart';
import 'package:dmakla/src/business_logic/models/user.dart';
import 'package:dmakla/src/views/elements/common/loading.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dmakla/src/business_logic/blocs/login/bloc/login_bloc.dart';
import 'package:dmakla/src/business_logic/blocs/login/bloc/login_event.dart';
import 'package:dmakla/src/business_logic/blocs/login/bloc/login_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CheckoutWidget extends StatefulWidget {
  @override
  _CheckoutWidgetState createState() => _CheckoutWidgetState();
}

class _CheckoutWidgetState extends State<CheckoutWidget> {
  bool useMyGeoLocalisationPosition;
  String _addressValue;
  String _phoneNumberValue;
  String _commentaireLivraison;
  TextEditingController _addressController;
  TextEditingController _phoneNumberController;
  TextEditingController _commentaireController;
  int startHour;
  int startMinute;
  int endhour;
  int endMinute;
  OverlayEntry loginForm;
  User _user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginForm= null;
    _user = (BlocProvider.of<AuthenticationBloc>(context).state
            as AuthenticationAuthenticated)
        .user;
    _addressValue = _user.address;
    useMyGeoLocalisationPosition = true;
    _phoneNumberValue = _user.phoneNumber;
    _commentaireLivraison = "";
    _addressController = new TextEditingController();
    _phoneNumberController = new TextEditingController();
    _commentaireController = new TextEditingController();
    _addressController.text = _addressValue;
    _commentaireController.text = _commentaireLivraison;
    _phoneNumberController.text = _phoneNumberValue;
    startHour = 9;
    startMinute = 0;
    endhour = 21;
    endMinute = 0;
    initWorkingHours();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    _commentaireController.dispose();
  }

  Future<void> initWorkingHours() async {
    final endpoint = DotEnv().env["WORKING_HOURS_ENDPOINT"];
    final response = await http.post(endpoint);
    if (response.body.isNotEmpty) {
      final decoded = json.decode(response.body);
      //print(decoded);
      setState(() {
        try {
          startHour = num.parse(decoded["start_time_hour"]).toInt();
          startMinute = num.parse(decoded["start_time_minute"]).toInt();
          endhour = num.parse(decoded["end_time_hour"]).toInt();
          endMinute = num.parse(decoded["end_time_minute"]).toInt();
        } catch (e) {
          startHour = 9;
          startMinute = 0;
          endhour = 21;
          endMinute = 0;
        }
      });
    }
  }

  Widget _buildScreen() {
    final starting = DateTime.now().add(Duration(minutes: 30));
    final maxDeliveryTimeFromToday = starting.add(Duration(days: 30));
    return BlocConsumer<DeliveryCubit, DeliveryState>(
        listener: (context, state) async {
      if (state is ApprovedDeliveryState) {
        await BlocProvider.of<DeliveryCubit>(context).resetDelivery();
        Navigator.of(context)
            .pushReplacementNamed("/Delivery", arguments: state.confirmation);
      }
      if (state is RejectedDeliveryState) {
        Scaffold.of(context).showSnackBar(SnackBar(
            backgroundColor: Theme.of(context).accentColor,
            content: Text(state.message,
                textAlign: TextAlign.start,
                style: TextStyle(color: Theme.of(context).primaryColor))));
      }
    }, builder: (context, state) {
      if (state is ConfirmingDeliveryState) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LoadingIndicator(loadingText: "confirmation de commande ...")
          ],
        );
      }
      if (state is LoadingDeliveryState) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [LoadingIndicator(loadingText: "chargement")],
        );
      }
      if (state is LoadedDeliveryState) {
        return BlocConsumer<AuthenticationBloc,AuthenticationState>(
          listener: (context,userState){
            if(userState is AuthenticationAuthenticated) {
              this.setState(() {
                _user =userState.user;
                print(_user.phoneNumber);
                _phoneNumberValue = _user.phoneNumber;

                _phoneNumberController.text = _user.phoneNumber;
                print(_user.address);
                _addressController.text = _user.address;
                _addressValue = _user.address;
              });
            }
          },
          builder:(context,userState)=> SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
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
                        'Information de livraison',
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
                  CheckboxListTile(
                    title: Row(
                      children: [
                        Icon(Icons.gps_fixed,
                            color: Theme.of(context).accentColor),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: Text(
                                "Utiliser ma position GPS pour la livraison"))
                      ],
                    ),
                    value: useMyGeoLocalisationPosition,
                    onChanged: (newValue) {
                      setState(() {
                        useMyGeoLocalisationPosition = newValue;
                      });
                    },
                    controlAffinity:
                        ListTileControlAffinity.trailing, //  <-- leading Checkbox
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          size: 14,
                          color: Theme.of(context).accentColor,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Choisissez votre commune',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.body1,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: DropdownButtonFormField<Commune>(
                        hint: Text("Commune de livraison"),
                        value: state.selectedCommune,
                        icon:
                            Icon(Icons.map, color: Theme.of(context).accentColor),
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
                          BlocProvider.of<DeliveryCubit>(context)
                              .setSelectedCommune(newCommune);
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
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          size: 14,
                          color: Theme.of(context).accentColor,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Choisissez la zone de livraison',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.body1,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
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
                          BlocProvider.of<DeliveryCubit>(context)
                              .setDeliveryZone(newZone);
                        },
                        items: state.selectedCommune.zones
                            .map<DropdownMenuItem<DeliveryZone>>(
                                (DeliveryZone value) {
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
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          size: 14,
                          color: Theme.of(context).accentColor,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Choisissez la date et heure de livraison',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.body1,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: FlatButton(
                      onPressed: () {
                        final state = BlocProvider.of<DeliveryCubit>(context)
                            .state as LoadedDeliveryState;
                        final currentDateTime = state.deliveryTime.dateTime;
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
                            minTime: starting,
                            maxTime: maxDeliveryTimeFromToday, onChanged: (date) {
                          //print('change $date');
                        }, onConfirm: (date) {
                          //print('confirm $date');

                          if (date.hour > endhour || date.hour < startHour) {
                            return Scaffold.of(context).showSnackBar(SnackBar(
                                backgroundColor: Theme.of(context).accentColor,
                                content: Text(
                                    "Heure de livraison doit être entre ${startHour.toString()}:00 et ${endhour.toString()}:00")));
                          }
                          BlocProvider.of<DeliveryCubit>(context)
                              .setDeliveryTime(DeliveryTime(date));
                        }, currentTime: currentDateTime, locale: LocaleType.fr);
                      },
                      padding: EdgeInsets.symmetric(vertical: 0),
                      color: Theme.of(context).accentColor,
                      child: Container(
                          width: double.infinity,
                          child: ListTile(
                            trailing: Icon(
                              Icons.calendar_today_rounded,
                              color: Theme.of(context).primaryColor,
                            ),
                            title: Text(
                              'Livrer le ${getDeliveryDateText(state.deliveryTime)} à ${getDeliveryTimeText(state.deliveryTime)}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          )),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      autofocus: false,
                      onChanged: (value) {
                        this.setState(() {
                          _commentaireLivraison = value;
                        });
                      },
                      keyboardType: TextInputType.text,
                      minLines: 3,
                      maxLines: 10,
                      controller: _commentaireController,
                      decoration: InputDecoration(
                        labelText: "Commentaire sur livraison",
                        errorText: null,
                        labelStyle:
                            TextStyle(color: Theme.of(context).accentColor),
                        contentPadding: EdgeInsets.all(12),
                        hintText: 'Commentaire sur livraison',
                        hintStyle: TextStyle(
                            color: Theme.of(context).focusColor.withOpacity(0.7)),
                        suffixIcon: Icon(Icons.comment,
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
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      leading: Icon(
                        Icons.add,
                        color: Theme.of(context).hintColor,
                      ),
                      title: Text(
                        'Information de réception',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.display1,
                      ),
                      subtitle: Text(
                        'Entrez vos informations de réception',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ),
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
                        hintText: 'Votre adresse (optionnel)',
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
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      leading: Icon(
                        Icons.money,
                        color: Theme.of(context).hintColor,
                      ),
                      title: Text(
                        'Payement',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.display1,
                      ),
                      subtitle: Text(
                        'confirmez votre commande après vérification des informations',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ),
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
                          'Totale de Commande',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.display1,
                        ),
                        trailing: BlocBuilder<CartBloc, CartState>(
                          builder: (context, state) => Text(
                            (state is LoadedCartState)
                                ? state.currentCartPrice.toInt().toString() + "DA"
                                : "...",
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
                          (state.delivery.delivery_fee).toInt().toString() + "DA",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.display2,
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
                          Icons.payments_outlined,
                          color: Theme.of(context).hintColor,
                        ),
                        title: Text(
                          'Remise',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.display1,
                        ),
                        trailing: Text(
                          "-" +
                              (state.delivery.discount).toInt().toString() +
                              "DA",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .display3
                              .copyWith(color: Colors.green),
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
                          Icons.account_circle_outlined,
                          color: Theme.of(context).hintColor,
                        ),
                        title: Text(
                          'Client',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.display1,
                        ),
                        trailing: BlocBuilder<AuthenticationBloc,AuthenticationState>(
                          builder:(context,state)=> Text(
                            getUserName(state),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.display1,
                          ),
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
                          onPressed:  () async {
                            final state = BlocProvider.of<DeliveryCubit>(context)
                                .state as LoadedDeliveryState;
                            final date = state.deliveryTime.dateTime;

                            if (date.hour > endhour || date.hour < startHour) {
                              return Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Theme.of(context).accentColor,
                                  content: Text(
                                      "Heure de livraison doit être entre ${startHour.toString()}:00 et ${endhour.toString()}:00")));
                            }
                            bool isGuest =  BlocProvider.of<AuthenticationBloc>(context).isGuest();
                            if(!isGuest){
                              print("is guest");
                              final payload = ConfirmDeliveryPayload(
                                  useGpsPosition: useMyGeoLocalisationPosition,
                                  contactPhoneNumber: _phoneNumberValue,
                                  address: _addressValue,
                                  deliveryComment: _commentaireLivraison);
                              BlocProvider.of<DeliveryCubit>(context)
                                  .confirmDelivery(payload: payload);
                            }
                            else
                              {
                                loginUser(context);

                              }

                          },
                          padding: EdgeInsets.symmetric(vertical: 14),
                          color: Theme.of(context).accentColor,
                          shape: StadiumBorder(),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Confirmer',
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
                                ? getFullPrice(cartState, state)
                                : "Loading cart",
                            style: Theme.of(context).textTheme.display1.merge(
                                TextStyle(color: Theme.of(context).primaryColor)),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              )),
        );
      }
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [LoadingIndicator(loadingText: "chargement livraison ...")],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Theme.of(context).accentColor),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Livraison',
          style: Theme.of(context)
              .textTheme
              .title
              .merge(TextStyle(letterSpacing: 1.3)),
        ),
      ),
      body: _buildScreen(),
    );
  }

  String getFullPrice(CartState cartState, DeliveryState deliveryState) {
    final cartPrice = (cartState as LoadedCartState).currentCartPrice;
    //final totalCartPrice = (cartState as LoadedDeliveryState).delivery.order_fee;
    final deliveryPrice =
        (deliveryState as LoadedDeliveryState).delivery.delivery_fee;
    final discountPrice =
        (deliveryState as LoadedDeliveryState).delivery.discount;
    return (cartPrice + deliveryPrice - discountPrice).toInt().toString() +
        "DA";
  }

  Future<void> loginUser(BuildContext context) async {
      return await Navigator.of(context).push( MaterialPageRoute(builder: (_)=>LoginFromGuestWidget(
      onLogin: (context,result){
        Navigator.pop(context,result);
      },
      onCancel: (context,result){
        Navigator.pop(context,result);
      },
    )));
  }

  String getUserName(AuthenticationState state) {
    if(state is AuthenticationAuthenticated)
      {
        return state.user.fullName;
      }
    return "no user";
  }
}

String getDeliveryTimeText(DeliveryTime deliveryTime) {
  final time = deliveryTime.dateTime;
  return time.hour.toString().padLeft(2, "0") +
      " : " +
      time.minute.toString().padLeft(2, "0");
}

String getDeliveryDateText(DeliveryTime deliveryTime) {
  final time = deliveryTime.dateTime;
  return "${time.day}-${time.month}-${time.year}";
}
