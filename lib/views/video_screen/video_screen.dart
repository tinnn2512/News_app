import 'package:flutter/material.dart';
import 'package:news_app/provider/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Videos",
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: ListView.builder(
          itemCount: appProvider.newsVideo.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (ctx, index) {
            YoutubePlayerController controller = YoutubePlayerController(
              initialVideoId: appProvider.newsVideo[index],
              flags: const YoutubePlayerFlags(
                autoPlay: false,
                mute: false,
              ),
            );
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: YoutubePlayer(
                controller: controller,
                showVideoProgressIndicator: true,

                // videoProgressIndicatorColor: Colors.amber,
                // progressColors: ProgressColors(
                //     playedColor: Colors.amber,
                //     handleColor: Colors.amberAccent,
                // ),
                // onReady () {
                //     _controller.addListener(listener);
                // },
              ),
            );
          }),
    );
  }
}
