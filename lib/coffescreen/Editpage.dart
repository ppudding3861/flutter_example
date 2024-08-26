import 'package:flutter/material.dart';
import '../model/CoffeItem.dart';

class Editpage extends StatefulWidget {
  final CoffeItem? initialCoffeItem;

  const Editpage({super.key, this.initialCoffeItem});

  @override
  State createState() => _EditPageState();
}

class _EditPageState extends State<Editpage> {
  late TextEditingController titleController;
  late TextEditingController urlController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.initialCoffeItem?.title);
    urlController = TextEditingController(text: widget.initialCoffeItem?.url);
    descriptionController = TextEditingController(text: widget.initialCoffeItem?.description);
  }

  void submitData() {
    final updatedCoffeItem = CoffeItem(
      title: titleController.text,
      url: urlController.text,
      description: descriptionController.text,
    );

    Navigator.pop(context, updatedCoffeItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("글 수정 / Edit Post"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              textAlign: TextAlign.center,
              controller: titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "제목 입력 / Enter Title",
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              textAlign: TextAlign.center,
              controller: urlController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "URL 입력 / Enter URL",
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              textAlign: TextAlign.center,
              controller: descriptionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "설명 입력 / Enter Description",
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: submitData,
              child: const Text('제출 / Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
