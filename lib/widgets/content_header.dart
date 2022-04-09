import 'package:flutter/material.dart';
import 'package:netflix/widgets/widgets.dart';
import 'package:video_player/video_player.dart';
import '../models/models.dart';

class ContentHeader extends StatelessWidget {
  final Content featuredContent;
  const ContentHeader({Key? key, required this.featuredContent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(null,
        mobile: _ContentHeaderMobile(featuredContent: featuredContent),
        desktop: _ContentHeaderDesktop(featuredContent: featuredContent));
  }
}

class _ContentHeaderMobile extends StatelessWidget {
  final Content featuredContent;
  const _ContentHeaderMobile({required this.featuredContent, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 500.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(featuredContent.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 500.0,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.black, Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter),
          ),
        ),
        Positioned(
          bottom: 110.0,
          child: SizedBox(
            width: 250.0,
            child: Image.asset(featuredContent.titleImageUrl.toString()),
          ),
        ),
        Positioned(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              VerticalIconButton(icon: Icons.add, title: 'List'),
              _PlayButton(),
              VerticalIconButton(icon: Icons.info_outline, title: 'Info'),
            ],
          ),
          left: 0.0,
          right: 0.0,
          bottom: 40.0,
        )
      ],
    );
  }
}

class _ContentHeaderDesktop extends StatefulWidget {
  final Content featuredContent;
  const _ContentHeaderDesktop({required this.featuredContent, Key? key})
      : super(key: key);

  @override
  State<_ContentHeaderDesktop> createState() => _ContentHeaderDesktopState();
}

class _ContentHeaderDesktopState extends State<_ContentHeaderDesktop> {
  late VideoPlayerController _videoPlayerController;
  bool _isMuted = true;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(
        widget.featuredContent.videoUrl.toString())
      ..initialize().then((_) => setState(() {}))
      ..play()
      ..setVolume(0);
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _videoPlayerController.value.isPlaying
          ? _videoPlayerController.pause()
          : _videoPlayerController.play(),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          AspectRatio(
            aspectRatio: _videoPlayerController.value.isInitialized
                ? _videoPlayerController.value.aspectRatio
                : 2.344,
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Image.asset(
                    widget.featuredContent.imageUrl,
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned(
            bottom: -1.0,
            left: 0.0,
            right: 0.0,
            child: AspectRatio(
              aspectRatio: _videoPlayerController.value.isInitialized
                  ? _videoPlayerController.value.aspectRatio
                  : 2.344,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.black, Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter),
                ),
              ),
            ),
          ),
          Positioned(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 250.0,
                  child: Image.asset(
                      widget.featuredContent.titleImageUrl.toString()),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Text(
                  widget.featuredContent.description.toString(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      shadows: [
                        Shadow(
                            color: Colors.black,
                            offset: Offset(2.0, 4.0),
                            blurRadius: 6.0)
                      ]),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    const _PlayButton(),
                    const SizedBox(
                      width: 16.0,
                    ),
                    TextButton.icon(
                      style:
                          TextButton.styleFrom(backgroundColor: Colors.white,padding: const EdgeInsets.fromLTRB(25.0, 10.0, 30.0, 10.0)),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.info_outline,
                        color: Colors.black,
                        size: 30.0,
                      ),
                      label: const Text(
                        'More info',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    if (_videoPlayerController.value.isInitialized)
                      IconButton(
                        icon:
                            Icon(_isMuted ? Icons.volume_off : Icons.volume_up),
                        onPressed: () => setState(() {
                          _isMuted
                              ? _videoPlayerController.setVolume(100)
                              : _videoPlayerController.setVolume(0);
                          _isMuted = _videoPlayerController.value.volume == 0;
                        }),
                        iconSize: 30.0,
                        color: Colors.white,
                      ),
                  ],
                )
              ],
            ),
            left: 60.0,
            bottom: 150.0,
            right: 50.0,
          ),
        ],
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  const _PlayButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          padding: !Responsive.isDesktop(context)
              ? const EdgeInsets.fromLTRB(15.0, 5.0, 20.0, 5.0)
              : const EdgeInsets.fromLTRB(25.0, 10.0, 30.0, 10.0)),
      onPressed: () {},
      icon: const Icon(
        Icons.play_arrow,
        size: 30.0,
        color: Colors.black,
      ),
      label: const Text(
        'Play',
        style: TextStyle(
            fontWeight: FontWeight.w600, fontSize: 16.0, color: Colors.black),
      ),
    );
  }
}
