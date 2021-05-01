import 'package:flutter/material.dart';

class Desktop_AppBar_Custom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey,
      toolbarHeight: 75,
      centerTitle: true,
      title:Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1000),
          child:  Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Text("CJP"),
                    Text("Centro De Ajuto Ha População"),
                  ],
                ),
              ),
              Expanded(child: Icon(Icons.add,))
            ],
          ),
        ),
      ),
      elevation: 3,
    );
  }
}
