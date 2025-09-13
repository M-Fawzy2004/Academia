import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/feature/courses/presentation/view/widget/add_courses_button.dart';
import 'package:study_box/feature/courses/presentation/view/widget/course_card.dart';

class CoursesViewBody extends StatelessWidget {
  const CoursesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heightBox(10),
        Row(
          children: [
            Text(
              'My Courses',
              style: Styles.font20MediumBold(context),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(IconlyLight.search),
            ),
          ],
        ),
        Text(
          'Manage your enrolled courses below',
          style: Styles.font13GreyBold(context),
        ),
        heightBox(15),
        const AddCoursesButton(),
        heightBox(20),
        Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: 10,
            separatorBuilder: (context, index) => heightBox(10),
            itemBuilder: (context, index) {
              return const CourseCard();
            },
          ),
        ),
      ],
    );
  }
}
