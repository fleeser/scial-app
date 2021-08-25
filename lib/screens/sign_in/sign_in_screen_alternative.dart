import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:scial/themes/palette.dart';
import 'package:scial/widgets/custom_field/custom_password_field.dart';
import 'package:scial/widgets/custom_field/custom_text_field.dart';
import 'package:scial/widgets/default_button/default_button.dart';
import 'package:scial/widgets/light_button.dart';

class SignInScreenAlternative extends ConsumerWidget {

  final void Function() signInPressed;
  final void Function() obscurePasswordPressed;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isLoading;
  final bool obscurePassword;

  const SignInScreenAlternative({ 
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.signInPressed,
    required this.obscurePasswordPressed,
    required this.isLoading,
    required this.obscurePassword
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Column(
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
              CustomPasswordField(
                controller: passwordController,
                hintText: 'password'.tr(),
                icon: Icons.lock_rounded,
                obscurePassword: obscurePassword,
                obscurePasswordPressed: obscurePasswordPressed
              ),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.centerRight,
                child: LightButton(
                  text: 'forgot_password'.tr(),
                  fontSize: 14.0,
                  color: Palette.gray400
                )
              )
            ]
          )
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DefaultButton(
              onPressed: signInPressed,
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
    );
  }
}