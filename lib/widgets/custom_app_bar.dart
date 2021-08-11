import 'package:flutter/material.dart';

import 'package:scial/themes/palette.dart';

class CustomAppBar extends StatelessWidget {

  final bool hasBackButton;
  final String? title;

  CustomAppBar({
    this.hasBackButton = false, 
    this.title
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).padding.top + kToolbarHeight,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: MediaQuery.of(context).padding.left + 24.0,
        right: MediaQuery.of(context).padding.right + 24.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          hasBackButton ? backButton(context) : title == null ? Container() : titleText,
          Expanded(
            child: Center(
              child: hasBackButton ? title == null ? Container() : titleText : Container(),
            )
          ),
          hasBackButton ? Container(width: kToolbarHeight - 20.0) : Container()
        ]
      )
    );
  }

  Widget backButton(BuildContext context) {
    return CustomAppBarButton(
      icon: Icons.arrow_back_rounded,
      onPressed: () => print('I should go back')
    );
  }

  Widget get titleText {
    return Text(
      title!,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Inter',
        fontSize: kToolbarHeight - 34.0,
        fontWeight: FontWeight.bold,
        color: Palette.gray100,
        height: 1.0
      )
    );
  }
}

class CustomAppBarButton extends StatelessWidget {

  final IconData icon;
  final VoidCallback onPressed;
  final Color color;

  CustomAppBarButton({
    required this.icon,
    required this.onPressed,
    this.color = Palette.gray100
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: kToolbarHeight - 20.0,
      height: kToolbarHeight - 20.0,
      child: RawMaterialButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            width: 2.0,
            color: Palette.gray600
          )
        ),
        child: Icon(
          icon,
          size: kToolbarHeight - 34.0,
          color: color
        )
      )
    );
  }
}