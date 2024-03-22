import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class InvalidApiKeyWidget extends StatelessWidget {
  const InvalidApiKeyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.key_off_rounded,
            size: 164,
          ),
          const Gap(20),
          Text(
            'Invalid API key',
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          const Gap(20),
          Text(
            'Please provide a valid API key in the environment variables.',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
