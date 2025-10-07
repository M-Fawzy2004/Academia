import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/custom_loading_widget.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';

class PdfViewer extends StatefulWidget {
  const PdfViewer({
    super.key,
    required this.pdfUrl,
    required this.fileName,
  });

  final String pdfUrl;
  final String fileName;

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  int _currentPage = 1;
  int _totalPages = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _pdfViewerController.addListener(_updatePageInfo);
  }

  void _updatePageInfo() {
    if (_pdfViewerController.pageNumber != _currentPage) {
      setState(() {
        _currentPage = _pdfViewerController.pageNumber;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.getBackgroundColor(context),
      appBar: AppBar(
        backgroundColor: AppColors.getBackgroundColor(context),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.fileName,
              style: Styles.font16PrimaryColorTextBold(context),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (_totalPages > 0)
              Text(
                'Page $_currentPage of $_totalPages',
                style: Styles.font13GreyBold(context),
              ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.zoom_in_rounded),
            onPressed: () {
              _pdfViewerController.zoomLevel =
                  _pdfViewerController.zoomLevel + 0.25;
            },
          ),
          IconButton(
            icon: const Icon(Icons.zoom_out_rounded),
            onPressed: () {
              if (_pdfViewerController.zoomLevel > 1) {
                _pdfViewerController.zoomLevel =
                    _pdfViewerController.zoomLevel - 0.25;
              }
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          SfPdfViewer.network(
            widget.pdfUrl,
            controller: _pdfViewerController,
            onDocumentLoaded: (PdfDocumentLoadedDetails details) {
              setState(() {
                _totalPages = details.document.pages.count;
                _isLoading = false;
              });
            },
            onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
              setState(() {
                _isLoading = false;
              });
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error loading PDF: ${details.description}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            onPageChanged: (PdfPageChangedDetails details) {
              setState(() {
                _currentPage = details.newPageNumber;
              });
            },
          ),
          if (_isLoading)
            Container(
              color: AppColors.getBackgroundColor(context),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomLoadingWidget(),
                    SizedBox(height: 16.h),
                    Text(
                      'Loading PDF...',
                      style: Styles.font16PrimaryColorTextBold(context),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: _isLoading
          ? null
          : Container(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                color: AppColors.getCardColorTwo(context),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavButton(
                    icon: Icons.skip_previous_rounded,
                    onPressed: () {
                      _pdfViewerController.jumpToPage(1);
                    },
                    enabled: _currentPage > 1,
                  ),
                  _buildNavButton(
                    icon: Icons.arrow_back_ios_new_rounded,
                    onPressed: () {
                      _pdfViewerController.previousPage();
                    },
                    enabled: _currentPage > 1,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      '$_currentPage / $_totalPages',
                      style: Styles.font15PrimaryColorTextBold(context),
                    ),
                  ),
                  _buildNavButton(
                    icon: Icons.arrow_forward_ios_rounded,
                    onPressed: () {
                      _pdfViewerController.nextPage();
                    },
                    enabled: _currentPage < _totalPages,
                  ),
                  _buildNavButton(
                    icon: Icons.skip_next_rounded,
                    onPressed: () {
                      _pdfViewerController.jumpToPage(_totalPages);
                    },
                    enabled: _currentPage < _totalPages,
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildNavButton({
    required IconData icon,
    required VoidCallback onPressed,
    required bool enabled,
  }) {
    return IconButton(
      icon: Icon(icon),
      onPressed: enabled ? onPressed : null,
      color: enabled ? Theme.of(context).primaryColor : Colors.grey,
      iconSize: 28.sp,
    );
  }

  @override
  void dispose() {
    _pdfViewerController.removeListener(_updatePageInfo);
    _pdfViewerController.dispose();
    super.dispose();
  }
}
