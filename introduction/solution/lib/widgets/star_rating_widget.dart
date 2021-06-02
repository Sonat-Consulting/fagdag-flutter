import 'package:flutter/material.dart';

class StarRatingWidget extends StatelessWidget {
  final int value;
  final Widget filledStar =
      Icon(Icons.star_border_outlined, color: Colors.yellow[800]);
  final Widget unfilledStar =
      Icon(Icons.star_border_outlined, color: Colors.grey);

  final Function? onRatingChanged;

  StarRatingWidget({
    this.value = 0,
    this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return GestureDetector(
            onTap: () => handleStarTap(index + 1),
            child: index < value ? filledStar : unfilledStar);
      }),
    );
  }

  handleStarTap(int index) => onRatingChanged!(index);
}
