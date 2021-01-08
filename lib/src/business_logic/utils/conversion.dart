import 'package:dmakla/src/business_logic/utils/constants/wilaya.dart';


String convertWilayaStringToCode(String wilaya) => WILAYA_MAP.keys.firstWhere((element) => WILAYA_MAP[element] == wilaya,orElse: ()=> null);

String formatPhoneNumberToLocal(String phoneNumber) => phoneNumber.startsWith("0") ? phoneNumber.trim() : ("0"+phoneNumber).trim();