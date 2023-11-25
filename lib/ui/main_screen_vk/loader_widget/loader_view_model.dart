import 'package:flutter/material.dart';
import 'package:vk_app/domain/services/auth_services.dart';
import 'package:vk_app/navigation/main_navigation.dart';

class LoaderViewModel {
  final BuildContext context;
  final _authServices = AuthServices();
  LoaderViewModel(this.context) {
    asyncInit();
  }

  Future<void> asyncInit() async {
    await checkAuth();
  }

  Future<void> checkAuth() async {
    final sessionId = await _authServices.getToken();
    final isAuth = sessionId == null;
    final nextScreen = !isAuth
        ? MainNavigationRouteNames.mainScreenVK
        : MainNavigationRouteNames.authVK;
    if (!context.mounted) return;
    Navigator.of(context).pushReplacementNamed(nextScreen);
  }
}
