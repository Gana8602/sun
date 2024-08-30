import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../models/Media.dart';
import '../providers/AudioPlayerModel.dart';
import '../audio_player/player_page.dart';
import '../utils/Utility.dart';
import '../utils/TextStyles.dart';

class HomeSlider extends StatelessWidget {
  final List<Media>? items;
  HomeSlider(this.items);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          padding: EdgeInsets.only(top: 0.0, left: 0.0),
          height: 250.0,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            primary: false,
            itemCount:
                (items == null || items!.length == 0) ? 0 : items!.length,
            itemBuilder: (BuildContext context, int index) {
              Media curObj = items![index];
              return Padding(
                padding: const EdgeInsets.only(right: 0.0),
                child: InkWell(
                  child: Container(
                    height: 250.0,
                    width: 150.0,
                    child: Column(
                      children: <Widget>[
                        /*ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 180.0,
                            width: 140.0,
                            child: CachedNetworkImage(
                              imageUrl: curObj.coverPhoto!,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
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
                        ),*/
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                  color: Colors.grey[300]!, width: 0.5)),
                          color: Colors.primaries[
                              Random().nextInt(Colors.primaries.length)][100],
                          child: Container(
                            height: 180,
                            width: 150,
                            padding: EdgeInsets.all(8),
                            child: CachedNetworkImage(
                              imageUrl: curObj.coverPhoto!,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
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
                          padding: EdgeInsets.only(
                            left: 3,
                            right: 3,
                          ),
                          child: Text(
                            curObj.title!,
                            style: TextStyles.headline(context).copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                            ),
                            maxLines: 1,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 3.0),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            curObj.artist!,
                            style: TextStyles.subhead(context).copyWith(
                              //fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                              //color: Colors.blueGrey[300],
                            ),
                            maxLines: 1,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Provider.of<AudioPlayerModel>(context, listen: false)
                        .preparePlaylist(
                            Utility.extractMediaByType(
                                Utility.extractMediaByType(
                                    items!, curObj.mediaType),
                                curObj.mediaType),
                            curObj);
                    Navigator.of(context).pushNamed(PlayPage.routeName);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
