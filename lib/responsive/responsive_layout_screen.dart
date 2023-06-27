import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/utils/global_variables.dart';
import 'package:social_flow/providers/user_provider.dart';

class ResponsiveLayout extends StatefulWidget {
  const ResponsiveLayout({super.key, required this.mobileScreenLayout, required this.webScreenLayout});

  final Widget mobileScreenLayout;
  final Widget webScreenLayout;

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    addData();
    super.initState();
  }

  addData() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webSreenSize) {
          return widget.webScreenLayout;
        }
        return widget.mobileScreenLayout;
      },
    );
  }
}
