import 'package:auto_route/auto_route.dart';
import 'package:chat_gemini/app/views/custom_app_bar.dart';
import 'package:chat_gemini/privacy_policy/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

@RoutePage(name: 'privacy')
class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context, title: 'Privacy Policy'),
      body: const Markdown(
        data: privacyPolicy,
      ),
    );
  }
}
