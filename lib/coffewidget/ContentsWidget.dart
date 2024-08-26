import 'package:flutter/material.dart';
import '../model/CoffeItem.dart';

class ContentsWidget extends StatelessWidget {
  final CoffeItem coffeItem;
  final int index;
  final VoidCallback onDelete;
  final VoidCallback onFavoriteToggle;

  ContentsWidget({
    required this.coffeItem,
    required this.index,
    required this.onDelete,
    required this.onFavoriteToggle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.ltr,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Center(child: Text("${index + 1}")),
        ),
        Expanded(
          flex: 2,
          child: Image.network(
            coffeItem.url.toString(),
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Text(
                    '제목 : ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('${coffeItem.title}'),
                ],
              ),
              Row(
                children: [
                  const Text(
                    '내용 : ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      '${coffeItem.description}',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: onFavoriteToggle,
            child: Icon(
              coffeItem.isFavorite ? Icons.favorite : Icons.favorite_border,
              size: 30,
              color: coffeItem.isFavorite ? Colors.red : null,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: onDelete,
          ),
        ),
      ],
    );
  }
}
