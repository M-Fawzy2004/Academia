import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:study_box/feature/auth/presentation/view/widget/verf_email_view_body.dart';

class VerfEmailView extends StatelessWidget {
  const VerfEmailView({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    // Get email from query parameters if not provided directly
    final String? emailFromQuery = GoRouterState.of(context).uri.queryParameters['email'];
    final String? finalEmail = email ?? emailFromQuery;

    print('Email from constructor: $email');
    print('Email from query: $emailFromQuery');
    print('Final email: $finalEmail');

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: VerfEmailViewBody(email: finalEmail),
        ),
      ),
    );
  }
}