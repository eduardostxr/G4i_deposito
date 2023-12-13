import 'dart:convert';
import 'package:g4i_deposito/utilitys/app_config.dart';
import 'package:g4i_deposito/database/database_helper.dart';
import 'package:g4i_deposito/services/ws_controller.dart';
import 'package:g4i_deposito/models/movement_model.dart';

class WsMovimentos {
  Future<bool> postMovementOnWs(MovimentoModel movement) async {
    try {
      MapSD jsonMovimento = {
        "retirada": {
          "tipo_operacao": movement.tipo.toUpperCase(),
          "codigo_usuario": movement.usuario,
          "codigo_produto": movement.produto,
          "quantidade": movement.quantidade,
          "data_cadastro": movement.date.toIso8601String(),
          "observacao": movement.observacao,
        }
      };

      print(jsonMovimento);
      // Converte o Map para json e manda para o backend
      MapSD response = await WsController.executeWsPost(
        query: "/deposito/addRetirada", // Pasta para salvar
        body: jsonEncode(jsonMovimento), // Transformando em json
      );

      if (response.containsKey('error') ||
          response.containsKey('connection') ||
          response.isEmpty) {
        return false;
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
