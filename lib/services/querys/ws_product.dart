import 'package:g4i_deposito/models/product_model.dart';
import 'package:g4i_deposito/services/ws_controller.dart';
import 'package:g4i_deposito/utilitys/app_config.dart';

// Temporariamente comentado para não dar erro!
class WsProdutos {
  Future<List<Produto>> getProdutos() async {
    List<Produto> produtos = [];

    try {
      MapSD response = await WsController.executeWsPost(
          query: "/deposito/getProdutos", timeout: const Duration(minutes: 3));
      if (response.containsKey('error') ||
          response.containsKey('connection') ||
          response.isEmpty) return [];
      response["produtos"].forEach((element) {
        produtos.add(Produto.fromJson(element));
      });
      return produtos;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
