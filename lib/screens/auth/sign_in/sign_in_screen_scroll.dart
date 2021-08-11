import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:scial/helpers.dart';
import 'package:scial/providers/providers.dart';
import 'package:scial/themes/palette.dart';
import 'package:scial/widgets/custom_text_field.dart';
import 'package:scial/widgets/default_button.dart';
import 'package:scial/widgets/light_button.dart';

class SignInScreenScroll extends ConsumerWidget {

  final Function(String, String) signInPressed;
  final VoidCallback? obscurePressed;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isLoading;
  final bool obscureText;

  const SignInScreenScroll({ 
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.signInPressed,
    required this.obscurePressed,
    required this.isLoading,
    required this.obscureText
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {

    final bool isLoading = watch(signInIsLoadingProvider);
    
    return SingleChildScrollView(
      child: Container(
        height: getNeededScrollHeight(context, widgetsHeight: 24.0 + 52.0 + 24.0 + 52.0 + 24.0 + 14.0 + 24.0 + 52.0 + 24.0 + 14.0 + 24.0, hasAppBar: true),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    hintText: 'email'.tr(),
                    controller: emailController,
                    icon: Icons.email_rounded,
                    textInputType: TextInputType.emailAddress
                  ),
                  SizedBox(height: 24.0),
                  CustomTextField(
                    isPasswordField: true,
                    controller: passwordController,
                    hintText: 'password'.tr(),
                    icon: Icons.lock_rounded,
                    obscureText: obscureText,
                    obscurePressed: obscurePressed
                  ),
                  SizedBox(height: 24.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width - getMaxWidth(context)) / 2.0),
                      child: LightButton(
                        text: 'forgot_password'.tr(),
                        fontSize: 14.0,
                        color: Palette.gray400
                      )
                    )
                  )
                ]
              )
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DefaultButton(
                  onPressed: () => signInPressed(emailController.text, passwordController.text),
                  isLoading: isLoading,
                  text: 'sign_in'.tr()
                ),
                SizedBox(height: 24.0),
                Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 24.0),
                  child: LightButton(
                    text: 'no_account'.tr(),
                    color: Palette.gray400,
                    fontSize: 14.0
                  )
                )
              ]
            )
          ]
        )
      )
    );
  }
}