import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraWidget extends StatefulWidget {
  String? imagePath;
  final Function(String?) setMethod; // 명확히 타입을 지정합니다.

  CameraWidget({required this.imagePath, required this.setMethod, Key? key}) : super(key: key);

  @override
  _CameraWidgetState createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  late CameraController _controller;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      _controller = CameraController(cameras[0], ResolutionPreset.high);
      _initializeControllerFuture = _controller.initialize();
      setState(() {});
    } catch (e) {
      print('카메라 초기화 실패: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 500,
          child: FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.done) {
                // 이미지를 표시하거나 카메라 프리뷰를 표시
                if (widget.imagePath != null) {
                  return Image.file(File(widget.imagePath!), fit: BoxFit.cover);
                }
                return CameraPreview(_controller);
              } else {
                return const Center(child: Text('카메라 초기화 실패'));
              }
            },
          ),
        ),
        const SizedBox(height: 16),
        widget.imagePath == null
            ? FloatingActionButton(
          onPressed: () async {
            try {
              await _initializeControllerFuture;
              final image = await _controller.takePicture();
              widget.setMethod(image.path); // 이미지 경로를 전달
            } catch (e) {
              print('이미지 캡처 실패: $e');
            }
          },
          child: const Icon(Icons.camera),
        )
            : IconButton(
          icon: const Icon(Icons.cancel_presentation),
          onPressed: () {
            widget.setMethod(null); // 이미지 경로를 초기화 (null 전달)
          },
        ),
      ],
    );
  }
}
