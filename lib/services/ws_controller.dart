import 'dart:async';
import 'dart:convert';

import 'package:g4i_deposito/services/querys/ws_movement.dart';
import 'package:g4i_deposito/services/querys/ws_product.dart';
import 'package:g4i_deposito/services/querys/ws_user.dart';
import 'package:g4i_deposito/utilitys/app_config.dart';
import 'package:http/http.dart' as http;

class WsController with WsMovimentos, WsUser, WsProdutos {
  static final WsController _singleton = WsController._internal();
  factory WsController() => _singleton;

  WsController._internal();

  static String url = 'http://18.224.161.67:9000';

  static Uri toUri(String query) => Uri().resolve(url + query);

  static Future<bool> testConnection() async {
    MapSD response = await executeWsPost(query: "/auth/ping");
    print(response);
    if (response["ping"] == "pong") {
      return true;
    } else {
      print("FALHA NA CONEXÃO");
      return false;
    }
  }

  static Future<MapSD> executeWsPost(
      {required String query,
      String body = '',
      Duration timeout = const Duration(seconds: 15)}) async {
    String returnValue = "";
    MapSD returnJson = {};
    try {
      await http
          .post(
            toUri(query),
            body: body,
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
            },
          )
          .timeout(timeout)
          .then((response) {
            returnValue = utf8.decode(response.bodyBytes);
          });
    } on TimeoutException catch (e) {
      print('connection: ${e.toString()}');
      return {'connection': e.toString()};
    } catch (e) {
      print(e.toString());
      return {'error': e.toString()};
    }

    returnJson = json.decode(returnValue);
    return returnJson;
  }
}
