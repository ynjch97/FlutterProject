import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  final String name, code, amount;
  final IconData icon;
  final int order;

  // 자주 사용하는 color 상수값을 변수로 등록
  final _blackColor = const Color(0xFF1F2123);

  final double _offsetY; // Transform.translate Offset Y 값
  final bool _isInverted; // 색상 반전 여부

  CurrencyCard({
    super.key,
    required this.name,
    required this.code,
    required this.amount,
    required this.icon,
    required this.order,
  })  : _offsetY = (order - 1) * -20,
        _isInverted = order.isEven;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, _offsetY),
      child: Container(
        // clipBehavior: overflow 된 아이템에 대해 어떻게 동작하게 할건지 알려주는 장치
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: _isInverted ? Colors.white : _blackColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: _isInverted ? _blackColor : Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        amount,
                        style: TextStyle(
                          color: _isInverted ? _blackColor : Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        code,
                        style: TextStyle(
                          color: _isInverted
                              ? _blackColor
                              : Colors.white.withOpacity(0.8),
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Transform.scale(
                // 아이콘이 overflow 되도록 transform.scale Widget 추가 (scale 설정 필수)
                scale: 2.2,
                child: Transform.translate(
                  // 아이콘이 이동되도록 transform.translate Widget 추가 (offset 설정 필수)
                  offset: const Offset(-5, 12),
                  child: Icon(
                    icon,
                    color: _isInverted ? _blackColor : Colors.white,
                    size: 88,
                    // size 조절 : 카드 등 주변 요소까지 함께 커짐 -> transform : 해당 요소만 overflow 및 move
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
