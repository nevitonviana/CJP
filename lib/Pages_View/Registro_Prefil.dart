import 'package:cjp/Route.dart';
import 'package:cjp/WidgetCustom/TexteField/CustomTextField.dart';
import 'package:flutter/material.dart';

class Registro_Prefil extends StatefulWidget {
  @override
  _Registro_PrefilState createState() => _Registro_PrefilState();
}

class _Registro_PrefilState extends State<Registro_Prefil> {
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
                    child: Text("Cadastro"),
                  ),
                  CustomtextField(
                    hintText: "Nome Completo",
                    icon: Icon(Icons.account_box_outlined),
                  ),
                  CustomtextField(
                    hintText: "Bairro",
                    icon: Icon(Icons.location_city_outlined),
                  ),
                  CustomtextField(
                    hintText: "Cidade",
                    icon: Icon(Icons.location_city_sharp),
                  ),
                  CustomtextField(
                    hintText: "E-Mail",
                    icon: Icon(Icons.mail_outline_sharp),
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
                    onPressed: () => Navigator.pushNamedAndRemoveUntil(
                        context, RouteGererator.rota_Home, (route) => false),
                    elevation: 3,
                    color: Colors.cyan,
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Text("Entra"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
