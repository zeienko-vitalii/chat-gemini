import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class UnsupportedLocationWidget extends StatelessWidget {
  const UnsupportedLocationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            'assets/images/map_pointer_bg.png',
            height: 164,
          ),
          const Gap(20),
          Text(
            'Unsupported location',
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          const Gap(20),
          Text(
            'We do not support this location yet.',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
