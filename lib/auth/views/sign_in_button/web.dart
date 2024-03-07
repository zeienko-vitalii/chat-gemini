// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:chat_gemini/auth/views/sign_in_button/stub.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in_web/web_only.dart' as web;

/// Renders a web-only SIGN IN button.
Widget buildSignInButton({HandleSignInFn? onPressed}) {
  return web.renderButton(
    configuration: web.GSIButtonConfiguration(
      shape: web.GSIButtonShape.pill,
    ),
  );
}
