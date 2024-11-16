import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saree/providers/auth_provider.dart';
import 'package:saree/screens/chose_service_screen.dart';

import '../widgets/components/loading_animation.dart';

class LoadingScreenArguments {
  bool getUserData;

  LoadingScreenArguments({this.getUserData = false});
}

class LoadingScreen extends StatefulWidget {
  final LoadingScreenArguments? arguments;
  static const routeName = "/loading";

  const LoadingScreen(this.arguments, {super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.arguments != null) {
        if (widget.arguments!.getUserData) {
          Provider.of<AuthProvider>(context, listen: false).getUserInfo().then(
                (val) {Navigator.pushReplacementNamed(context, ChoseServiceScreen.routeName);},
              );
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const PopScope(
      canPop: false,
      child: Scaffold(
        body: LoadingAnimation(),
      ),
    );
  }
}
