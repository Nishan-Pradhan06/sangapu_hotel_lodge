import 'package:flutter/material.dart';

import 'custom_button.dart';
import 'custom_container.dart';

class UpgradePremiumButtonWidget extends StatelessWidget {
  const UpgradePremiumButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: EdgeInsetsGeometry.all(0),
      isGradient: true,
      gradientColors: [Color(0xFFFF7E5F), Color(0xFFFFB347)],
      child: Center(
        child: Column(
          spacing: 10,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Unlock All Meditations',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFFFFF),
              ),
            ),
            Text(
              'Get unlimited access to all guided meditations and exclusive content',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 16,
                color: Color(0xFFFFFFFF),
              ),
            ),

            CustomButton(
              height: 45,
              backgroundColor: Colors.white,
              width: 140,
              textColor: Color(0xFFFF7E5F),
              text: 'Upgrade Now',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
