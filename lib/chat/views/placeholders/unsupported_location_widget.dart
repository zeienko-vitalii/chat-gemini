import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class UnsupportedLocationWidget extends StatelessWidget {
  const UnsupportedLocationWidget({
    this.onReload,
    super.key,
  });

  final VoidCallback? onReload;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onReload,
                    child: const Text('Reload'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
