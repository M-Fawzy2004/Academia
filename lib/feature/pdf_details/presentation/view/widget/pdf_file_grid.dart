import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/feature/add_subject/domain/entities/subject_entity.dart';
import 'package:study_box/feature/pdf_details/presentation/view/widget/pdf_file_card.dart';

class PdfFileGrid extends StatelessWidget {
  const PdfFileGrid({
    super.key,
    required this.subject,
  });

  final SubjectEntity subject;

  @override
  Widget build(BuildContext context) {
    // Filter only PDF resources
    final pdfResources = subject.resources
        .where((resource) => resource.type == ResourceType.pdf)
        .toList();

    if (pdfResources.isEmpty) {
      return const Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.picture_as_pdf_outlined,
                size: 64,
                color: Colors.grey,
              ),
              SizedBox(height: 16),
              Text(
                'No PDF files available',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 20.w,
          mainAxisSpacing: 25.h,
          childAspectRatio: 0.67,
        ),
        itemCount: pdfResources.length,
        itemBuilder: (context, index) {
          final pdf = pdfResources[index];
          return PdfFileCard(
            fileName: pdf.title,
            subtitle: pdf.fileSizeMB != null 
                ? '${pdf.fileSizeMB} MB' 
                : 'Unknown size',
          );
        },
      ),
    );
  }
}
