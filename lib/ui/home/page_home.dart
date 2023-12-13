// MyHomePage

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:g4i_deposito/manager/user_manager.dart';
import 'package:g4i_deposito/models/product_model.dart';
import 'package:g4i_deposito/services/querys/ws_product.dart';
import 'package:g4i_deposito/ui/home/components/app_bar_home.dart';
import 'package:g4i_deposito/ui/home/components/card_home_enabled.dart';
import 'package:g4i_deposito/ui/login/page_login.dart';
import 'package:g4i_deposito/ui/transfer/page_transfere_produto.dart';
import 'package:g4i_deposito/utilitys/app_config.dart';

import '../../models/user_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.user})
      : super(key: key);
  final String title;
  final UserModel user;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Produto> produtos = [];
  bool isLoading = false;

  @override
  void initState() {
    // loadData();
    super.initState();
  }

  // Future<void> loadData() async {
  //   isLoading = true;
  //   setState(() {});
  //   await UserManager().loadProducts();
  //   isLoading = false;
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(height(context), widget.title),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: markPrimaryColor,
            ))
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        childAspectRatio: 1.2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          CardHomeEnabled(
                            Icons.outbox,
                            "Retirada",
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => PageTranfereProduto(
                                        userName: widget.user.userName,
                                        transferType: "Retirada",
                                        userId: widget.user.userId,
                                      )),
                                ),
                              );
                            },
                          ),
                          CardHomeEnabled(
                            Icons.move_to_inbox,
                            "Retorno",
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => PageTranfereProduto(
                                      userName: widget.user.userName,
                                      transferType: "Retorno",
                                      userId: widget.user.userId)),
                                ),
                              );
                            },
                          ),
                          CardHomeEnabled(
                            Icons.logout,
                            "Sair",
                            () {
                              UserManager().signOut(() {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PageLogin(),
                                  ),
                                );
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
