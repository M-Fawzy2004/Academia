import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/helper/extension.dart';
import 'package:study_box/core/helper/form_validators.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/helper/translate.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/core/widget/custom_button.dart';
import 'package:study_box/core/widget/custom_text_field.dart';
import 'package:study_box/feature/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:study_box/feature/auth/presentation/view/forget_pass_view.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key, required this.state});

  final AuthState state;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (formKey.currentState!.validate()) {
      context.read<AuthCubit>().signIn(
            email: emailController.text.trim(),
            password: passwordController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoading = widget.state is AuthLoading;

    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: emailController,
            hintText: context.tr.login_email,
            suffixIcon: IconlyLight.message,
            validator: FormValidators.emailValidator(context),
          ),
          heightBox(15),
          CustomTextField(
            controller: passwordController,
            hintText: context.tr.login_pass,
            obscureText: true,
            validator: FormValidators.passwordValidator(context),
          ),
          heightBox(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  context.navigateWithSlideTransition(const ForgetPassView());
                },
                child: Text(
                  context.tr.login_forgot,
                  style: Styles.font14MediumPrimaryBold(context),
                ),
              ),
            ],
          ),
          heightBox(35),
          CustomButton(
            text: context.tr.login_button,
            onPressed: _handleLogin,
            isLoading: isLoading,
          ),
        ],
      ),
    );
  }
}