import 'package:flutter/material.dart';
import '../model/CoffeItem.dart';
import 'ContentsWidget.dart';

class StackWidget extends StatelessWidget {
  const StackWidget({
    super.key,
    required this.coffeItem,
    required this.index,
    required this.onDelete,
    required this.onFavoriteToggle,
  });

  final CoffeItem coffeItem;
  final int index;
  final VoidCallback onDelete;
  final VoidCallback onFavoriteToggle;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 120.0,
            width: screenWidth,
            decoration: const BoxDecoration(
              color: Colors.white70,
              border: Border(
                top: BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
                bottom: BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
            ),
            child: ContentsWidget(
              coffeItem: coffeItem,
              index: index,
              onDelete: onDelete,
              onFavoriteToggle: onFavoriteToggle,
            ),
          ),
        ),
      ],
    );
  }
}
