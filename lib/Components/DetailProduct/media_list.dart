import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swd_project/Components/DetailProduct/video_load.dart';
import 'package:swd_project/Model/Product/Product.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MediaList extends StatefulWidget {
  final List<ProductMedia> media;

  const MediaList({Key key, this.media}) : super(key: key);

  @override
  _MediaListState createState() => _MediaListState(media);
}

class _MediaListState extends State<MediaList> {
  final List<ProductMedia> media;

  _MediaListState(this.media);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 7),
      child: Container(
        height: 180,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: media.length,
          physics: ScrollPhysics(),
          // ngao ngao ko scroll này
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(4),
              child: new GestureDetector(
                child: new GridTile(
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      new BoxShadow(
                          color: Colors.black54.withOpacity(0.5),
                          offset: new Offset(0.1, 2.0),
                          blurRadius: 3.8),
                    ]),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (media[index].mediaType == "image")
                            loadImage(media[index])
                          else if (media[index].mediaType == "video")
                            loadVideo(media[index])
                        ]),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget loadVideo(ProductMedia media) {
    String thumbnailUrl =
        "https://img.youtube.com/vi/${YoutubePlayer.convertUrlToId(media.url)}/0.jpg";
    return Container(
      width: 240,
      height: 170,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(thumbnailUrl),
                fit: BoxFit.fill,
              )),
            ),
          ),
          Center(
            child: MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VideoPlayerPage(
                            controller: YoutubePlayerController(
                                initialVideoId:
                                    YoutubePlayer.convertUrlToId(media.url),
                                flags: YoutubePlayerFlags(autoPlay: true)))));
              },
              color: Colors.white.withOpacity(0.4),
              textColor: Colors.white,
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 30,
              ),
              padding: EdgeInsets.all(16),
              shape: CircleBorder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget loadImage(ProductMedia media) {
    return Container(
      width: 170,
      height: 170,
      padding: EdgeInsets.all(15),
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return dialogImg(context, media.url);
              });
        },
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: NetworkImage(media.url),
            fit: BoxFit.fill,
          )),
        ),
      ),
    );
  }

  Widget dialogImg(BuildContext context, String url) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(13.0))),
      title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 30,
            ),
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop())
          ]),
      content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 400,
                  height: 550,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: NetworkImage(url),
                    fit: BoxFit.contain,
                  )),
                ),
              ),
            ],
          )),
    );
  }
}
