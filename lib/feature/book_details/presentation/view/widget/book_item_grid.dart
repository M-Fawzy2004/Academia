import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/feature/add_subject/domain/entities/subject_entity.dart';
import 'package:study_box/feature/book_details/presentation/view/widget/book_item_card.dart';

class BookItemGrid extends StatelessWidget {
  const BookItemGrid({super.key, required this.subject});

  final SubjectEntity subject;

  @override
  Widget build(BuildContext context) {
    final bookResources = subject.resources
        .where((resource) => resource.type == ResourceType.bookLink)
        .toList();

    if (bookResources.isEmpty) {
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
                'No Book files available',
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

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 15.w,
        crossAxisSpacing: 15.h,
        childAspectRatio: 5,
      ),
      itemBuilder: (_, index) {
        final book = bookResources[index];
        return BookItemCard(
          title: book.title,
          url: book.url,
        );
      },
      itemCount: bookResources.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
