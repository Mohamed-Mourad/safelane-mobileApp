import 'package:flutter/material.dart';
import 'package:icon_decoration/icon_decoration.dart';
import '../../Shared/components/constants.dart';

Widget button({
  required double width,
  required Color background,
  required VoidCallback function,
  required String text,
  Color border = const Color(0xFFFFFFFF),
  bool hasBorder = false,
  double radius = 12.0,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: hasBorder ? border : Colors.transparent,
          ),
          color: background
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget ratingStars({
  required int rating,
}) =>
    Container(
      height: 28.0,
      width: 125.0,
      child: Row(
        children: [
          DecoratedIcon(
            icon: Icon(
              Icons.star_rounded,
              color: SLGreen,
            ),
            decoration: IconDecoration(
              border: IconBorder(
                color: SLNavy,
              ),
            ),
          ),
          const SizedBox(
            width: 1.0,
          ),
          DecoratedIcon(
            icon: Icon(
              Icons.star_rounded,
              color: rating >= 2
                  ? SLGreen
                  : grey,
            ),
            decoration: IconDecoration(
              border: IconBorder(
                color: SLNavy,
              ),
            ),
          ),
          const SizedBox(
            width: 1.0,
          ),
          DecoratedIcon(
            icon: Icon(
              Icons.star_rounded,
              color: rating >= 3
                  ? SLGreen
                  : grey,
            ),
            decoration: IconDecoration(
              border: IconBorder(
                color: SLNavy,
              ),
            ),
          ),
          const SizedBox(
            width: 1.0,
          ),
          DecoratedIcon(
            icon: Icon(
              Icons.star_rounded,
              color: rating >= 4
                  ? SLGreen
                  : grey,
            ),
            decoration: IconDecoration(
              border: IconBorder(
                color: SLNavy,
              ),
            ),
          ),
          const SizedBox(
            width: 1.0,
          ),
          DecoratedIcon(
            icon: Icon(
              Icons.star_rounded,
              color: rating == 5
                  ? SLGreen
                  : grey,
            ),
            decoration: IconDecoration(
              border: IconBorder(
                color: SLNavy,
              ),
            ),
          ),
          const SizedBox(
            width: 1.0,
          ),
        ],
      ),
    );

Widget severityBars({
  required int severity,
}) =>
    Container(
      height: 34,
      width: 18,
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 18.0,
              height: 6.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                color: severity == 5 ? MadosRed : grey,
              ),
            ),
            SizedBox(
              height: 1.0,
            ),
            Container(
              width: 16.0,
              height: 6.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                color: severity >= 4 ? MadosRed : grey,
              ),
            ),
            SizedBox(
              height: 1.0,
            ),
            Container(
              width: 14.0,
              height: 6.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                color: severity >= 3 ? MadosRed : grey,
              ),
            ),
            SizedBox(
              height: 1.0,
            ),
            Container(
              width: 12.0,
              height: 6.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                color: severity >= 2 ? MadosRed : grey,
              ),
            ),
            SizedBox(
              height: 1.0,
            ),
            Container(
              width: 10.0,
              height: 6.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                color: MadosRed,
              ),
            ),
          ],
        ),
      ),
);