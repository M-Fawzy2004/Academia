import 'package:flutter/material.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/feature/book_details/presentation/view/widget/book_link_viewer_body.dart';

class BookLinkViewer extends StatelessWidget {
  const BookLinkViewer({
    super.key,
    required this.bookUrl,
    required this.bookTitle,
  });

  final String bookUrl;
  final String bookTitle;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Book Link Viewer',
          style: Styles.font14PrimaryColorTextBold(context),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: BookLinkViewerBody(bookUrl: bookUrl),
      ),
    );
  }
}
