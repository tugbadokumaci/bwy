import 'package:bwy/extension/context_extension.dart';
import 'package:flutter/material.dart';

class MyButtonWidget extends StatelessWidget {
  final BuildContext context;
  final Color buttonColor;
  final Widget content;
  final Color? borderColor;
  final void Function()? onPressed;
  final bool enabled;

  const MyButtonWidget({
    required this.context,
    required this.buttonColor,
    required this.content,
    this.borderColor,
    required this.onPressed,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 350),
      child: SizedBox(
        height: 50,
        width: context.buttonWidth,
        child: ElevatedButton(
          onPressed: enabled ? onPressed : null,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: BorderSide(
                  color: (borderColor == null) ? buttonColor : borderColor!,
                  width: 1.0,
                ),
              ),
            ),
          ),
          child: Center(
            child: content,
          ),
        ),
      ),
    );
  }
}
