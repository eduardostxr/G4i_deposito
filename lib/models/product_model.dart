import 'package:g4i_deposito/utilitys/app_config.dart';

class Produto {
  String codProduto;
  String nome;
  String unidade;
  String grupo;

  Produto({
    required this.codProduto,
    required this.nome,
    required this.unidade,
    required this.grupo,
  });
  static Produto fromJson(MapSD jsonProduto) {
    return Produto(
        codProduto: jsonProduto["codigo_produto"],
        nome: jsonProduto["nome_produto"],
        unidade: jsonProduto["unidade_produto"],
        grupo: jsonProduto["grupo_material"]);
  }
}
