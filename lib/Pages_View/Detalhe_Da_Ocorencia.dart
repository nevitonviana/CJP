import 'package:cjp/BreakPoints.dart';
import 'package:cjp/WidgetCustom/AppBar/Mobile_AppBar.dart';
import 'package:cjp/WidgetCustom/AppBar/Web_AppBar.dart';
import 'package:flutter/material.dart';

class Detalhe_Da_Ocorencia extends StatefulWidget {
  @override
  _Detalhe_Da_OcorenciaState createState() => _Detalhe_Da_OcorenciaState();
}

class _Detalhe_Da_OcorenciaState extends State<Detalhe_Da_Ocorencia> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: constraints.maxWidth < mobile_breakPoint
            ? PreferredSize(
                preferredSize: Size(double.infinity, 56),
                child: Mobile_AppBar_Custom())
            : PreferredSize(
                child: Desktop_AppBar_Custom(),
                preferredSize: Size(double.infinity, 72)),
        body: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1000),
            child: Container(
              padding: EdgeInsets.fromLTRB(15, 50, 15, 0),
              color: Colors.grey[200],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 210,
                    child: ListView.separated(
                        padding: EdgeInsets.only(left: 5),
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (_, __) => const SizedBox(
                              width: 16,
                            ),
                        itemCount: 15,
                        itemBuilder: (_, index) => Container(
                              width: 150,
                              color: Colors.amber,
                            )),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text("Cidade:"),
                          subtitle: Text("São Sebastião"),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text("Bairro:"),
                          subtitle: Text("Boiçucaga"),
                        ),
                      ),
                    ],
                  ),
                  ListTile(
                    minVerticalPadding: 10,
                    title: Text("Descrição:"),
                    subtitle: Text(
                        "Texte, atenta às mudanças, é uma empresa que se caracteriza por seu espírito inovador. Agilidade e busca pela melhoria contínua dos serviços prestados são ..."),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
