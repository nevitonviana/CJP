import 'package:cjp/Firebase/Firebase_Instance.dart';
import 'package:cjp/Route.dart';
import 'package:flutter/material.dart';

class Desktop_AppBar_Custom extends StatefulWidget {
  @override
  _Desktop_AppBar_CustomState createState() => _Desktop_AppBar_CustomState();
}

class _Desktop_AppBar_CustomState extends State<Desktop_AppBar_Custom> {
  bool admin = false;

  _verificarserEAdmin() async {
    bool _admin = await getDoUsuario().Admin();
    setState(() {
      admin = _admin;
    });
  }

  @override
  void initState() {
    _verificarserEAdmin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey,
      toolbarHeight: 75,
      centerTitle: true,
      title: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1000),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: GestureDetector(
                      onTap: ()=>Navigator.pushReplacementNamed(context, RouteGererator.rota_Home),
                      child: Column(
                        children: [
                          Text("CJP"),
                          Text("Centro De Ajuda à População"),
                        ],
                      ),
                    ),
                  ),
                  admin
                      ? Container()
                      : Expanded(
                          flex: 3,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              constraints.maxWidth > 810
                                  ? Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context,
                                              RouteGererator
                                                  .rote_minhas_ocorencias);
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.assignment_outlined,
                                              color: Colors.black87,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Minhas ocorrencias",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => Navigator.pushNamed(context,
                                      RouteGererator.rote_Adicionar_corencias),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.assignment,
                                        color: Colors.black87,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Registra Ocorrencia",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            );
          },
        ),
      ),
      elevation: 3,
    );
  }
}
