import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:scial/helpers.dart';
import 'package:scial/providers/providers.dart';
import 'package:scial/responsive/max_width_widget.dart';
import 'package:scial/responsive/responsive_layout.dart';
import 'package:scial/responsive/screen_details.dart';
import 'package:scial/screens/auth/sign_in/sign_in_screen_alternative.dart';
import 'package:scial/screens/auth/sign_in/sign_in_screen_full.dart';
import 'package:scial/screens/auth/sign_in/sign_in_screen_scroll.dart';
import 'package:scial/services/auth_service.dart';
import 'package:scial/themes/custom_system_ui_overlay_styles.dart';
import 'package:scial/themes/palette.dart';
import 'package:scial/widgets/custom_app_bar.dart';

class SignInScreen extends ConsumerWidget {

  SignInScreen({ Key? key }) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final TextStyle textStyle = TextStyle(fontSize: 14.0, color: Palette.gray400, height: 1.6);

  @override
  Widget build(BuildContext context, ScopedReader watch) {

    final AuthService authService = watch(authServiceProvider);
    final bool isLoading = watch(signInIsLoadingProvider);
    final bool obscureText = watch(signInObscureTextProvider);

    double textHeight = getTextHeight('sign_in_description'.tr(), textStyle, getMaxWidth(context));
    
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: CustomSystemUiOverlayStyles.dark,
      child: Scaffold(
        backgroundColor: Palette.gray900,
        body: Column(
          children: [
            CustomAppBar(
              hasBackButton: true,
              title: 'sign_in'.tr()
            ),
            Expanded(
              child: MaxWidthWidget(
                  child: ResponsiveLayout(
                  scroll: ScreenDetails(
                    widget: SignInScreenScroll(
                      emailController: emailController,
                      passwordController: passwordController,
                      isLoading: isLoading,
                      obscureText: obscureText,
                      signInPressed: (String email, String password) async => await signInPressed(context, authService, email: email, password: password),
                      obscurePressed: () => obscurePressed(context)
                    )
                  ),
                  alternative: ScreenDetails(
                    widgetsHeight: 24.0 + 52.0 + 24.0 + 52.0 + 24.0 + 14.0 + 24.0 + 52.0 + 24.0 + 14.0 + 24.0,
                    widget: SignInScreenAlternative(
                      emailController: emailController,
                      passwordController: passwordController,
                      isLoading: isLoading,
                      obscureText: obscureText,
                      signInPressed: (String email, String password) async => await signInPressed(context, authService, email: email, password: password),
                      obscurePressed: () => obscurePressed(context)
                    ),
                    hasAppBar: true
                  ),
                  full: ScreenDetails(
                    widgetsHeight: 24.0 + 42.0 + 24.0 + textHeight + 24.0 + 52.0 + 24.0 + 52.0 + 24.0 + 14.0 + 24.0 + 52.0 + 24.0 + 14.0 + 24.0,
                    widget: SignInScreenFull(
                      emailController: emailController,
                      passwordController: passwordController,
                      isLoading: isLoading,
                      obscureText: obscureText,
                      signInPressed: (String email, String password) async => await signInPressed(context, authService, email: email, password: password),
                      obscurePressed: () => obscurePressed(context)
                    ),
                    hasAppBar: true
                  )
                )
              )
            )
          ]
        )
      )
    );
  }
}

Future<void> signInPressed(BuildContext context, AuthService authService, { required String email, required String password }) async {
  context.read(signInIsLoadingProvider.notifier).trigger();

  await authService.signIn(email: email, password: password);

  context.read(signInIsLoadingProvider.notifier).trigger();
}

void obscurePressed(BuildContext context) => context.read(signInObscureTextProvider.notifier).trigger();