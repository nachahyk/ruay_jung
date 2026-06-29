import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final String? title;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;
  final bool safeAreaTop;
  final bool safeAreaBottom;
  final bool showBackButton;

  const AppScaffold({
    super.key,
    required this.body,
    this.title,
    this.actions,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
    this.drawer,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
    this.safeAreaTop = true,
    this.safeAreaBottom = true,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? context.appColors.background,
      appBar: title != null || showBackButton
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: title != null ? Text(title!) : null,
              actions: actions,
              leading: showBackButton
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        if (context.canPop()) {
                          context.pop();
                        }
                      },
                    )
                  : null,
            )
          : null,
      drawer: drawer,
      body: SafeArea(
        top: safeAreaTop,
        bottom: safeAreaBottom,
        child: body,
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }
}
