import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_flutter_example_project/controllers/NumberViewModel.dart';
import 'package:h_flutter_example_project/controllers/FavoriteViewModel.dart';
import 'package:h_flutter_example_project/models/NumberItem.dart';
import 'package:h_flutter_example_project/widgets/ImageWidget.dart';
import 'package:provider/provider.dart';

class NumberWidget extends StatelessWidget {
  final NumberItem numberItem;
  final int index;

  const NumberWidget({required this.numberItem, required this.index, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteViewModel = Provider.of<FavoriteViewModel>(context);
    final numberViewModel = Provider.of<NumberViewModel>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark; // 다크 모드 여부 확인

    bool isTrue = favoriteViewModel.isFavorite(index);

    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white10,
        border: Border.all(color: Colors.black, width: 2.0),
      ),
      child: ElevatedButton(
        onPressed: () => numberViewModel.detailsNumberItem(context, index),
        child: Center(
          child: Row(
            children: [
              Text("$index"),
              ImageWidget(image: numberItem.image.toString()),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("이름 : ${numberItem.title}"),
                    Text("전화번호 : ${numberItem.phoneNumber}"),
                    Text(
                      "내용 : ${numberItem.description}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: IconButton(
                  onPressed: () {
                    favoriteViewModel.toggleFavorite(index);
                  },
                  icon: Icon(
                    isTrue ? Icons.star : Icons.star_border,
                    color: isDarkMode ? Colors.white : (isTrue ? Colors.red : Colors.black), // 다크 모드 시 아이콘 색상 변경
                  ),
                ),
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: IconButton(
                  onPressed: () {
                    numberViewModel.deleteItem(context, index - 1);
                  },
                  icon: Icon(
                    Icons.cancel,
                    color: isDarkMode ? Colors.white : Colors.black, // 다크 모드 시 아이콘 색상 변경
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
