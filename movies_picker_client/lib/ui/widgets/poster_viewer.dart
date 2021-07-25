import 'package:flutter/material.dart';

import '../../shared/shared.dart';

class PosterViewer extends StatelessWidget {
  const PosterViewer(this.id, this.poster, this.isComingSoon);

  final int id;
  final String poster;
  final bool isComingSoon;

  @override
  Widget build(BuildContext context) {
    if (isComingSoon) {
      return Stack(
        children: [
          _buildPoster(),
          Positioned.fill(
            child: Container(
              width: SharedSizes.poster.width,
              height: SharedSizes.poster.height,
              child: Image.asset(
                SharedImages.comingSoon,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        ],
      );
    } else {
      return _buildPoster();
    }
  }

  Widget _buildPoster() => Hero(
        tag: id,
        child: Image.network(poster),
      );
}
