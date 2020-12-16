import 'package:restaurant_rlutter_ui/src/business_logic/datasources/delivery_datasource.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/cart.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/common/wilaya.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/delivery.dart';

abstract class DeliveryRepository {
  Future<List<Commune>> getDeliveryLocationDataOfWilaya(Wilaya wilaya);

  Future<List<Commune>> getCommunesOfWilaya(Wilaya wilaya);

  Future<List<DeliveryZone>> getDeliveryZonesOfWilaya(Wilaya wilaya);

  Future<List<Wilaya>> getDeliveryWilayas();

  Future<DeliveryDataResult> getDeliveryPrice(
      DeliveryLocation location, DeliveryTime time, Cart cart);
}

class DeliveryRepositoryImpl extends DeliveryRepository {
  final RemoteDeliveryDataSource remoteDeliveryDataSource;

  DeliveryRepositoryImpl({this.remoteDeliveryDataSource})
      : assert(remoteDeliveryDataSource != null);

  @override
  Future<List<Commune>> getCommunesOfWilaya(Wilaya wilaya) async {
    return this.remoteDeliveryDataSource.getDeliveryDataOfWilaya(wilaya.code);
  }

  @override
  Future<List<Commune>> getDeliveryLocationDataOfWilaya(Wilaya wilaya) {
    return remoteDeliveryDataSource.getDeliveryDataOfWilaya(wilaya.code);
  }

  @override
  Future<DeliveryDataResult> getDeliveryPrice(
      DeliveryLocation location, DeliveryTime time, Cart cart) async {
    List<MenuPriceParam> menus = cart.orderList
        .items()
        .map<MenuPriceParam>(
            (order) => MenuPriceParam.fromOrder(order))
        .toList();
    try {
      final data = await  this.remoteDeliveryDataSource.getDeliveryPrice(DeliveryPriceParams(
          zoneId: location.zone.id, timestamps: time.dateTime, menus: menus));
      return data;
    }
    catch (e) {
       return DeliveryDataResult(delivery_fee: -1,order_fee: -1,discount: -1);
    }

  }

  @override
  Future<List<Wilaya>> getDeliveryWilayas() {
    // TODO: implement getDeliveryWilayas
    throw UnimplementedError();
  }

  @override
  Future<List<DeliveryZone>> getDeliveryZonesOfWilaya(Wilaya wilaya) {
    // TODO: implement getDeliveryZonesOfWilaya
    throw UnimplementedError();
  }
}

class MockDeliveryRepository extends DeliveryRepository {
  final mockWilayaData = [
    Wilaya(code: "16", name: "Alger", communes: [
      Commune(id: "1", name: "CommuneAlger1", zones: [
        DeliveryZone(id: "1", name: "vile1"),
        DeliveryZone(id: "2", name: "vile2")
      ]),
      Commune(id: "2", name: "CommuneAlger2", zones: [
        DeliveryZone(id: "3", name: "vile3"),
        DeliveryZone(id: "4", name: "vile4")
      ])
    ]),
    Wilaya(code: "15", name: "Tizi Ouzou", communes: [
      Commune(id: "3", name: "CommuneTizi1", zones: [
        DeliveryZone(id: "5", name: "vile5"),
        DeliveryZone(id: "6", name: "vile6")
      ]),
      Commune(id: "4", name: "CommuneTizi2", zones: [
        DeliveryZone(id: "7", name: "vile7"),
        DeliveryZone(id: "8", name: "vile8")
      ])
    ])
  ];
  static Map<Wilaya, List<DeliveryZone>> mockZones;

  MockDeliveryRepository() {
    mockZones = new Map<Wilaya, List<DeliveryZone>>();
    mockZones.putIfAbsent(
        mockWilayaData[0],
        () => [
              DeliveryZone(id: "1", name: "vile01"),
              DeliveryZone(id: "2", name: "vile02")
            ]);
    mockZones.putIfAbsent(
        mockWilayaData[1],
        () => [
              DeliveryZone(id: "3", name: "vile13"),
              DeliveryZone(id: "4", name: "vile14")
            ]);
  }

  @override
  Future<DeliveryDataResult> getDeliveryPrice(
      DeliveryLocation location, DeliveryTime time, Cart cart) async {
    return null;
  }

  @override
  Future<List<Wilaya>> getDeliveryWilayas() async {
    return mockWilayaData;
  }

  @override
  Future<List<DeliveryZone>> getDeliveryZonesOfWilaya(Wilaya wilaya) async {
    return mockZones[wilaya];
  }

  @override
  Future<List<Commune>> getCommunesOfWilaya(Wilaya wilaya) async {
    List<Commune> communes = mockWilayaData
        .firstWhere((element) => element == wilaya,
            orElse: () => Wilaya(communes: []))
        .communes;
    return communes;
  }

  @override
  Future<List<Commune>> getDeliveryLocationDataOfWilaya(Wilaya wilaya) async {
    return mockWilayaData
        .firstWhere((element) => element == wilaya,
            orElse: () => Wilaya(communes: []))
        .communes;
  }
}

class DeliveryDataResult {
  final double delivery_fee;
  final double order_fee;
  final double discount;

  DeliveryDataResult({this.delivery_fee, this.order_fee, this.discount});
}