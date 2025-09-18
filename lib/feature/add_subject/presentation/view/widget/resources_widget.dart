import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/feature/add_subject/data/model/resource_item.dart';
import 'package:study_box/feature/add_subject/presentation/manager/resources_cubit/resources_cubit.dart';
import 'package:study_box/feature/add_subject/presentation/view/widget/resources_bloc_consumer.dart';

class ResourcesWidget extends StatelessWidget {
  final Function(List<ResourceItem>)? onResourcesChanged;
  final List<ResourceItem> initialResources;
  final bool isCollapsible;
  final bool initiallyExpanded;
  final int? maxHeight;

  const ResourcesWidget({
    super.key,
    this.onResourcesChanged,
    this.initialResources = const [],
    this.isCollapsible = true,
    this.initiallyExpanded = false,
    this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResourcesCubit(onResourcesChanged: onResourcesChanged)
        ..initialize(
          initialResources: initialResources,
          initiallyExpanded: initiallyExpanded,
        ),
      child: ResourcesBlocConsumer(
        isCollapsible: isCollapsible,
        maxHeight: maxHeight,
      ),
    );
  }
}