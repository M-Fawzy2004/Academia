import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/feature/welcome/presentation/manager/cubit/welcome_cubit.dart';
import 'package:study_box/feature/welcome/presentation/view/widget/welcome_view_wrapper.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WelcomeCubit(),
      child: const Scaffold(
        body: WelcomeViewWrapper(),
      ),
    );
  }
}
