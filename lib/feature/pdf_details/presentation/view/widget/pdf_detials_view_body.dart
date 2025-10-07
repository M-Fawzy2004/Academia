import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/feature/add_subject/presentation/manager/subject_cubit/subject_cubit.dart';
import 'package:study_box/feature/pdf_details/presentation/view/widget/pdf_details_header.dart';
import 'package:study_box/feature/pdf_details/presentation/view/widget/pdf_file_grid_bloc_consumer.dart';

class PdfDetialsViewBody extends StatefulWidget {
  const PdfDetialsViewBody({
    super.key,
    required this.subjectId,
  });

  final String subjectId;

  @override
  State<PdfDetialsViewBody> createState() => _PdfDetialsViewBodyState();
}

class _PdfDetialsViewBodyState extends State<PdfDetialsViewBody> {
  @override
  void initState() {
    super.initState();
    // Load subject to get PDF files
    context.read<SubjectCubit>().getSubjectById(widget.subjectId);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        heightBox(10),
        const PdfDetailsHeader(),
        heightBox(20),
        const PdfFileGridBlocConsumer(),
        heightBox(20),
      ],
    );
  }
}
