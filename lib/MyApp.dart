import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streamit_flutter/models/Albums.dart';
import 'package:streamit_flutter/models/Artists.dart';
import 'package:streamit_flutter/models/Downloads.dart';
import 'package:streamit_flutter/models/Genres.dart';
import 'package:streamit_flutter/models/Moods.dart';
import 'package:streamit_flutter/models/Playlists.dart';
import './providers/AppStateNotifier.dart';
import './screens/MoodsMediaScreen.dart';
import './screens/MoodsScreen.dart';
import './screens/ArtistProfileScreen.dart';
import './screens/AlbumsMediaScreen.dart';
import './screens/ArtistsScreen.dart';
import './utils/AppTheme.dart';
import './providers/AudioPlayerModel.dart';
import './screens/HomePage.dart';
import './utils/TextStyles.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/cupertino.dart';
import './screens/AddPlaylistScreen.dart';
import './screens/PlaylistMediaScreen.dart';
import './screens/SearchScreen.dart';
import './screens/GenresMediaScreen.dart';
import './screens/MoreScreen.dart';
import './screens/AlbumsScreen.dart';
import './screens/SubscriptionScreen.dart';
import './audio_player/player_page.dart';
import './models/CommentsArguement.dart';
import './comments/CommentsScreen.dart';
import './comments/RepliesScreen.dart';
import './screens/Downloader.dart';
import './auth/LoginScreen.dart';
import './auth/RegisterScreen.dart';
import './auth/ForgotPasswordScreen.dart';
import './models/ScreenArguements.dart';
import './service/Firebase.dart';
import './models/Media.dart';
import './i18n/strings.g.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
    required Widget? defaultHome,
  })  : _defaultHome = defaultHome,
        super(key: key);

  final Widget? _defaultHome;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  AppLifecycleState? state;
  late AppStateNotifier appState;
  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey(debugLabel: "Main Navigator");

  navigateMedia(Media media) {
    print("push notification media = " + media.title!);
    List<Media?> mediaList = [];
    mediaList.add(media);
    Provider.of<AudioPlayerModel>(context, listen: false)
        .preparePlaylist(mediaList, media);
    navigatorKey.currentState!.pushNamed(PlayPage.routeName);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    FirebaseMessage(navigateMedia).init();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    //Provider.of<AudioPlayerModel>(context, listen: false).cleanUpResources();
    super.dispose();
  }

  void didChangeAppLifeCycleState(AppLifecycleState appLifecycleState) {
    state = appLifecycleState;
    print(appLifecycleState);
    print(":::::::");
  }

  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppStateNotifier>(context);
    final platform = Theme.of(context).platform;
    return RefreshConfiguration(
      footerTriggerDistance: 15,
      dragSpeedRatio: 0.91,
      headerBuilder: () => MaterialClassicHeader(),
      footerBuilder: () => ClassicFooter(),
      enableLoadingWhenNoData: false,
      shouldFooterFollowWhenNotFull: (state) {
        // If you want load more with noMoreData state ,may be you should return false
        return false;
      },
      //autoLoad: true,
      child: Directionality(
        textDirection:
            appState.isRtlEnabled! ? TextDirection.rtl : TextDirection.ltr,
        child: MaterialApp(
          navigatorKey: navigatorKey,

          localizationsDelegates: [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
            Locale("en"),
          ],
          locale: appState.isRtlEnabled! ? Locale("fa", "IR") : Locale("en"),
          title: 'App',

          home: appState.isLoadingTheme
              ? Container(
                  child: Center(
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(height: 10),
                          Text(t.appname,
                              style: TextStyles.medium(context).copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30)),
                          Container(height: 12),
                          Text(t.loadingapp,
                              style: TextStyles.body1(context)
                                  .copyWith(color: Colors.grey[500])),
                          Container(height: 50),
                          CupertinoActivityIndicator(
                            radius: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : widget._defaultHome,
          debugShowCheckedModeBanner: false,
          theme: appState.isDarkModeOn!
              ? AppTheme.darkTheme
              : AppTheme.lightTheme, // ThemeData(primarySwatch: Colors.blue),
          darkTheme:
              AppTheme.darkTheme, // ThemeData(primarySwatch: Colors.blue),
          themeMode: appState.isDarkModeOn! ? ThemeMode.dark : ThemeMode.light,
          onGenerateRoute: (settings) {
            if (settings.name == HomePage.routeName) {
              return MaterialPageRoute(
                builder: (context) {
                  return HomePage();
                },
              );
            }

            if (settings.name == AddPlaylistScreen.routeName) {
              // Cast the arguments to the correct type: ScreenArguments.
              final ScreenArguements? args =
                  settings.arguments as ScreenArguements?;
              return MaterialPageRoute(
                builder: (context) {
                  return AddPlaylistScreen(
                    media: args!.items as Media?,
                  );
                },
              );
            }

            if (settings.name == PlaylistMediaScreen.routeName) {
              // Cast the arguments to the correct type: ScreenArguments.
              final ScreenArguements? args =
                  settings.arguments as ScreenArguements?;
              return MaterialPageRoute(
                builder: (context) {
                  return PlaylistMediaScreen(
                    playlists: args!.items as Playlists?,
                  );
                },
              );
            }

            if (settings.name == GenresMediaScreen.routeName) {
              // Cast the arguments to the correct type: ScreenArguments.
              final ScreenArguements? args =
                  settings.arguments as ScreenArguements?;
              return MaterialPageRoute(
                builder: (context) {
                  return GenresMediaScreen(
                    genreList: args!.itemsList as List<Genres>?,
                  );
                },
              );
            }

            if (settings.name == AlbumsMediaScreen.routeName) {
              // Cast the arguments to the correct type: ScreenArguments.
              final ScreenArguements? args =
                  settings.arguments as ScreenArguements?;
              return MaterialPageRoute(
                builder: (context) {
                  return AlbumsMediaScreen(
                    albums: args!.items as Albums?,
                  );
                },
              );
            }

            if (settings.name == MoodsMediaScreen.routeName) {
              // Cast the arguments to the correct type: ScreenArguments.
              final ScreenArguements? args =
                  settings.arguments as ScreenArguements?;
              return MaterialPageRoute(
                builder: (context) {
                  return MoodsMediaScreen(
                    moods: args!.items as Moods?,
                  );
                },
              );
            }

            if (settings.name == ArtistProfileScreen.routeName) {
              // Cast the arguments to the correct type: ScreenArguments.
              final ScreenArguements? args =
                  settings.arguments as ScreenArguements?;
              return MaterialPageRoute(
                builder: (context) {
                  return ArtistProfileScreen(
                    artists: args!.items as Artists?,
                  );
                },
              );
            }

            if (settings.name == SearchScreen.routeName) {
              return MaterialPageRoute(
                builder: (context) {
                  return SearchScreen();
                },
              );
            }

            if (settings.name == MoodsScreen.routeName) {
              return MaterialPageRoute(
                builder: (context) {
                  return MoodsScreen();
                },
              );
            }

            if (settings.name == AlbumsScreen.routeName) {
              return MaterialPageRoute(
                builder: (context) {
                  return AlbumsScreen();
                },
              );
            }

            if (settings.name == ArtistsScreen.routeName) {
              return MaterialPageRoute(
                builder: (context) {
                  return ArtistsScreen();
                },
              );
            }

            if (settings.name == CommentsScreen.routeName) {
              // Cast the arguments to the correct type: ScreenArguments.
              final CommentsArguement? args =
                  settings.arguments as CommentsArguement?;
              return MaterialPageRoute(
                builder: (context) {
                  return CommentsScreen(
                    item: args!.item as Media?,
                    commentCount: args.commentCount,
                  );
                },
              );
            }

            if (settings.name == RepliesScreen.routeName) {
              // Cast the arguments to the correct type: ScreenArguments.
              final CommentsArguement? args =
                  settings.arguments as CommentsArguement?;
              return MaterialPageRoute(
                builder: (context) {
                  return RepliesScreen(
                    item: args!.item,
                    repliesCount: args.commentCount,
                  );
                },
              );
            }

            if (settings.name == LoginScreen.routeName) {
              return MaterialPageRoute(
                builder: (context) {
                  return LoginScreen();
                },
              );
            }

            if (settings.name == RegisterScreen.routeName) {
              return MaterialPageRoute(
                builder: (context) {
                  return RegisterScreen();
                },
              );
            }

            if (settings.name == ForgotPasswordScreen.routeName) {
              return MaterialPageRoute(
                builder: (context) {
                  return ForgotPasswordScreen();
                },
              );
            }

            if (settings.name == PlayPage.routeName) {
              return MaterialPageRoute(
                builder: (context) {
                  return PlayPage();
                },
              );
            }

            if (settings.name == Downloader.routeName) {
              // Cast the arguments to the correct type: ScreenArguments.
              final ScreenArguements? args =
                  settings.arguments as ScreenArguements?;
              return MaterialPageRoute(
                builder: (context) {
                  return Downloader(
                      downloads: args!.items as Downloads?, platform: platform);
                },
              );
            }

            if (settings.name == SubscriptionScreen.routeName) {
              return MaterialPageRoute(
                builder: (context) {
                  return SubscriptionScreen();
                },
              );
            }

            if (settings.name == MoreScreen.routeName) {
              return MaterialPageRoute(
                builder: (context) {
                  return MoreScreen();
                },
              );
            }

            return MaterialPageRoute(
              builder: (context) {
                return HomePage();
              },
            );
          },
        ),
      ),
    );
  }
}
