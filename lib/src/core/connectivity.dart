import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:equatable/equatable.dart';

class ConnectivityState extends Equatable {
  final bool isConnected;
  ConnectivityState(this.isConnected);
  @override
  // TODO: implement props
  List<Object> get props => [isConnected];
}

class ConnectivityCubit extends Cubit<ConnectivityState> {
  StreamSubscription listener;
  ConnectivityCubit(bool connectivityState)
      : super(ConnectivityState(connectivityState)) {
    initListener();
  }
  void setConnectivityState(bool state) {
    emit(ConnectivityState(state));
  }

  @override
  Future<void> close() {
    // TODO: implement close
    listener.cancel();
    return super.close();
  }

  void initListener() {
    listener = DataConnectionChecker().onStatusChange.listen((status) async {
      switch (status) {
        case DataConnectionStatus.connected:
          //print("connected");
          setConnectivityState(true);
          break;
        case DataConnectionStatus.disconnected:
          //print("disconnected");
          setConnectivityState(false);
          break;
      }
    });
  }
}
