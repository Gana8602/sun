import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../screens/AudioListPage.dart';
import '../screens/TrendingListPage.dart';
import '../providers/AudioPlayerModel.dart';
import '../utils/TextStyles.dart';
import '../models/Media.dart';
import '../widgets/MediaPopupMenu.dart';
import '../i18n/strings.g.dart';
import '../audio_player/player_page.dart';
import '../providers/SubscriptionModel.dart';
import '../utils/Utility.dart';
import '../utils/Alerts.dart';

class MediaListView extends StatelessWidget {
  MediaListView(this.mediaList, this.header, this.subHeader);
  final List<Media>? mediaList;
  final String header;
  final String subHeader;

  Widget _buildItems(BuildContext context, int index) {
    var media = mediaList![index];
    bool isSubscribed = Provider.of<SubscriptionModel>(context).isSubscribed;

    return Padding(
      padding: const EdgeInsets.only(right: 0.0),
      child: InkWell(
        child: Container(
          height: 250.0,
          width: 150.0,
          child: Column(
            children: <Widget>[
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.grey[300]!, width: 0.5)),
                color: Colors
                    .primaries[Random().nextInt(Colors.primaries.length)][100],
                child: Container(
                  height: 120,
                  width: 150,
                  padding: EdgeInsets.all(3),
                  child: CachedNetworkImage(
                    imageUrl: media.coverPhoto!,
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
                margin: EdgeInsets.only(left: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              media.title!,
                              style: TextStyles.headline(context).copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(height: 3.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              media.artist!,
                              style: TextStyles.subhead(context).copyWith(
                                //fontWeight: FontWeight.bold,
                                fontSize: 13.0,
                                //color: Colors.blueGrey[300],
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MediaPopupMenu(media),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          if (Utility.isMediaRequireUserSubscription(media, isSubscribed)) {
            Alerts.showPlaySubscribeAlertDialog(context);
            return;
          }
          Provider.of<AudioPlayerModel>(context, listen: false).preparePlaylist(
              Utility.extractMediaByType(mediaList!, media.mediaType), media);
          Navigator.of(context).pushNamed(PlayPage.routeName);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 2),
                    child: Text(
                      header,
                      //textAlign: TextAlign.start,
                      maxLines: 1,
                      style: TextStyles.headline(context).copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                subHeader == ""
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                        child: Text(subHeader,
                            maxLines: 1,
                            style: TextStyles.subhead(context).copyWith(
                              fontSize: 13,
                              // color: Colors.grey[600],
                            )),
                      ),
              ],
            ),
            Spacer(),
            header == t.bookmark
                ? InkWell(
                    onTap: () {
                      if (header == t.trendingvideos ||
                          header == t.trendingaudios) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TrendingListPage()),
                        );
                      }
                      if (header == t.audiotracks) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AudioListPage()),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 20, 10),
                      child: Text("More",
                          style: TextStyles.headline(context).copyWith(
                            decoration: TextDecoration.underline,
                            //fontWeight: FontWeight.bold,
                            fontSize: 15,
                          )),
                    ),
                  )
                : Container(),
          ],
        ),
        mediaList!.length == 0
            ? Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(t.noitemstodisplay,
                      textAlign: TextAlign.center,
                      style: TextStyles.medium(context)),
                ),
              )
            : Container(
                padding: EdgeInsets.only(top: 5.0, left: 0.0),
                height: 200.0,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  primary: false,
                  itemCount: mediaList!.length,
                  itemBuilder: _buildItems,
                ),
              ),
      ],
    );
  }
}
