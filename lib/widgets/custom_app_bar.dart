import 'package:flutter/material.dart';
import 'package:netflix/assets.dart';
import 'package:netflix/widgets/responsive.dart';

class CustomAppBar extends StatelessWidget {
  final double scrollOffset;
  const CustomAppBar({this.scrollOffset=0.0,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      color: Colors.black.withOpacity((scrollOffset/350).clamp(0, 1).toDouble()),
      child: Responsive(null,mobile:_CustomAppBarMobile(),desktop: _CustomAppBarDesktop(),),
    );
  }
}

class _AppBarButton extends StatelessWidget {
  final String title;
  const _AppBarButton({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child:  Text(
        title,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}


class _CustomAppBarMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Image.asset(Assets.netflixLogo0),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _AppBarButton(title: 'Tv Shows',),
                _AppBarButton(title: 'Movies',),
                _AppBarButton(title: 'My List',),
              ],
            ),
          )
        ],
      ),
    );
  }
}
class _CustomAppBarDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Image.asset(Assets.netflixLogo1),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _AppBarButton(title: 'Home',),
                _AppBarButton(title: 'Tv Shows',),
                _AppBarButton(title: 'Movies',),
                _AppBarButton(title: 'Latest',),
                _AppBarButton(title: 'My List',),
              ],
            ),
          )
        ],
      ),
    );
  }
}
