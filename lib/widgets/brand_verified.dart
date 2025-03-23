import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TBrandTitleWithVerifiedIcon extends StatelessWidget {
  const TBrandTitleWithVerifiedIcon({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.textColor,
    this.iconColor = Colors.blue,
    this.textAlign = TextAlign.center,
  });

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            title,
            style: TextStyle(color: textColor, fontSize: 14),
            maxLines: maxLines,
            textAlign: textAlign,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Icon(
          Iconsax.verify5,
          color: iconColor,
          size: 12,
        )
      ],
    );
  }
}
