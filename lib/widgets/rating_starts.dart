import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating;

  RatingStars({required this.rating});

  @override
  Widget build(BuildContext context) {
    int fullStars = rating.floor();
    bool halfStar = (rating - fullStars) >= 0.5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < fullStars) return Icon(Icons.star, color: Colors.amber, size: 16);
        if (index == fullStars && halfStar) return Icon(Icons.star_half, color: Colors.amber, size: 16);
        return Icon(Icons.star_border, color: Colors.amber, size: 16);
      }),
    );
  }
}
