// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/feature/add_subject/presentation/manager/subject_cubit/subject_cubit.dart';
import 'package:study_box/feature/subject_details/presentation/manager/scroll_cubit/scroll_cubit.dart';
import 'package:study_box/feature/subject_details/presentation/view/widget/header_details_view.dart';
import 'package:study_box/feature/subject_details/presentation/view/widget/subject_detials_view_body_bloc_builder.dart';

class SubjectDetailsViewBody extends StatefulWidget {
  const SubjectDetailsViewBody({
    super.key,
    required this.subjectId,
  });

  final String subjectId;

  @override
  State<SubjectDetailsViewBody> createState() => _SubjectDetailsViewBodyState();
}

class _SubjectDetailsViewBodyState extends State<SubjectDetailsViewBody> {
  final ScrollController _scrollController = ScrollController();
  late ScrollCubit _scrollCubit;

  static const double _hideThreshold = 50.0;
  static const double _animationRange = 100.0;

  @override
  void initState() {
    super.initState();
    _scrollCubit = ScrollCubit();
    // Load subject details
    context.read<SubjectCubit>().getSubjectById(widget.subjectId);
    // Listen to scroll changes
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    if (offset <= _hideThreshold) {
      _scrollCubit.updateScrollProgress(1.0);
      return;
    }
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      final progress = 1.0 - ((offset - _hideThreshold) / _animationRange);
      _scrollCubit.updateScrollProgress(progress);
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      final progress = 1.0 - ((offset - _hideThreshold) / _animationRange);
      _scrollCubit.updateScrollProgress(progress);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _scrollCubit,
      child: Column(
        children: [
          // Animated Header مع السكرول
          BlocBuilder<ScrollCubit, ScrollState>(
            builder: (context, scrollState) {
              return ClipRect(
                child: Align(
                  alignment: Alignment.topCenter,
                  heightFactor: scrollState.scrollProgress,
                  child: Opacity(
                    opacity: scrollState.scrollProgress,
                    child: Transform.translate(
                      offset: Offset(
                        0,
                        -30 * (1 - scrollState.scrollProgress),
                      ),
                      child: Column(
                        children: [
                          heightBox(10),
                          const HeaderDetailsView(),
                          heightBox(15),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              child: SubjectDetialsViewBodyBlocBuilder(
                mounted: mounted,
                subjectId: widget.subjectId,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
