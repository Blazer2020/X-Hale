import 'package:flutter/material.dart';

// Custom Widget that encapsulates the FilledButton with specific styles
class FilledButtonPrimary extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const FilledButtonPrimary(
      {Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double
          .infinity, // Makes the button fill the width of its parent container
      child: FilledButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).colorScheme.onSecondary),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.all(18)),
          ),
          child: Text(text, style: Theme.of(context).textTheme.bodyLarge)),
    );
  }
}

class FilledButtonSecondary extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const FilledButtonSecondary(
      {Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double
          .infinity, // Makes the button fill the width of its parent container
      child: FilledButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              Theme.of(context).colorScheme.primary),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.all(18)),
        ),
        child: Text(text,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.white)),
      ),
    );
  }
}

class OutlinedButtonPrimary extends StatelessWidget {
  final VoidCallback onPressed;
  final ButtonStyle? style;
  final Widget child;

  const OutlinedButtonPrimary(
      {Key? key, required this.onPressed, required this.child, this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.all(16)),
        side: MaterialStateProperty.all<BorderSide>(BorderSide(
            color:
                Theme.of(context).colorScheme.shadow)), // Add border color here
      ),
      child: child,
    );
  }
}
