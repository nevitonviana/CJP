import 'package:cjp/Route.dart';
import 'package:cjp/WidgetCustom/CustomTextField.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      color: Color(0xFFF6F1CA),
      child: Center(
        child: Card(
          elevation: 3,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              height: mediaQuery.size.height * 0.7,
              width: 500,
              color: Colors.grey[200],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: Text("Login"),
                  ),
                  CustomtextField(
                    hintText: "Usuario",
                    icon: Icon(Icons.account_circle),
                  ),
                  CustomtextField(
                    hintText: "Senha",
                    icon: Icon(Icons.lock_outlined),
                  ),
                  RaisedButton(
                    onPressed: () => Navigator.pushReplacementNamed(
                        context, RouteGererator.rota_Home),
                    elevation: 3,
                    color: Colors.cyan,
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Text("Entra"),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, RouteGererator.rota_Registro),
                    child: Text("Cadastra-se"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
