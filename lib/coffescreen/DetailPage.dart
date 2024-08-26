import 'package:flutter/material.dart';
import '../model/CoffeItem.dart';
import 'Editpage.dart';

class DetailPage extends StatelessWidget {
  final CoffeItem coffeItem;
  final VoidCallback onDelete;
  final Function(CoffeItem) onUpdate;

  const DetailPage({
    super.key,
    required this.coffeItem,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(coffeItem.title ?? "상세 페이지"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Editpage(
                    initialCoffeItem: coffeItem,
                  ),
                ),
              );

              if (result != null && result is CoffeItem) {
                onUpdate(result);  // 수정된 항목을 업데이트합니다.
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              onDelete();  // 삭제 콜백 호출
              Navigator.pop(context);  // 삭제 후 상세 페이지 닫기
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              coffeItem.url ?? '',
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              coffeItem.title ?? '',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              coffeItem.description ?? '',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
