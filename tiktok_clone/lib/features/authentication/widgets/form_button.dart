import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class FormButton extends StatelessWidget {
  const FormButton({
    super.key,
    required this.disabled,
    required this.label,
  });

  final bool disabled;
  final String label;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      /**AnimatedContainer
       * - decoration 이 변경되었을 때 애니메이션 효과가 적용됨
       * - AnimatedContainer 의 효과가 자식에게까지 영향을 주진 않음
       */
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: Sizes.size16),
        decoration: BoxDecoration(
          color:
              disabled ? Colors.grey.shade300 : Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(3),
        ),
        /**AnimatedDefaultTextStyle
         * - text 가 변경되었을 때 애니메이션 효과가 적용됨
         */
        child: AnimatedDefaultTextStyle(
          // style : 애니메이션화 시키고 싶은 대상
          style: TextStyle(
            color: disabled ? Colors.grey.shade400 : Colors.white,
            fontWeight: FontWeight.w600,
          ),
          duration: const Duration(milliseconds: 300),
          child: Text(
            label,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
