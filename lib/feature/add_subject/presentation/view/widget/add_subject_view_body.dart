import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/language_helper.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/core/widget/custom_button.dart';
import 'package:study_box/core/widget/icon_back.dart';
import 'package:study_box/feature/add_subject/data/model/resource_item.dart';
import 'package:study_box/feature/add_subject/presentation/view/widget/add_subject_form.dart';
import 'package:study_box/feature/add_subject/presentation/view/widget/color_options_row.dart';
import 'package:study_box/feature/add_subject/presentation/view/widget/lecture_days_selector.dart';
import 'package:study_box/feature/add_subject/presentation/view/widget/resources_widget.dart'; // استيراد الـ widget الجديد

class AddSubjectViewBody extends StatefulWidget {
  const AddSubjectViewBody({super.key});

  @override
  State<AddSubjectViewBody> createState() => _AddSubjectViewBodyState();
}

class _AddSubjectViewBodyState extends State<AddSubjectViewBody> {
  Map<String, Map<String, String>> lectureSchedule = {};
  List<ResourceItem> subjectResources = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          heightBox(5),
          Align(
            alignment: LanguageHelper.isArabic(context)
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: const IconBack(),
          ),
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.school,
              color: AppColors.white,
              size: 50.sp,
            ),
          ),
          heightBox(5),
          Text(
            'Add New Subject',
            style: Styles.font18MediumBold(context),
          ),
          Text(
            'Organize your studies and make learning more fun.',
            style: Styles.font13GreyBold(context),
          ),
          heightBox(25),
          const ColorOptionsRow(),
          heightBox(10),
          const AddSubjectForm(),
          heightBox(10),
          LectureDaysSelector(
            onScheduleChanged: (schedule) {
              setState(() {
                lectureSchedule = schedule;
              });
              print('Schedule updated: $schedule');
            },
            initialSchedule: lectureSchedule,
          ),
          heightBox(10),
          ResourcesWidget(
            onResourcesChanged: (resources) {
              setState(() {
                subjectResources = resources;
              });
              print('Resources updated: ${resources.length} items');
            },
            initialResources: subjectResources,
          ),
          heightBox(20),
          CustomButton(
            text: 'Save Subject',
            onPressed: () {},
          ),
          heightBox(20),
        ],
      ),
    );
  }
}
