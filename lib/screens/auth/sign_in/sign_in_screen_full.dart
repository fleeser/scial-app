import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:scial/themes/palette.dart';
import 'package:scial/widgets/custom_text_field.dart';
import 'package:scial/widgets/default_button.dart';
import 'package:scial/widgets/light_button.dart';

class SignInScreenFull extends StatelessWidget {

  final Function(String, String) signInPressed;
  final VoidCallback? obscurePressed;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isLoading;
  final bool obscureText;

  const SignInScreenFull({ 
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.signInPressed,
    required this.obscurePressed,
    required this.isLoading,
    required this.obscureText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'sign_in'.tr(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 42.0,
                    height: 1.0,
                    color: Palette.gray100
                  )
                )
              ),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'sign_in_description'.tr(),
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.6,
                    color: Palette.gray400
                  )
                )
              )
            ]
          )
        ),
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
          child: LightButton(
            text: '${'forgot_password'.tr()}?',
            fontSize: 14.0,
            color: Palette.gray400
          )
        ),
        Expanded(
          child: Column(
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
                  text: '${'no_account'.tr()}?',
                  color: Palette.gray400,
                  fontSize: 14.0
                )
              )
            ]
          )
        )
      ]
    );
  }
}