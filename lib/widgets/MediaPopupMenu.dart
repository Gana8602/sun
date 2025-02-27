import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:package_info/package_info.dart';
import 'package:flutter_share/flutter_share.dart';
import '../providers/BookmarksModel.dart';
import '../providers/DownloadsModel.dart';
import '../screens/AddPlaylistScreen.dart';
import '../models/ScreenArguements.dart';
import '../models/Downloads.dart';
import '../screens/Downloader.dart';
import '../models/Media.dart';
import '../i18n/strings.g.dart';

class MediaPopupMenu extends StatelessWidget {
  MediaPopupMenu(this.media, {this.isDownloads});
  final Media? media;
  final isDownloads;

  @override
  Widget build(BuildContext context) {
    BookmarksModel bookmarksModel = Provider.of<BookmarksModel>(context);
    DownloadsModel downloadsModel = Provider.of<DownloadsModel>(context);

    return PopupMenuButton(
      elevation: 3.2,
      //initialValue: choices[1],
      itemBuilder: (BuildContext context) {
        bool isBookmarked = bookmarksModel.isMediaBookmarked(media);
        List<String> choices = [];
        if (media!.canDownload!) {
          choices.add(t.download);
        }
        if (isDownloads != null &&
            downloadsModel.isMediaInDownloads(media!.id)!.status ==
                DownloadTaskStatus.complete) {
          choices.add(t.deletemedia);
        }
        choices.add(t.addplaylist);
        if (isBookmarked) {
          choices.add(t.unbookmark);
        } else {
          choices.add(t.bookmark);
        }
        choices.add(t.share);
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
        if (value == t.download) {
          downloadFIle(context, media!);
        }
        if (value == t.deletemedia) {
          downloadsModel.removeDownloadedMedia(context, media!.id);
        }
        if (value == t.addplaylist) {
          Navigator.pushNamed(
            context,
            AddPlaylistScreen.routeName,
            arguments: ScreenArguements(position: 0, items: media),
          );
        }
        if (value == t.bookmark) {
          bookmarksModel.bookmarkMedia(media!);
        }
        if (value == t.unbookmark) {
          bookmarksModel.unBookmarkMedia(media!);
        }
        if (value == t.share) {
          ShareFile.share(media!);
        }
      },
      icon: Icon(
        Icons.more_vert,
        color: Colors.grey[500],
      ),
    );
  }

  downloadFIle(BuildContext context, Media media) {
    Downloads downloads = Downloads.mapCurrentDownloadMedia(media);
    Navigator.pushNamed(context, Downloader.routeName,
        arguments: ScreenArguements(
          position: 0,
          items: downloads,
        ));
  }
}

class ShareFile {
  static share(Media media) async {
    print("share here");
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String packageName = packageInfo.packageName;
    if (media.http!) {
      print("share one");
      await FlutterShare.share(
        title: t.sharefiletitle +
            media.title! +
            "\n" +
            t.sharefilebody +
            " http://play.google.com/store/apps/details?id=" +
            packageName,
        text: t.sharefiletitle + media.title!,
      );
    } else {
      print("share two");
      await FlutterShare.shareFile(
          title: t.sharefiletitle +
              media.title! +
              "\n" +
              t.sharefilebody +
              " http://play.google.com/store/apps/details?id=" +
              packageName,
          text: t.sharefiletitle + media.title!,
          filePath: media.streamUrl!);
    }
  }
}
