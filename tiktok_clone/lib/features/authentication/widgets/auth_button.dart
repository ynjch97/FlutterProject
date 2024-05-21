import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final FaIcon icon;

  const AuthButton({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    /**FractionallySizedBox
     * - 양옆의 여유 공간을 다 사용
     * - 부모 크기에 비례해 크기를 정하는 Box 위젯
     */
    return FractionallySizedBox(
      widthFactor: 1, // 1이면 100%, 0.5면 50% 공간을 차지
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size14,
          horizontal: Sizes.size14,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
            width: Sizes.size1,
          ),
        ),
        child: Stack(
          /**Row, Column : 가로, 세로로 차례대로 배치
           * Stack : 위젯을 위에 쌓을 수 있게 함
           */
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              /**font_awesome_flutter : 무료 아이콘(브랜드 로고 포함) 사용을 위해 패키지 설치
               * - FaIcon(FontAwesomeIcons.amazon)
               * - 아이콘 이름은 FontAwesome 사이트에서 검색하여 사용
               */
              child: icon,
            ),
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
