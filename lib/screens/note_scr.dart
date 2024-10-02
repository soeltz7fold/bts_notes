import 'dart:math';

import 'package:bts_notes/components/live_item.dart';
import 'package:bts_notes/constants/hardcodeds.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NoteView extends StatelessWidget {
  const NoteView({super.key});

  @override
  Widget build(BuildContext context) => MasonryGridView.count(
        physics: const AlwaysScrollableScrollPhysics(
            // parent: ClampingWithOverscrollPhysics(state: state),
            ),
        crossAxisCount: 2,
        mainAxisSpacing: 2,
        // crossAxisSpacing: 2,
        itemCount: Hardcodeds.sampleNotes.length,
        itemBuilder: (context, index) {
          final item = Hardcodeds.sampleNotes[index];
          return LiveItem(
            index: index,
            isLive: item.isFinish,
            onTap: (ctx) async {},
            // bottomSpace: 32,
            footer: (ctx) => Text(
              item.title,
              // style: const TextStyle(color: Colored.onlyWhite),
            ),
          );
        },
      );
}
