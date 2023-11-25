import 'package:flutter/material.dart';
import 'package:vk_app/navigation/main_navigation.dart';
import 'package:vk_app/ui/theme/style.dart';

class AuthWidgetWidget extends StatelessWidget {
  const AuthWidgetWidget({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 60,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'вконтакте',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
      body: _VkBodyWidget(),
    );
  }
}

class _VkBodyWidget extends StatelessWidget {
  final colorstyle = ColorStyleAuth();
  final decorator = TextFielsDecorator();
  _VkBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            _MainScreenWidget(),
          ],
        ),
      ),
    );
  }
}

class _MainScreenWidget extends StatelessWidget {
  final bottomStyle = BottonStyle();

  _MainScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 10),
          const Text(
            'Мобильная версия поможет вам оставаться ВКонтакте, даже если вы далеко от компьютера.',
            style: TextStyle(color: Color(0xff5D5F61), fontSize: 17),
          ),
          const SizedBox(height: 16),
          _EnterButtonWidget(bottomStyle: bottomStyle),
          const SizedBox(height: 5),
          _RespPassButtonWidget(bottomStyle: bottomStyle),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Впервые ВКонтакте?',
              style: TextStyle(
                color: bottomStyle.greyTFColor,
                fontSize: 17,
              ),
            ),
          ),
          const SizedBox(height: 8),
          _RegistrationButtonWidget(bottomStyle: bottomStyle),
          const SizedBox(height: 12),
          _EnterFacebookButtonWidget(bottomStyle: bottomStyle),
        ],
      ),
    );
  }
}

class _EnterFacebookButtonWidget extends StatelessWidget {
  const _EnterFacebookButtonWidget({Key? key, required this.bottomStyle})
      : super(key: key);

  final BottonStyle bottomStyle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: bottomStyle.bottomStyle(
        bottomStyle.whiteColor,
        bottomStyle.pressButtonColor,
        bottomStyle.borderButtonColor,
      ),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Войти через Facebook',
            style: TextStyle(color: bottomStyle.blueColor),
          ),
        ],
      ),
    );
  }
}

class _RegistrationButtonWidget extends StatelessWidget {
  const _RegistrationButtonWidget({Key? key, required this.bottomStyle})
      : super(key: key);

  final BottonStyle bottomStyle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: bottomStyle.bottomStyle(bottomStyle.greenColor,
          bottomStyle.pressButtonColor, bottomStyle.greenColor),
      onPressed: () {},
      child: const Text(
        'Зарегистрироваться',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

class _RespPassButtonWidget extends StatelessWidget {
  const _RespPassButtonWidget({Key? key, required this.bottomStyle})
      : super(key: key);

  final BottonStyle bottomStyle;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        'Забыли пароль?',
        style: TextStyle(
            color: bottomStyle.blueColor,
            fontWeight: FontWeight.w300,
            fontSize: 17),
      ),
    );
  }
}

class _EnterButtonWidget extends StatelessWidget {
  const _EnterButtonWidget({Key? key, required this.bottomStyle})
      : super(key: key);

  final BottonStyle bottomStyle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: bottomStyle.bottomStyle(bottomStyle.blueColor,
          bottomStyle.pressButtonColor, bottomStyle.blueColor),
      onPressed: () => Navigator.pushNamedAndRemoveUntil(
          context, MainNavigationRouteNames.webView, (route) => false),
      child: const Text(
        'Войти',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
