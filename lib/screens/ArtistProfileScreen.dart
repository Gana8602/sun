import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streamit_flutter/providers/AppStateNotifier.dart';
import '../models/Albums.dart';
import '../models/ScreenArguements.dart';
import '../screens/AlbumsMediaScreen.dart';
import '../utils/Utility.dart';
import '../utils/my_colors.dart';
import '../models/Artists.dart';
import '../i18n/strings.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../models/Media.dart';
import '../providers/ArtistsMediaModel.dart';
import '../providers/ArtistsAlbumsModel.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/MediaItemTile.dart';
import '../screens/NoitemScreen.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ArtistProfileScreen extends StatelessWidget {
  static const routeName = "/ArtistProfileScreen";
  ArtistProfileScreen({this.artists});
  final Artists? artists;

  @override
  Widget build(BuildContext context) {
    AppStateNotifier appStateNotifier = Provider.of<AppStateNotifier>(context);
    return SafeArea(
      child: Scaffold(
        body: DefaultTabController(
          length: 2, // length of tabs
          initialIndex: 0,
          child: Container(
            // decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: <Widget>[
                Stack(
                  children: [
                    ShapeOfView(
                      elevation: 4,
                      height: 250,
                      shape: ArcShape(
                          direction: ArcDirection.Outside,
                          height: 20,
                          position: ArcPosition.Bottom),
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl: artists!.thumbnail!,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                        Colors.black45, BlendMode.darken)),
                              ),
                            ),
                            placeholder: (context, url) =>
                                Center(child: CupertinoActivityIndicator()),
                            errorWidget: (context, url, error) => Center(
                                child: Icon(
                              Icons.error,
                              color: Colors.grey,
                            )),
                          ),
                          Positioned(
                            right: 10,
                            left: 15,
                            top: 180,
                            child: Padding(
                              padding: EdgeInsets.only(left: 16, top: 0.0),
                              child: Text(
                                artists!.title!,
                                maxLines: 1,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 18,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black,
                                          blurRadius: 1,
                                          offset: Offset(1, 1)),
                                    ]),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 0, top: 10),
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.keyboard_arrow_left,
                            color: Colors.white,
                            size: 40,
                          )),
                    ),
                  ],
                ),
                Container(
                  child: TabBar(
                    indicatorColor: MyColors.accent,
                    labelColor: MyColors.accent,
                    unselectedLabelColor: appStateNotifier.isDarkModeOn!
                        ? Colors.white
                        : Colors.black,
                    tabs: [
                      Tab(
                          text: t.audiotracks +
                              " (" +
                              artists!.mediaCount.toString() +
                              ")"),
                      Tab(
                          text: t.albums +
                              " (" +
                              artists!.albumCount.toString() +
                              ")"),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(0),
                    child: TabBarView(children: [
                      ChangeNotifierProvider(
                        create: (context) => new ArtistsMediaModel(artists),
                        child: MediaScreen(),
                      ),
                      ChangeNotifierProvider(
                        create: (context) => new ArtistsAlbumsModel(artists),
                        child: ArtistAlbumsScreen(),
                      ),
                    ]),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MediaScreen extends StatefulWidget {
  MediaScreen();

  @override
  _CategoriesMediaScreenState createState() => _CategoriesMediaScreenState();
}

class _CategoriesMediaScreenState extends State<MediaScreen>
    with AutomaticKeepAliveClientMixin {
  late ArtistsMediaModel mediaScreensModel;
  late List<Media> items;

  @override
  bool get wantKeepAlive => true;

  void _onRefresh() async {
    mediaScreensModel.loadItems();
  }

  void _onLoading() async {
    mediaScreensModel.loadMoreItems();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 0), () {
      Provider.of<ArtistsMediaModel>(context, listen: false).loadItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    mediaScreensModel = Provider.of<ArtistsMediaModel>(context);
    items = mediaScreensModel.mediaList;

    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text(t.pulluploadmore);
          } else if (mode == LoadStatus.loading) {
            body = CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text(t.loadfailedretry);
          } else if (mode == LoadStatus.canLoading) {
            body = Text(t.releaseloadmore);
          } else {
            body = Text(t.nomoredata);
          }
          return Container(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      controller: mediaScreensModel.refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: (mediaScreensModel.isError == true && items.length == 0)
          ? NoitemScreen(
              title: t.oops, message: t.dataloaderror, onClick: _onRefresh)
          : ListView.builder(
              itemCount: items.length,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(3),
              itemBuilder: (BuildContext context, int index) {
                return ItemTile(
                  mediaList: items,
                  index: index,
                  object: items[index],
                );
              },
            ),
    );
  }
}

class ArtistAlbumsScreen extends StatefulWidget {
  ArtistAlbumsScreen();

  @override
  _AlbumsScreenState createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<ArtistAlbumsScreen>
    with AutomaticKeepAliveClientMixin {
  late ArtistsAlbumsModel mediaScreensModel;
  late List<Albums> items;

  void _onRefresh() async {
    mediaScreensModel.loadItems();
  }

  void _onLoading() async {
    mediaScreensModel.loadMoreItems();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 0), () {
      Provider.of<ArtistsAlbumsModel>(context, listen: false).loadItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    mediaScreensModel = Provider.of<ArtistsAlbumsModel>(context);
    items = mediaScreensModel.albumsList;

    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text(t.pulluploadmore);
          } else if (mode == LoadStatus.loading) {
            body = CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text(t.loadfailedretry);
          } else if (mode == LoadStatus.canLoading) {
            body = Text(t.releaseloadmore);
          } else {
            body = Text(t.nomoredata);
          }
          return Container(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      controller: mediaScreensModel.refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: (mediaScreensModel.isError == true && items.length == 0)
          ? NoitemScreen(
              title: t.oops, message: t.dataloaderror, onClick: _onRefresh)
          : GridView.builder(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(3),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2.0,
                  mainAxisSpacing: 0.0,
                  childAspectRatio: 1.1),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return AlbumTile(
                  index: index,
                  albums: items[index],
                );
              },
            ),
    );
  }
}

class AlbumTile extends StatelessWidget {
  final Albums albums;
  final int index;

  const AlbumTile({
    Key? key,
    required this.index,
    required this.albums,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: InkWell(
        child: Container(
          // height: 200.0,
          width: 120.0,
          child: Column(
            children: <Widget>[
              Container(
                height: 120,
                //margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    // height: 180,
                    imageUrl: albums.thumbnail!,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>
                        Center(child: CupertinoActivityIndicator()),
                    errorWidget: (context, url, error) => Center(
                        child: Icon(
                      Icons.error,
                      color: Colors.grey,
                    )),
                  ),
                ),
              ),
              SizedBox(height: 7.0),
              Container(
                alignment: Alignment.center,
                child: Text(
                  albums.title!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 3.0),
              Container(
                alignment: Alignment.center,
                child: Text(
                  Utility.formatNumber(albums.mediaCount) + " " + t.tracks,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                    color: Colors.blueGrey[300],
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            AlbumsMediaScreen.routeName,
            arguments: ScreenArguements(position: 0, items: albums),
          );
        },
      ),
    );
  }
}
