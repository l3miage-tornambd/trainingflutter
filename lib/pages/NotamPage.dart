import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NotamPage extends StatefulWidget {
  final String url;
  final String title;

  const NotamPage({super.key, required this.url, required this.title});

  @override
  State<NotamPage> createState() => _NotamPageState();
}

class _NotamPageState extends State<NotamPage> {

  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            print('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          onHttpError: (HttpResponseError error) {
            print('HTTP error: $error');
          },
          onWebResourceError: (WebResourceError error) {
            print('Web Resource error: $error');
          },
        ),
      )
    ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}

