import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/helper/app_router.dart';
import 'package:study_box/core/helper/custom_snack_bar.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/localization/translate.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/core/utils/assets.dart';
import 'package:study_box/core/widget/custom_button.dart';
import 'package:study_box/core/widget/custom_text_field.dart';
import 'package:study_box/feature/auth/presentation/manager/cubit/auth_cubit.dart';

class VerfEmailViewBody extends StatefulWidget {
  const VerfEmailViewBody({super.key, this.email});

  final String? email;

  @override
  State<VerfEmailViewBody> createState() => _VerfEmailViewBodyState();
}

class _VerfEmailViewBodyState extends State<VerfEmailViewBody> {
  final TextEditingController codeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? effectiveEmail;

  @override
  void initState() {
    super.initState();

    // Get email from widget or GoRouter query parameters
    effectiveEmail = widget.email;

    if (effectiveEmail == null || effectiveEmail!.isEmpty) {
      try {
        final queryParams = GoRouterState.of(context).uri.queryParameters;
        effectiveEmail = queryParams['email'];
      } catch (e) {
        // Fallback if GoRouter is not available
      }
    }

    print('Effective email for verification: $effectiveEmail');
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  void _handleVerifyEmail() {
    if (formKey.currentState!.validate()) {
      print('Verifying email with token: ${codeController.text.trim()}');
      print('Email: $effectiveEmail');

      context.read<AuthCubit>().verifyEmail(
            token: codeController.text.trim(),
            email: effectiveEmail,
          );
    }
  }

  void _handleResendCode() {
    if (effectiveEmail != null && effectiveEmail!.isNotEmpty) {
      print('Resending code to: $effectiveEmail');
      context.read<AuthCubit>().resendEmailVerification(email: effectiveEmail!);
    } else {
      CustomSnackBar.showError(context, context.tr.email_not_found);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        print('Current state: $state');

        if (state is AuthError) {
          CustomSnackBar.showError(context, state.message);
          context.read<AuthCubit>().clearError();
        }

        if (state is AuthEmailVerified) {
          CustomSnackBar.showSuccess(context, state.message);
        }

        if (state is AuthAuthenticated) {
          context.go(AppRouter.mainView);
          CustomSnackBar.showSuccess(
            context,
            context.tr.account_verified_created,
          );
        }

        if (state is AuthEmailSent) {
          CustomSnackBar.showSuccess(context, state.message);
          codeController.clear();
        }
      },
      builder: (context, state) {
        final bool isLoading = state is AuthLoading;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heightBox(50),
                Center(
                  child: Text(
                    context.tr.confirm_email,
                    style: Styles.font18MediumPrimaryBold(context),
                  ),
                ),
                heightBox(20),
                Center(
                  child: Image.asset(
                    Assets.imagesPngVerfEmailImage,
                    height: 250.h,
                    width: 250.w,
                  ),
                ),
                heightBox(20),
                Text(
                  context.tr.send_code_with_email,
                  style: Styles.font14MediumPrimaryBold(context),
                ),
                heightBox(10),
                Text(
                  context.tr.enter_code,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                  ),
                ),
                if (effectiveEmail != null && effectiveEmail!.isNotEmpty) ...[
                  heightBox(5),
                  Text(
                    'Sent to: $effectiveEmail',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.blue[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
                heightBox(15),
                CustomTextField(
                  controller: codeController,
                  hintText: context.tr.verf_code,
                  suffixIcon: IconlyLight.shield_done,
                  keyboardType: TextInputType.number,
                  enabled: !isLoading,
                  maxLength: 6,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return context.tr.verification_code_required;
                    }
                    if (value.trim().length != 6) {
                      return context.tr.verification_code_6_digits;
                    }
                    return null;
                  },
                ),
                heightBox(20),
                CustomButton(
                  text: context.tr.verf,
                  onPressed: isLoading ? null : _handleVerifyEmail,
                ),
                heightBox(20),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: isLoading ? null : _handleResendCode,
                    child: Text(
                      context.tr.resend_code,
                      style: Styles.font13MediumGreyBold(context).copyWith(
                        color: isLoading ? Colors.grey : null,
                      ),
                    ),
                  ),
                ),
                heightBox(20),
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: Colors.blue.withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.blue[700],
                            size: 20.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            context.tr.important_notes,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue[700],
                            ),
                          ),
                        ],
                      ),
                      heightBox(8),
                      Text(
                        '• ${context.tr.check_spam_folder}\n'
                        '• ${context.tr.code_expires_10_minutes}\n'
                        '• ${context.tr.account_created_after_verification}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.blue[600],
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
