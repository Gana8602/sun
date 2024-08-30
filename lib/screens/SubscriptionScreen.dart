import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Userdata.dart';
import '../providers/SubscriptionModel.dart';
import '../providers/AppStateNotifier.dart';
import '../i18n/strings.g.dart';

class SubscriptionScreen extends StatefulWidget {
  static const routeName = "/subscriptionscreen";
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<SubscriptionScreen> {
  SubscriptionModel? subscriptionModel;

  @override
  Widget build(BuildContext context) {
    subscriptionModel = Provider.of<SubscriptionModel>(context);
    Userdata? userdata = Provider.of<AppStateNotifier>(context).userdata;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.subscriptions),
      ),
      body: Stack(
          //children: Container(),
          ),
    );
  }
}
