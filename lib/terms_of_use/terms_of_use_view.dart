import 'package:auto_route/auto_route.dart';
import 'package:chat_gemini/app/views/custom_app_bar.dart';
import 'package:chat_gemini/terms_of_use/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

@RoutePage(name: 'terms')
class TermsOfUseView extends StatelessWidget {
  const TermsOfUseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context, title: 'Terms of Use'),
      body: const Markdown(
        data: termsOfUse,
      ),
    );
  }
}
