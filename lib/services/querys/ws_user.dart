
import 'package:g4i_deposito/services/ws_controller.dart';
import 'package:g4i_deposito/utilitys/app_config.dart';


class WsUser {

  Future<MapSD> getUserFromWs (String body) async {
    try {
      MapSD response = await WsController.executeWsPost(query: "/deposito/login", body: body); //body é email e senha.
      return response;
    }catch(e){
      print("ERRO GET USER FROM WS");
      return {};
    }
  }
}