import 'package:flutter/material.dart';
import '../coffewidget/StackWidget.dart';
import '../model/CoffeItem.dart';
import 'DetailPage.dart';

class LayoutWidget extends StatefulWidget {
  final List<CoffeItem> coffeeList;
  final Function(CoffeItem) onFavoriteToggle;

  const LayoutWidget({
    super.key,
    required this.coffeeList,
    required this.onFavoriteToggle,
  });

  @override
  _LayoutWidgetState createState() => _LayoutWidgetState();
}

class _LayoutWidgetState extends State<LayoutWidget> {
  void updateItem(CoffeItem updatedItem, int index) {
    setState(() {
      widget.coffeeList[index] = updatedItem;
    });
  }

  void deleteItem(int index) {
    setState(() {
      widget.coffeeList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.coffeeList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(
                  coffeItem: widget.coffeeList[index],
                  onDelete: () => deleteItem(index),
                  onUpdate: (updatedItem) => updateItem(updatedItem, index),
                ),
              ),
            );
          },
          child: StackWidget(
            coffeItem: widget.coffeeList[index],
            index: index,
            onDelete: () {
              deleteItem(index);
            },
            onFavoriteToggle: () {
              setState(() {
                widget.onFavoriteToggle(widget.coffeeList[index]);
              });
            },
          ),
        );
      },
    );
  }
}
