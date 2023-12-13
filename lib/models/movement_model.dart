import 'package:g4i_deposito/utilitys/app_config.dart';

class MovimentoModel {
  String produto;
  String tipo;
  double quantidade;
  String? observacao;
  DateTime date;
  String usuario;

  MovimentoModel({
    required this.tipo,
    required this.usuario,
    required this.produto,
    required this.quantidade,
    required this.date,
    this.observacao,
  });

  static MapSD toJson(MovimentoModel movimento) {
    return {
      "codigo_produto": movimento.produto,
      "tipo_operacao": movimento.tipo,
      "quantidade": movimento.quantidade,
      "observacao": movimento.observacao,
      "data_cadastro": movimento.date,
      "codigo_usuario": movimento.usuario,
    };
  }
}
