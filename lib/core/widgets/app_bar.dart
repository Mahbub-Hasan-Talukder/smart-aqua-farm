import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CommonAppBar extends StatelessWidget {
  const CommonAppBar({super.key, required this.title});
  final String title;

  @override
  AppBar build(BuildContext context) {
    return _appBar(context);
  }

  AppBar _appBar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return AppBar(
      backgroundColor: colorScheme.primary,
      title: Text(
        title,
        style: textTheme.titleLarge?.copyWith(
          color: colorScheme.surface,
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: true,
      elevation: 0,
      leading:
          context.canPop()
              ? _backButton(colorScheme, context)
              : SizedBox.shrink(),
    );
  }

  IconButton _backButton(ColorScheme colorScheme, BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: colorScheme.surface),
      onPressed: () {
        context.pop();
      },
    );
  }
}
