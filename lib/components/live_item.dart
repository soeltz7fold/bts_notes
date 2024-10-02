import 'package:flutter/material.dart';

import '../configs/types.dart';
import '../constants/app_strings.dart';
import '../constants/colored.dart';

class LiveItem extends StatelessWidget {
  const LiveItem({
    super.key,
    required this.index,
    this.isLive = false,
    this.extent, // extent: (index % 5 + 1) * 100,
    this.backgroundColor,
    this.bottomSpace,
    this.footer,
    this.onTap,
  });

  final int index;
  final double? extent;
  final double? bottomSpace;
  final bool isLive;
  final Color? backgroundColor;
  final FunCtn<Widget>? footer;
  final FunCtx? onTap;
  BorderRadius get _borderRadius => BorderRadius.circular(16);

  Color? get colorLive => isLive ? null : Colored.shadowBlack;

  Color? get backgroundLive => isLive ? Colored.shadowPink : Colored.shadowBlack;

  @override
  Widget build(BuildContext context) {
    Widget content = SizedBox(
      height: extent ?? ((index % 3) + 1) * 150,
      child: Center(
        child: CircleAvatar(
          minRadius: 32,
          maxRadius: 64,
          backgroundColor: backgroundLive,
          // foregroundColor: Colored.onlyBlack,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              AppAssets.appLogo,
              color: colorLive,
            ),
          ),
          // Text('$index', style: const TextStyle(fontSize: 20)),
        ),
      ),
    );

    if (null != footer) {
      final fContainer = SizedBox(
        height: bottomSpace,
        child: footer!.call(context),
        // color: Colored.onlyGreen,
      );
      content = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          content,
          fContainer,
        ],
      );
    }

    return Card(
      // color: Colored.shadowWhite,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: _borderRadius),
      child: InkWell(
        borderRadius: _borderRadius,
        onTap: isLive ? () => onTap?.call(context) : null,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: content,
          // child: Ink(width: 100, height: 100),
        ),
      ),
    );

    // if (null == bottomSpace) {
    //   return child;
    // }
    //
    // return Column(
    //   mainAxisSize: MainAxisSize.min,
    //   children: [
    //     child,
    //     // Expanded(child: child),
    //     Container(
    //       height: bottomSpace ?? 16,
    //       color: Colored.onlyGreen,
    //     )
    //   ],
    // );
  }
}
