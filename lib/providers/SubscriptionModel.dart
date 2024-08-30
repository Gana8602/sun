import 'package:flutter/foundation.dart';

class SubscriptionModel with ChangeNotifier {
  bool isAvailable = false;
  bool purchasePending = false;
  bool loading = true;
  String? queryProductError;
  bool isSubscribed = false;

  SubscriptionModel() {
    //initInAppPurchases();
  }
}
