import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/helper/custom_flushbar.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/helper/translate.dart';
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

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  void _handleVerifyEmail() {
    if (formKey.currentState!.validate()) {
      context.read<AuthCubit>().verifyEmail(token: codeController.text.trim());
    }
  }

  void _handleResendCode() {
    if (widget.email != null && widget.email!.isNotEmpty) {
      context.read<AuthCubit>().resendEmailVerification(email: widget.email!);
    } else {
      CustomFlushbar.showError(context, 'Email not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          CustomFlushbar.showError(context, state.message);
          context.read<AuthCubit>().clearError();
        }
        
        if (state is AuthEmailVerified) {
          CustomFlushbar.showSuccess(context, state.message);
          // You might want to navigate somewhere or refresh user data
          context.read<AuthCubit>().initializeAuth();
        }
        
        if (state is AuthEmailSent) {
          CustomFlushbar.showSuccess(context, state.message);
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
                if (widget.email != null) ...[
                  heightBox(5),
                  Text(
                    'Sent to: ${widget.email}',
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
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Verification code is required';
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
              ],
            ),
          ),
        );
      },
    );
  }
}