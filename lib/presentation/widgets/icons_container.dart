import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_watch_app/presentation/constants/constants.dart';

class IconsContainer extends StatelessWidget {
  const IconsContainer({super.key, required this.icon});
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Constants.socialIconContainerSize,
      height: Constants.socialIconContainerSize,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: SvgPicture.asset(
          icon,
          width: Constants.socialIconSize,
          height: Constants.socialIconSize,
        ),
      ),
    );
  }
}
