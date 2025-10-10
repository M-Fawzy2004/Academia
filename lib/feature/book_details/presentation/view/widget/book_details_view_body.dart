import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/feature/add_subject/presentation/manager/subject_cubit/subject_cubit.dart';
import 'package:study_box/feature/book_details/presentation/view/widget/book_details_header.dart';
import 'package:study_box/feature/book_details/presentation/view/widget/book_item_grid_bloc_consumer.dart';

class BookDetailsViewBody extends StatefulWidget {
  const BookDetailsViewBody({super.key, required this.subjectId});

  final String subjectId;

  @override
  State<BookDetailsViewBody> createState() => _BookDetailsViewBodyState();
}

class _BookDetailsViewBodyState extends State<BookDetailsViewBody> {
  @override
  void initState() {
    super.initState();
    // Load subject to get PDF files
    context.read<SubjectCubit>().getSubjectById(widget.subjectId);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          heightBox(10),
          // header widget
          const BookDetailsHeader(),
          heightBox(20),
          // book item grid widget
          const BookItemGridBlocConsumer(),
          heightBox(25),
          // text widget
          Text(
            'Every book is a new step towards success.',
            style: Styles.font13GreyBold(context).copyWith(
              fontSize: 15.sp,
            ),
          )
        ],
      ),
    );
  }
}
