import 'package:flutter/material.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/home/widgets/coustome_button_widget.dart';
import 'package:netflix/presentation/widgets/video_widget.dart';

class ComingSoonWidget extends StatelessWidget {
  final String id;
  final String month;
  final String day;
  final String posterpath;
  final String movieName;
  final String description;

  const ComingSoonWidget(
      {Key? key,
      required this.id,
      required this.month,
      required this.day,
      required this.posterpath,
      required this.movieName,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: 50,
          height: 450,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                month,
                style: const TextStyle(
                    //  fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: kGreyColor),
              ),
              Text(
                day,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    letterSpacing: 4),
              )
            ],
          ),
        ),
        SizedBox(
          width: size.width - 50,
          height: 450,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VideoWidget(
                url: posterpath,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      movieName,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                          letterSpacing: -1,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  //const Spacer(),
                  Row(
                    children: const [
                      CoustomButtonWidget(
                          iconSize: 20,
                          textSize: 12,
                          icon: Icons.notifications_none_outlined,
                          title: "Remind me,"),
                      CoustomButtonWidget(
                          iconSize: 20,
                          textSize: 12,
                          icon: Icons.info_outline,
                          title: "Info,"),
                      kWidth,
                    ],
                  ),
                ],
              ),
              //  kHight,
              Text("Coming on $day $month"),
              kHight,
              Text(
                movieName,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              kHight,
              Text(
                description,
                maxLines: 4,
                style: const TextStyle(color: kGreyColor),
              )
            ],
          ),
        ),
      ],
    );
  }
}
