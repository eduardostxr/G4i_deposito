import 'package:flutter/material.dart';
import 'package:g4i_deposito/database/database_helper.dart';
import 'package:g4i_deposito/manager/user_manager.dart';

import 'package:g4i_deposito/ui/home/page_home.dart';
import 'package:g4i_deposito/utilitys/app_config.dart';

import '../../models/user_model.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({Key? key}) : super(key: key);

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  final TextEditingController controllerUsuario = TextEditingController();
  final TextEditingController controllerSenha = TextEditingController();
  bool obscureText = true;
  String usuario = '';
  String senha = '';

  List<String> users = [];

// Foi colocado hoje, para quando iniciar a página de login ela carregar os usuários
  @override
  void initState() {
    loadUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: markPrimaryColor,
          title: Center(
            
            child: Text('Granja 4 Irmãos \n Login App Transferência',
                textAlign: TextAlign.center),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),

                  // Card User
                  Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 6,
                      child: TextFormField(
                        controller: controllerUsuario,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.black),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.person,
                            color: markPrimaryColor,
                          ),
                          labelText: 'Usuário',
                          labelStyle:
                              TextStyle(fontSize: 20, color: markPrimaryColor),
                          alignLabelWithHint: false,
                        ),
                      ),
                    ),
                  ),
                  // Termina User

                  SizedBox(
                    height: 40,
                  ),

                  //Card Senha
                  Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 6,
                      child: TextFormField(
                        controller: controllerSenha,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.black),
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: markPrimaryColor,
                          ),
                          labelText: 'Senha',
                          labelStyle:
                              TextStyle(fontSize: 20, color: markPrimaryColor),
                          alignLabelWithHint: false,
                          suffixIcon: IconButton(
                              icon: Icon(
                                Icons.remove_red_eye_outlined,
                                color: markPrimaryColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              }),
                        ),
                      ),
                    ),
                  ),
                  //Termina Senha

                  SizedBox(
                    height: 40,
                  ),
                  // Btn Confirmar
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 107, 107, 107)
                                  .withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          minWidth: MediaQuery.of(context).size.width * 0.9,
                          height: 60,
                          color: markPrimaryColor,
                          child: Text(
                            'Confirmar',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          onPressed: () {


                            login(controllerUsuario.text.trim(),
                                controllerSenha.text.trim());

                          },
                        ),
                      ),
                    ],
                  ),
                  // Termina Confirmar
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  void loadUsers() async {
    users = await DatabaseHelper().selectAllUsers();
    //  u.forEach((element) => users.add(element.email));
  }

  void login(String user, String pass) {
    UserManager().signIn(
      userLogin: user.toUpperCase(),
      password: pass,
      onError: (error) {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(error, textAlign: TextAlign.center),
            backgroundColor: Colors.red));
      },
      onSuccess: (u) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: ((context) => MyHomePage(
                  title: getSaudacaoText(
                      user: (u as UserModel).userName.toUpperCase()),
                  user: u as UserModel,
                ))));
      },
    );

    print('TESTE');
  }
}
