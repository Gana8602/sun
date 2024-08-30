import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:streamit_flutter/i18n/strings.g.dart';
import 'MyApp.dart';
import './providers/AppStateNotifier.dart';
import 'package:provider/provider.dart';
import './providers/BookmarksModel.dart';
import './providers/PlaylistsModel.dart';
import './providers/AudioPlayerModel.dart';
import './providers/DownloadsModel.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import './providers/SubscriptionModel.dart';
import 'package:firebase_core/firebase_core.dart';
import './screens/HomePage.dart';
import './screens/OnboardingPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //FacebookSdk.sdkInitialize();
  LocaleSettings.useDeviceLocale();
  MobileAds.instance.initialize();
  //await Admob.requestTrackingAuthorization(); #uncomment out for IOS
  await Firebase.initializeApp();
  await FlutterDownloader.initialize(debug: true);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  Future<Widget> getFirstScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("user_seen_onboarding_page") == null ||
        prefs.getBool("user_seen_onboarding_page") == false) {
      return new OnboardingPage();
    } else {
      return HomePage();
    }
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppStateNotifier()),
        ChangeNotifierProvider(create: (_) => BookmarksModel()),
        ChangeNotifierProvider(create: (_) => PlaylistsModel()),
        ChangeNotifierProvider(create: (_) => AudioPlayerModel()),
        ChangeNotifierProvider(create: (_) => DownloadsModel()),
        ChangeNotifierProvider(create: (_) => SubscriptionModel()),
      ],
      child: FutureBuilder<Widget>(
          future: getFirstScreen(), //returns bool
          builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return MyApp(defaultHome: snapshot.data);
            } else {
              return Center(child: CupertinoActivityIndicator());
            }
          }),
    ),
  );
}
