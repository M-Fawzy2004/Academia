import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/helper/form_validators.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/helper/translate.dart';
import 'package:study_box/core/widget/custom_button.dart';
import 'package:study_box/core/widget/custom_text_field.dart';
import 'package:study_box/feature/auth/presentation/manager/cubit/auth_cubit.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    super.key,
    required this.state,
    this.onEmailChanged,
  });

  final AuthState state;
  final Function(String)? onEmailChanged;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      widget.onEmailChanged?.call(emailController.text.trim());
    });
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    if (formKey.currentState!.validate()) {
      context.read<AuthCubit>().signUp(
            email: emailController.text.trim(),
            password: passController.text,
            confirmPassword: confirmPassController.text,
            name: usernameController.text.trim(),
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
            controller: usernameController,
            hintText: context.tr.register_username,
            suffixIcon: IconlyLight.profile,
            keyboardType: TextInputType.text,
            validator: FormValidators.usernameValidator(context),
            enabled: !isLoading,
          ),
          heightBox(15),
          CustomTextField(
            controller: emailController,
            hintText: context.tr.login_email,
            suffixIcon: IconlyLight.message,
            keyboardType: TextInputType.emailAddress,
            validator: FormValidators.emailValidator(context),
            enabled: !isLoading,
          ),
          heightBox(15),
          CustomTextField(
            controller: passController,
            hintText: context.tr.login_pass,
            obscureText: true,
            validator: FormValidators.passwordValidator(context),
            enabled: !isLoading,
          ),
          heightBox(15),
          CustomTextField(
            controller: confirmPassController,
            hintText: context.tr.register_confirm_pass,
            obscureText: true,
            validator: (value) => FormValidators.validateConfirmPassword(
              value,
              passController.text,
              context,
            ),
            enabled: !isLoading,
          ),
          heightBox(35),
          CustomButton(
            text: context.tr.login_register,
            onPressed: _handleSignUp,
            isLoading: isLoading,
          ),
        ],
      ),
    );
  }
}
