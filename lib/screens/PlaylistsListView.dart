import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:math';
import 'package:streamit_flutter/utils/TextStyles.dart';
import '../models/Playlists.dart';
import '../providers/PlaylistsModel.dart';
import '../i18n/strings.g.dart';
import '../screens/PlaylistMediaScreen.dart';
import '../models/ScreenArguements.dart';

class PlaylistsListView extends StatelessWidget {
  PlaylistsListView(this.playlists);
  final List<Playlists> playlists;

  Widget _buildItems(BuildContext context, int index) {
    var cats = playlists[index];
    return Consumer<PlaylistsModel>(builder: (context, playlistsModel, child) {
      return Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: InkWell(
          child: Container(
            height: 150.0,
            width: 100.0,
            child: Column(
              children: <Widget>[
                Container(
                  height: 80,
                  //margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FutureBuilder<String?>(
                      initialData: "",
                      future: playlistsModel.getPlayListFirstMediaThumbnail(
                          cats.id), //returns bool
                      builder:
                          (BuildContext context, AsyncSnapshot<String?> value) {
                        if (value.data == null || value.data == "")
                          return Container(
                            color: Colors.grey[300],
                            child: Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.music_note,
                                size: 50,
                                color: Colors.primaries[
                                    Random().nextInt(Colors.primaries.length)],
                              ),
                            ),
                          );
                        else
                          return CachedNetworkImage(
                            imageUrl: value.data!,
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
                          );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 7.0),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    cats.title!,
                    style: TextStyles.subhead(context).copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
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
              PlaylistMediaScreen.routeName,
              arguments: ScreenArguements(position: 0, items: cats),
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 0, 10),
          child: Text(t.playlist,
              style: TextStyles.headline(context).copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
        ),
        playlists.length == 0
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
                padding: EdgeInsets.only(top: 15.0, left: 20.0),
                height: 150.0,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  primary: false,
                  itemCount: playlists.length,
                  itemBuilder: _buildItems,
                ),
              ),
      ],
    );
  }
}
