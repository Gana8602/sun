import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../utils/TextStyles.dart';
import '../models/Media.dart';
import '../i18n/strings.g.dart';
import '../providers/AudioScreensModel.dart';
import '../screens/NoitemScreen.dart';
import '../widgets/MediaItemTile.dart';

class AudioScreen extends StatefulWidget {
  AudioScreen(this.title);
  final String title;

  @override
  MediaScreenRouteState createState() => new MediaScreenRouteState();
}

class MediaScreenRouteState extends State<AudioScreen> {
  late AudioScreensModel mediaScreensModel;
  List<Media>? items;

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
      Provider.of<AudioScreensModel>(context, listen: false).loadItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    mediaScreensModel = Provider.of<AudioScreensModel>(context);
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
      child: (mediaScreensModel.isError == true && items!.length == 0)
          ? NoitemScreen(
              title: t.oops, message: t.dataloaderror, onClick: _onRefresh)
          : ListView.builder(
              itemCount: items!.length + 1,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(3),
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 10, 15),
                      child: Text(widget.title,
                          style: TextStyles.headline(context).copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          )),
                    ),
                  );
                } else {
                  int _indx = index - 1;
                  return ItemTile(
                    mediaList: items!,
                    index: _indx,
                    object: items![_indx],
                  );
                }
              },
            ),
    );
  }
}
