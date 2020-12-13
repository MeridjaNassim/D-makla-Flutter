import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/auth/auth.bloc.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/auth/auth.state.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/cart/cart.bloc.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/cart/cart.event.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/cart/cart.state.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/common/wilaya.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/delivery.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/user.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/repositories/delivery_repository.dart';
import 'dart:math' as math;

import 'package:restaurant_rlutter_ui/src/business_logic/repositories/order_repository.dart';
abstract class DeliveryState extends Equatable {}

class InitialDeliveryState extends DeliveryState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class LoadingDeliveryState extends DeliveryState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class ConfirmingDeliveryState extends DeliveryState {
  @override
  // TODO: implement props
  List<Object> get props => ["confirming"];
}
class ApprovedDeliveryState extends DeliveryState {
  @override
  // TODO: implement props
  List<Object> get props => ["approved"];
}

class RejectedDeliveryState extends DeliveryState {
  final String message;

  @override
  // TODO: implement props
  List<Object> get props => [message];

  RejectedDeliveryState(this.message);
}

class DeliveryErrorState extends DeliveryState {
  final String message;

  @override
  // TODO: implement props
  List<Object> get props => [message];

  DeliveryErrorState(this.message);
}

class LoadedDeliveryState extends DeliveryState {
  final Wilaya wilaya;
  final List<Commune> deliveryLocations;
  final Commune selectedCommune;
  final DeliveryZone selectedZone;
  final DeliveryTime deliveryTime;
  final double zonePrice;
  final double timePrice;
  LoadedDeliveryState(this.wilaya, this.deliveryLocations,
      {this.selectedCommune,this.deliveryTime, this.selectedZone, this.zonePrice, this.timePrice});

  @override
  // TODO: implement props
  List<Object> get props => [selectedZone, deliveryTime];
}

class DeliveryCubit extends Cubit<DeliveryState> {
  final AuthenticationBloc _authenticationBloc;
  final CartBloc _cartBloc;
  final DeliveryRepository _deliveryRepository;
  final OrderRepository _orderRepository;

  DeliveryCubit(AuthenticationBloc authenticationBloc, CartBloc cartBloc,
      DeliveryRepository deliveryRepository,OrderRepository orderRepository)
      : this._authenticationBloc = authenticationBloc,
        this._cartBloc = cartBloc,
        this._deliveryRepository = deliveryRepository,
        this._orderRepository =  orderRepository,
        super(InitialDeliveryState()) {
    _init();
  }

  void _init() async {
    emit(LoadingDeliveryState());
    final authState = _authenticationBloc.state;
    if (authState is AuthenticationAuthenticated) {
      final userWilaya = authState.user.wilaya;
      print(userWilaya);
      final communesData = await _deliveryRepository.getDeliveryLocationDataOfWilaya(userWilaya) ?? [];
      final communes = communesData.takeWhile((commune) =>commune.zones.length != 0 ).toList();
      if(communes.isNotEmpty) {
        final firstCommune = communes.first;
        final zones = firstCommune.zones;
        print(zones);
        final firstZone = zones.first;
        final deliveryTime = DeliveryTime(DateTime.now());
        math.Random rand = math.Random();
        final loadedState = LoadedDeliveryState(userWilaya,communes,
            deliveryTime: deliveryTime,
            selectedCommune: firstCommune,
            selectedZone: firstZone,
            zonePrice: rand.nextDouble()*100,
            timePrice: rand.nextDouble()*100);
        emit(loadedState);
      }

    }
  }
  void setSelectedCommune(Commune commune) {
    final state = this.state as LoadedDeliveryState;
    print(commune);
    final firstZone = commune.zones[0];
    ///TODO : get price of this zone;
    math.Random rand = math.Random();
    emit(LoadedDeliveryState(state.wilaya, state.deliveryLocations,
        selectedCommune: commune,
        deliveryTime: state.deliveryTime,
        selectedZone: firstZone,
        zonePrice: rand.nextDouble()*100,
        timePrice: rand.nextDouble()*100));
  }
  void setDeliveryZone(DeliveryZone zone) async {
    final state = this.state as LoadedDeliveryState;
    print(zone);
    math.Random rand = math.Random();
    emit(LoadedDeliveryState(state.wilaya, state.deliveryLocations,
        selectedCommune: state.selectedCommune,
        deliveryTime: state.deliveryTime,
        selectedZone: zone,
        zonePrice: rand.nextDouble()*100,
        timePrice: rand.nextDouble()*100));
  }
  void setDeliveryTime(DeliveryTime time) async {
    final state = this.state as LoadedDeliveryState;
    print(time);
    math.Random rand = math.Random();
    emit(LoadedDeliveryState(state.wilaya,state.deliveryLocations,
        deliveryTime: time,
        selectedZone: state.selectedZone,
        selectedCommune:  state.selectedCommune,
        zonePrice: rand.nextDouble()*100,
        timePrice: rand.nextDouble()*100));
  }

  void confirmDelivery() async{

    print("confirming delivery");
    final cart = (this._cartBloc.state as LoadedCartState).cart;
    final state = this.state as LoadedDeliveryState;
    final authState = _authenticationBloc.state;
    if(authState is AuthenticationAuthenticated) {
      User user =  authState.user;
      DeliveryLocation location = DeliveryLocation(wilaya:user.wilaya,zone: state.selectedZone );
      await this._orderRepository.createNewOrder(user, cart,location,state.deliveryTime );
      emit(ApprovedDeliveryState());
    }

  }
  Future<void> resetDelivery() async {
    /// we tell the cart to clear
    _cartBloc.add(CartCleared());
    /// we reinitialize the delivery state to starting data
    _init();
  }
}
