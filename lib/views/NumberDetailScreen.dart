import 'dart:io';
import 'package:flutter/material.dart';
import 'package:h_flutter_example_project/models/NumberItem.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class NumberDetailScreen extends StatelessWidget {
  final NumberItem? numberItem;

  NumberDetailScreen({required this.numberItem, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 이미지 위젯을 반환하는 함수
    Widget buildImageWidget() {
      if (numberItem!.image == null || numberItem!.image!.isEmpty) {
        return Container(
          width: double.infinity,
          height: 500,
          color: Colors.grey[300],
          child: const Center(
            child: Text(
              "이미지가 없습니다.",
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
          ),
        );
      } else {
        bool isFile = numberItem!.image.toString().startsWith("file://") ||
            File(numberItem!.image.toString()).existsSync();

        return isFile
            ? FutureBuilder<File>(
          future: File(numberItem!.image.toString()).existsSync()
              ? Future.value(File(numberItem!.image.toString()))
              : Future.error('파일 없음'),
          builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('이미지 로드 실패'));
            } else if (snapshot.hasData) {
              return Image.file(
                snapshot.data!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 500,
              );
            } else {
              return const Center(child: Text('파일 없음'));
            }
          },
        )
            : Image.network(
          numberItem!.image.toString(),
          fit: BoxFit.cover,
          width: double.infinity,
          height: 500,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                    (loadingProgress.expectedTotalBytes ?? 1)
                    : null,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) => const Center(
            child: Text('이미지 로드 실패'),
          ),
        );
      }
    }

    // 전화번호로 전화를 거는 함수
    Future<void> _makePhoneCall() async {
      final uri = Uri.parse("tel:+82${numberItem!.phoneNumber}");
      var status = await Permission.phone.request();
      if (status.isGranted) {
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("전화걸기 실패")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("권한을 승인해주세요")),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(numberItem!.title.toString()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 300,
              child: buildImageWidget(),
            ),
            const SizedBox(height: 16),
            Text(
              "전화번호",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "+82 ${numberItem!.phoneNumber}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                IconButton(
                  onPressed: _makePhoneCall,
                  icon: Icon(Icons.call, color: Theme.of(context).primaryColor),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              "설명",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              numberItem!.description.toString(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
