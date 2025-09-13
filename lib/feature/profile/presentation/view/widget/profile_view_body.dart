import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/helper/app_router.dart';
import 'package:study_box/core/helper/custom_snack_bar.dart';
import 'package:study_box/feature/auth/presentation/manager/cubit/auth_cubit.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                CustomSnackBar.showError(context, state.message);
              }

              if (state is AuthUnauthenticated) {
                context.go(AppRouter.welcomeView);
              }
            },
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  context.read<AuthCubit>().signOut();
                },
                icon: Icon(
                  IconlyLight.logout,
                  size: 50.sp,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
