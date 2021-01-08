import 'package:dmakla/src/business_logic/blocs/orders/orders.cubit.dart';
import 'package:dmakla/src/views/elements/common/loading.dart';
import 'package:dmakla/src/views/elements/common/widgets.dart';
import 'package:dmakla/src/views/utils/connectivity_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dmakla/src/views/elements/OrderItemWidget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:octo_image/octo_image.dart';
import 'package:dmakla/src/core/connectivity.dart';

class OrdersWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          return _refreshOrders(context);
        },
        child: BlocListener<ConnectivityCubit, ConnectivityState>(
          listener: (context, state) {
            if (!state.isConnected) {
              showConnectivityWidget(context, () {});
            } else {
              Navigator.of(context).pop();
              _refreshOrders(context);
            }
          },
          child: BlocBuilder<OrdersCubit, OrdersState>(
            builder: (context, state) {
              if (state is LoadingOrdersState) {
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    height: MediaQuery.of(context).size.height - 160,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Center(
                          child: LoadingIndicator(
                            loadingText: "chargement commandes récentes",
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
              if (state is ErrorOrdersState) {
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    height: MediaQuery.of(context).size.height - 160,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                            height: 160,
                            width: 160,
                            child: OctoImage(
                                fit: BoxFit.cover,
                                image: FAILED_TO_LOAD_FOOD_IMAGE)),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                            child: Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.body2,
                        ))
                      ],
                    ),
                  ),
                );
              }
              if (state is LoadedOrdersState)
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        primary: false,
                        itemCount: state.orders.length,
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 10);
                        },
                        itemBuilder: (context, index) {
                          return OrderItemWidget(
                              heroTag: 'my_orders',
                              order: state.orders.elementAt(index));
                        },
                      ),
                    ],
                  ),
                );
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Future<void> _refreshOrders(BuildContext context) {
    print("refreshing orders");
    return BlocProvider.of<OrdersCubit>(context).loadOrders();
  }
}
