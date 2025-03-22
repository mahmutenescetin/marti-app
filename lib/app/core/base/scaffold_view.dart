import 'package:flutter/material.dart';
import 'package:marti_app/app/core/base/custom_app_bar.dart' show CustomAppBar;

class ScaffoldView extends StatelessWidget {
  final String? appBarTitle;
  final List<Widget>? appBarActions;
  final Widget? appBarLeading;
  final bool appBarCenterTitle;
  final PreferredSizeWidget? appBarBottom;
  final Color? appBarBackgroundColor;
  final double? appBarElevation;
  final bool appBarAutomaticallyImplyLeading;
  final Widget body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;
  final Widget? drawer;
  final Widget? endDrawer;
  final bool extendBody;
  final bool extendBodyBehindAppBar;

  const ScaffoldView({
    required this.body, super.key,
    this.appBarTitle,
    this.appBarActions,
    this.appBarLeading,
    this.appBarCenterTitle = true,
    this.appBarBottom,
    this.appBarBackgroundColor,
    this.appBarElevation,
    this.appBarAutomaticallyImplyLeading = true,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
    this.drawer,
    this.endDrawer,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarTitle != null
          ? CustomAppBar(
              title: appBarTitle,
              actions: appBarActions,
              leading: appBarLeading,
              centerTitle: appBarCenterTitle,
              bottom: appBarBottom,
              backgroundColor: appBarBackgroundColor,
              elevation: appBarElevation,
              automaticallyImplyLeading: appBarAutomaticallyImplyLeading,
            )
          : null,
      body: body,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      drawer: drawer,
      endDrawer: endDrawer,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
    );
  }
}
