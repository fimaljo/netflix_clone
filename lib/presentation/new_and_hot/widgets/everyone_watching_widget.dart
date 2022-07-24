import 'package:flutter/material.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/home/widgets/coustome_button_widget.dart';
import 'package:netflix/presentation/widgets/video_widget.dart';

class EveryonesWachingWidget extends StatelessWidget {
  final String posterpath;
  final String movieName;
  final String description;

  const EveryonesWachingWidget(
      {Key? key,
      required this.posterpath,
      required this.movieName,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kHight,
        Text(
          movieName,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        kHight,
        Text(
          description,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: kGreyColor),
        ),
        SizedBox(height: 50),
        VideoWidget(
          url: posterpath,
        ),
        kHight,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            CoustomButtonWidget(
                iconSize: 25, textSize: 16, icon: Icons.share, title: "Share"),
            kWidth,
            CoustomButtonWidget(
                iconSize: 25, textSize: 16, icon: Icons.add, title: "My List"),
            kWidth,
            CoustomButtonWidget(
                iconSize: 25,
                textSize: 16,
                icon: Icons.play_arrow,
                title: "Play"),
          ],
        )
      ],
    );
  }
}
