import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:streamit_flutter/utils/my_colors.dart';
import '../screens/AlbumsScreen.dart';
import '../utils/TextStyles.dart';
import '../models/Albums.dart';
import '../i18n/strings.g.dart';
import '../models/ScreenArguements.dart';
import '../screens/AlbumsMediaScreen.dart';

class AlbumsListView extends StatelessWidget {
  AlbumsListView(this.albums);
  final List<Albums>? albums;

  Widget _buildItems(BuildContext context, int index) {
    var cats = albums![index];

    return Padding(
      padding: const EdgeInsets.only(right: 0.0),
      child: InkWell(
        child: Container(
          height: 200.0,
          width: 140.0,
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
                  width: 140,
                  padding: EdgeInsets.all(8),
                  child: CachedNetworkImage(
                    imageUrl: cats.thumbnail!,
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
                  cats.title!,
                  style: TextStyles.headline(context).copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 3.0),
              Container(
                alignment: Alignment.center,
                child: Text(
                  cats.mediaCount.toString() + " " + t.tracks,
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
          Navigator.pushNamed(
            context,
            AlbumsMediaScreen.routeName,
            arguments: ScreenArguements(position: 0, items: cats),
          );
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
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
              child: Text(t.albums,
                  style: TextStyles.headline(context).copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )),
            ),
            Spacer(),
            MaterialButton(
              elevation: 0,
              textColor: Colors.white,
              color: MyColors.accent,
              height: 0,
              child: Icon(Icons.keyboard_arrow_right),
              minWidth: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              padding: const EdgeInsets.all(0.0),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AlbumsScreen.routeName,
                );
              },
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.only(top: 0.0, left: 0.0),
          height: 200.0,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            primary: false,
            itemCount: albums!.length,
            itemBuilder: _buildItems,
          ),
        ),
      ],
    );
  }
}
