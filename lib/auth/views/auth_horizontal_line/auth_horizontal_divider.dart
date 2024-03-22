import 'package:chat_gemini/auth/views/auth_horizontal_line/horizontal_divider.dart';
import 'package:flutter/material.dart';

class AuthHorizontalDivider extends Row {
  const AuthHorizontalDivider({super.key})
      : super(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Flexible(flex: 2, child: HorizontalDivider()),
            Expanded(child: Center(child: Text('OR'))),
            Flexible(flex: 2, child: HorizontalDivider()),
          ],
        );
}
