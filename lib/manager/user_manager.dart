import 'dart:convert';

import 'package:g4i_deposito/database/database_helper.dart';
import 'package:g4i_deposito/models/product_model.dart';
import 'package:g4i_deposito/services/querys/ws_product.dart';
import 'package:g4i_deposito/services/querys/ws_user.dart';
import 'package:g4i_deposito/services/ws_controller.dart';
import 'package:crypto/crypto.dart';

import '../models/user_model.dart';
import '../utilitys/app_config.dart';

class UserManager {
  static DateTime? time;
  static UserModel user = UserModel(
    user: "",
    userId: "",
    userName: "",
  );

  Future<void> signIn({
    required String userLogin,
    required String password,
    required Function onSuccess,
    required Function onError,
  }) async {
    if (userLogin.isEmpty) {
      onError("Informe um usuário válido");
      return;
    }

    if (password.isEmpty) {
      onError("Informe uma senha válida");
      return;
    }

    String passwordToSHA256 = generateMd5(password).toString();

    try {
      if (await WsController.testConnection()) {
        print('TESTE1');
        // usuario no lugar de email
        String json = jsonEncode({
          "codigo": userLogin.toUpperCase(),
          "senha": passwordToSHA256.toUpperCase()
        });

        print(json);

        // MapSD response = jsonUser;
        MapSD response = await WsController().getUserFromWs(json);

        print(response);
        // print(response);
        // print("login online");
        if (response.containsKey("error") ||
            response.containsKey("connection")) {
          onError("Falha na conexão com o webservice");
          return;
        }
        if (response.isEmpty) {
          onError("Usuário não reconhecido");
          return;
        }
        if (!response["login"]) {
          onError("Login não concedido");
          return;
        }
        user = UserModel(
          user: userLogin,
          userId: response["codigo_usuario"],
          userName: response["nome_usuario"],
        );
        print(user.userName);
        await DatabaseHelper().deleteUser(userLogin);
        await DatabaseHelper().insertUserInDb(user);
        onSuccess(user);
      }
    } catch (e) {
      print("Ocorreu um erro inesperado" + e.toString());
      onError("Ocorreu um erro inesperado");
    }
  }

  Future<void> signOut(Function navigate) async {
    user = UserModel(
      user: "",
      userId: "",
      userName: "",
    );
    time = null;
    navigate();
  }

  String generateMd5(String input) {
    var bytes = utf8.encode(input.toUpperCase());
    var md5Hash = md5.convert(bytes);
    return md5Hash.toString();
  }

Future<List<Produto>> loadProducts() async {
  List<Produto> produtos = await WsProdutos().getProdutos();
  produtos.sort((a, b) => a.nome.compareTo(b.nome));
  return produtos;
}

}

