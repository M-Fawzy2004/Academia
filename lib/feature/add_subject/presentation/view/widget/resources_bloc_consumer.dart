import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/core/helper/language_helper.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/feature/add_subject/presentation/manager/resources_cubit/resources_cubit.dart';
import 'package:study_box/feature/add_subject/presentation/manager/resources_cubit/resources_state.dart';
import 'resources_container_widget.dart';
import 'resources_header_widget.dart';
import 'resources_add_buttons_widget.dart';
import 'resources_list_widget.dart';
import 'resources_empty_state_widget.dart';

class ResourcesBlocConsumer extends StatefulWidget {
  final bool isCollapsible;
  final int? maxHeight;

  const ResourcesBlocConsumer({
    super.key,
    required this.isCollapsible,
    this.maxHeight,
  });

  @override
  State<ResourcesBlocConsumer> createState() => _ResourcesBlocConsumerState();
}

class _ResourcesBlocConsumerState extends State<ResourcesBlocConsumer>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _expandController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _expandController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _expandAnimation = CurvedAnimation(
      parent: _expandController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _expandController.dispose();
    super.dispose();
  }

  void _updateExpandAnimation(bool isExpanded) {
    if (isExpanded) {
      _expandController.forward();
    } else {
      _expandController.reverse();
    }
  }

  void _playAddAnimation() {
    _animationController.forward().then((_) {
      _animationController.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = LanguageHelper.isArabic(context);

    return BlocConsumer<ResourcesCubit, ResourcesState>(
      listener: (context, state) {
        if (state is ResourcesLoaded) {
          _updateExpandAnimation(state.isExpanded);
          if (state.resources.isNotEmpty && !state.isLoading) {
            _playAddAnimation();
          }
        }
        if (state is ResourcesError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is ResourcesLoaded) {
          return ResourcesContainerWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ResourcesHeaderWidget(
                  state: state,
                  isArabic: isArabic,
                  isCollapsible: widget.isCollapsible,
                ),
                ResourcesExpandableContentWidget(
                  expandAnimation: _expandAnimation,
                  child: Column(
                    children: [
                      heightBox(15),
                      ResourcesAddButtonsWidget(
                        state: state,
                        isArabic: isArabic,
                      ),
                      if (state.resources.isNotEmpty) ...[
                        heightBox(15),
                        ResourcesListWidget(
                          state: state,
                          maxHeight: widget.maxHeight,
                          animationController: _animationController,
                        ),
                      ] else
                        ResourcesEmptyStateWidget(
                          isArabic: isArabic,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}