// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/custom_loading_widget.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/widget/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

class BookLinkViewerBody extends StatefulWidget {
  const BookLinkViewerBody({super.key, required this.bookUrl});

  final String bookUrl;

  @override
  State<BookLinkViewerBody> createState() => _BookLinkViewerBodyState();
}

class _BookLinkViewerBodyState extends State<BookLinkViewerBody> {
  late InAppWebViewController _webViewController;
  double _progress = 0;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InAppWebView(
          initialUrlRequest: URLRequest(
            url: WebUri(widget.bookUrl),
          ),
          initialSettings: InAppWebViewSettings(
            javaScriptEnabled: true,
            useOnLoadResource: true,
            supportZoom: true,
            builtInZoomControls: true,
            displayZoomControls: false,
            loadWithOverviewMode: true,
            useWideViewPort: true,
          ),
          onWebViewCreated: (controller) {
            _webViewController = controller;
          },
          onLoadStart: (controller, url) {
            setState(() {
              _isLoading = true;
              _hasError = false;
            });
          },
          onProgressChanged: (controller, progress) {
            setState(() {
              _progress = progress / 100;
            });
          },
          onLoadStop: (controller, url) {
            setState(() {
              _isLoading = false;
            });
          },
          onReceivedError: (controller, request, error) {
            setState(() {
              _isLoading = false;
              _hasError = true;
            });
          },
        ),
        if (_isLoading)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomLoadingWidget(),
                heightBox(16),
                Text(
                  '${(_progress * 100).toInt()}%',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        if (_hasError)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 70.sp,
                  color: Colors.red,
                ),
                heightBox(16),
                const Text(
                  'Failed to load book',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                heightBox(8),
                const Text(
                  'Please check your internet connection',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                heightBox(25),
                CustomButton(
                  text: 'Retry',
                  onPressed: () {
                    _webViewController.reload();
                  },
                ),
                heightBox(8),
                CustomButton(
                  text: 'Open in browser',
                  onPressed: () async {
                    final uri = Uri.parse(widget.bookUrl);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(
                        uri,
                        mode: LaunchMode.externalApplication,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }
}
