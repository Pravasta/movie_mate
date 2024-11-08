import 'package:flutter/material.dart';
import 'package:movie_mate/data/model/response/order_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentBankTransfer extends StatefulWidget {
  const PaymentBankTransfer({super.key, required this.order});

  final OrderModel order;

  @override
  State<PaymentBankTransfer> createState() => _PaymentBankTransferState();
}

class _PaymentBankTransferState extends State<PaymentBankTransfer> {
  WebViewController _controller = WebViewController();

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://flutter.dev'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: _controller),
    );
  }
}
