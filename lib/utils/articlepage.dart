import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticlePage extends StatefulWidget {
  final String url;

  const ArticlePage({super.key, required this.url});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  bool isLoading = true; // Track loading state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Article Page"),
      ),
      body: Stack(
        children: [
          WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: widget.url,
            onPageStarted: (url) {
              setState(() {
                isLoading = true;
              });
            },
            onPageFinished: (url) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(
                backgroundColor: Color.fromARGB(255, 15, 124, 167),
                strokeCap: StrokeCap.round,
                valueColor: AlwaysStoppedAnimation<Color?>(Colors.white),
                strokeWidth: 6,
              ),
            ),
        ],
      ),
    );
  }
}
