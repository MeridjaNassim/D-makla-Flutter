import 'package:bloc/bloc.dart';
import 'package:dmakla/src/business_logic/blocs/auth/auth.bloc.dart';
import 'package:dmakla/src/business_logic/blocs/auth/auth.state.dart';
import 'package:dmakla/src/business_logic/models/order.dart';
import 'package:dmakla/src/business_logic/models/user.dart';
import 'package:dmakla/src/business_logic/repositories/order_repository.dart';
import 'package:equatable/equatable.dart';
abstract class OrdersState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}
class InitialOrdersState extends OrdersState {

}

class LoadingOrdersState extends OrdersState {

}

class LoadedOrdersState extends OrdersState {
  List<ConfirmedOrder> orders;

  LoadedOrdersState(this.orders);
  @override
  // TODO: implement props
  List<Object> get props => orders;
}
class ErrorOrdersState extends OrdersState {
 final String message;

 ErrorOrdersState(this.message);
  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class OrdersCubit extends Cubit<OrdersState> {
  final AuthenticationBloc _authenticationBloc;
  final OrderRepository _orderRepository;
  OrdersCubit(AuthenticationBloc authenticationBloc, OrderRepository orderRepository) :
        assert(authenticationBloc != null),
        assert(orderRepository != null),
        this._authenticationBloc = authenticationBloc,
      this._orderRepository = orderRepository,
        super(InitialOrdersState());


  Future<void> loadOrders() async{
    print("loading orders");
    emit(LoadingOrdersState());
    AuthenticationAuthenticated authState ;
    /// try to cast authState to authenticated State
    try{
      authState = _authenticationBloc.state;
    }catch (e) {
      emit(ErrorOrdersState("User Not Authenticated"));
      return ;
    }
    /// user is authenticated.

    /// perform the loading of the state.
    try {
      List<ConfirmedOrder> orders = await _loadOrders(authState.user);
      print(orders);
      emit(LoadedOrdersState(orders));
    }catch (e) {
      print(e);
      emit(ErrorOrdersState(e.message.toString()));
    }


  }


  Future<List<ConfirmedOrder>> _loadOrders(User user){
    return _orderRepository.getOrders(user);
    //throw UnimplementedError("implement orders");
  }
}