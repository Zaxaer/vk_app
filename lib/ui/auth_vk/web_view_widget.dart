import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/domain/configuration/configuration.dart';
import 'package:vk_app/ui/auth_vk/web_view_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreenWidget extends StatelessWidget {
  const WebViewScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<WebViewWidgetViewModel>();
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) async {
            final uri = Uri.tryParse(request.url);
            if (uri == null ||
                uri.path != '/blank.html' ||
                uri.fragment.isEmpty) {
              return NavigationDecision.navigate;
            }
            final fragment = uri.fragment;
            var params = <String, String>{};
            for (var string in fragment.split("&")) {
              final array = string.split('=');
              if (array.length != 2) continue;
              final key = array[0];
              final value = array[1];
              if (key.isEmpty || value.isEmpty) continue;
              params[key] = value;
            }
            model.authParsUrl(
              request,
              context,
              params['access_token'],
              params['user_id'],
            );
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse(Configuration.authVkJoin));
    return Scaffold(
      body: SafeArea(
        child: WebViewWidget(controller: controller),
      ),
    );
  }
}
