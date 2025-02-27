import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../providers/AudioPlayerModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';

class RotatePlayer extends AnimatedWidget {
  RotatePlayer({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    //final Animation<double> animation = listenable;
    AudioPlayerModel audioPlayerModel = Provider.of(context);
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.all(4),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.40,
        child: ShapeOfView(
          elevation: 4,
          height: double.infinity,
          shape: ArcShape(
              direction: ArcDirection.Outside,
              height: 20,
              position: ArcPosition.Bottom),
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: audioPlayerModel.currentMedia!.coverPhoto!,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      //colorFilter:
                      //   ColorFilter.mode(Colors.black87, BlendMode.darken),
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
            ],
          ),
        ),
      ),
    );
  }
}
