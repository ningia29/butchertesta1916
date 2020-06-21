import 'package:butchertesta1916/src/models/client.dart';
import 'package:butchertesta1916/src/providers/client.dart';
import 'package:flutter/material.dart';
import 'package:butchertesta1916/src/helpers/screen_navigation.dart';
import 'package:butchertesta1916/src/helpers/style.dart';
import 'package:butchertesta1916/src/models/product.dart';
import 'package:butchertesta1916/src/providers/product.dart';
import 'package:butchertesta1916/src/providers/restaurant.dart';
import 'package:butchertesta1916/src/screens/restaurant.dart';
import 'package:provider/provider.dart';

import 'custom_text.dart';

class ClientWidget extends StatelessWidget {
  final ClientModel client;

  const ClientWidget({Key key, this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientProvider>(context);
    print("============ sono in clientwidget valore di clientprovier $clientProvider ===============");
    print("============ sono in clientwidget valore di client ${client.lastName} ===============");

    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 4),
      child: Card(
        color: Colors.grey[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 5.0,
        child: ListTile(
          title: CustomText(text: client.lastName, weight: FontWeight.bold,),
          subtitle: CustomText(text: client.name,)
        ),
      ),
    );
  }
}
