import 'package:flutter/material.dart';

import '../../../../colors/app_colors.dart';

class Button extends StatelessWidget {
  final IconData icon;
  final Function() onTap;
  const Button({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.widgetsBackColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: IconButton(
        splashRadius: 16,
        onPressed: onTap,
        icon: Icon(
          icon,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
