import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../utils/TextStyles.dart';
import '../models/Playlists.dart';
import '../i18n/strings.g.dart';
import '../providers/PlaylistsModel.dart';
import '../screens/PlaylistMediaScreen.dart';
import '../models/ScreenArguements.dart';
import 'dart:math';

class PlaylistsScreen extends StatefulWidget {
  PlaylistsScreen(this.title);
  final String title;

  @override
  MediaScreenRouteState createState() => new MediaScreenRouteState();
}

class MediaScreenRouteState extends State<PlaylistsScreen> {
  late PlaylistsModel playlistsModel;
  late List<Playlists> items;

  void clearPlaylistsMedia(BuildContext context, int? id) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              t.clearplaylistmedias,
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  t.cancel,
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  t.ok,
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  playlistsModel.deletePlaylistsMediaList(id);
                  Navigator.of(context).pop();
                },
              ),
            ],
            content: Text(t.clearplaylistmediashint),
          );
        });
  }

  void deletePlaylist(BuildContext context, int? id) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              t.clearplaylistmedias,
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  t.cancel,
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  t.ok,
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  playlistsModel.deletePlaylists(id);
                  Navigator.of(context).pop();
                },
              ),
            ],
            content: Text(t.clearplaylistmediashint),
          );
        });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    playlistsModel = Provider.of<PlaylistsModel>(context);
    items = playlistsModel.playlistsList;
    return (items.length == 0)
        ? Center(
            child: Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(t.noitemstodisplay,
                    textAlign: TextAlign.center,
                    style: TextStyles.medium(context)),
              ),
            ),
          )
        : ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
            itemCount: items.length + 1,
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
                Playlists playlists = items[_indx];
                return InkWell(
                  child: ListTile(
                    //contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    leading: Container(
                      width: 40,
                      height: 40,
                      child: FutureBuilder<String?>(
                          initialData: "",
                          future: playlistsModel.getPlayListFirstMediaThumbnail(
                              playlists.id), //returns bool
                          builder: (BuildContext context,
                              AsyncSnapshot<String?> value) {
                            if (value.data == null || value.data == "")
                              return Icon(
                                Icons.music_note,
                                size: 30,
                                color: Colors.primaries[
                                    Random().nextInt(Colors.primaries.length)],
                              );
                            else
                              return CachedNetworkImage(
                                imageUrl: value.data!,
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
                              );
                          }),
                    ),
                    title: Text(
                      playlists.title!,
                      maxLines: 1,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: FutureBuilder<int>(
                        initialData: 0,
                        future: playlistsModel
                            .getPlaylistMediaCount(playlists.id), //returns bool
                        builder:
                            (BuildContext context, AsyncSnapshot<int> value) {
                          return Text(
                            value.data == null
                                ? "0 item"
                                : value.data.toString() + " item(s)",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          );
                        }),
                    // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                    //subtitle:  Text(categories.interest, ),
                    trailing: PopupMenuButton(
                      elevation: 3.2,
                      //initialValue: choices[1],
                      itemBuilder: (BuildContext context) {
                        List<String> choices = [
                          t.clearplaylistmedias,
                          t.deletePlayList
                        ];
                        return choices.map((itm) {
                          return PopupMenuItem(
                            value: itm,
                            child: Text(itm),
                          );
                        }).toList();
                      },
                      //initialValue: 2,
                      onCanceled: () {
                        print("You have canceled the menu.");
                      },
                      onSelected: (dynamic value) {
                        print(value);
                        if (value == t.clearplaylistmedias) {
                          clearPlaylistsMedia(context, playlists.id);
                        }
                        if (value == t.deletePlayList) {
                          deletePlaylist(context, playlists.id);
                        }
                      },
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      PlaylistMediaScreen.routeName,
                      arguments:
                          ScreenArguements(position: 0, items: playlists),
                    );
                  },
                );
              }
            },
          );
  }
}
