import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:study_box/core/helper/app_router.dart';
import 'package:study_box/feature/auth/presentation/manager/cubit/auth_cubit.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          context.go(AppRouter.welcomeView);
        }

        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: IconButton(
                onPressed: () {
                  context.read<AuthCubit>().signOut();
                },
                icon: Icon(
                  Icons.logout,
                  size: 40.sp,
                  color: Colors.red,
                ),
                tooltip: 'تسجيل الخروج',
              ),
            ),
          ],
        );
      },
    );
  }
}
