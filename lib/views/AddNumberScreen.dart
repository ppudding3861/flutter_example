import 'package:flutter/material.dart';
import 'package:h_flutter_example_project/controllers/NumberViewModel.dart';
import 'package:h_flutter_example_project/widgets/CameraWidget.dart';
import 'package:h_flutter_example_project/widgets/FormWidget.dart';
import 'package:provider/provider.dart';

class AddNumberScreen extends StatefulWidget {
  @override
  _AddNumberScreenState createState() => _AddNumberScreenState();
}

class _AddNumberScreenState extends State<AddNumberScreen> {
  final _numberForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // 화면이 처음 열릴 때 폼을 초기화합니다.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<NumberViewModel>(context, listen: false);
      viewModel.resetNumberItem(); // 폼 초기화
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NumberViewModel>(context);

    return ListView(
      children: [
        Form(
          key: _numberForm,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CameraWidget(
                  imagePath: viewModel.numberItem?.image,
                  setMethod: viewModel.setImage,
                ),
                _buildFormField("이름", "", viewModel.setTitle, "이름을 입력하세요"),
                _buildFormField("전화번호",  "", viewModel.setPhoneNumber, "전화번호를 입력하세요"),
                _buildFormField("내용",  "", viewModel.setDescription, "내용을 입력하세요"),
                ElevatedButton(
                  onPressed: () {
                    if (_numberForm.currentState!.validate()) {
                      viewModel.saveForm(_numberForm, context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('모든 필드를 올바르게 입력하세요')),
                      );
                    }
                  },
                  child: const Text("저장"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // 폼 필드를 생성하는 함수
  Widget _buildFormField(String label, String initialValue, Function(String?) setValue, String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        FormWidget(
          value: initialValue,
          setValue: setValue,
          hintText: hintText,
        ),
      ],
    );
  }
}
