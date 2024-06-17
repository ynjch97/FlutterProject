import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class Avatar extends ConsumerWidget {
  final String name;

  const Avatar({
    super.key,
    required this.name,
  });

  Future<void> _onAvatarTap() async {
    final xfile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40, // 이미지 용량 설정 (40% 의 퀄리티로 저장)
      maxHeight: 150,
      maxWidth: 150,
    );

    if (xfile != null) {
      final file = File(xfile.path); // 업로드할 실제 파일 만들기
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: _onAvatarTap,
      child: CircleAvatar(
        radius: 50,
        foregroundImage: const NetworkImage(
          "https://avatars.githubusercontent.com/u/69029517",
        ),
        child: Text(name),
      ),
    );
  }
}
