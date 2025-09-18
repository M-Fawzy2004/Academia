import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/feature/add_subject/data/model/resource_item.dart';
import 'package:study_box/feature/add_subject/presentation/manager/resources_cubit/resources_cubit.dart';
import 'package:study_box/feature/add_subject/presentation/manager/resources_cubit/resources_state.dart';
import 'package:study_box/feature/add_subject/presentation/view/widget/book_dialog.dart';
import 'package:study_box/feature/add_subject/presentation/view/widget/link_dialog.dart';
import 'resource_card.dart';

class ResourcesListWidget extends StatelessWidget {
  final ResourcesLoaded state;
  final int? maxHeight;
  final AnimationController animationController;

  const ResourcesListWidget({
    super.key,
    required this.state,
    required this.animationController,
    this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: maxHeight?.toDouble() ?? 400.h,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: state.resources.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return ResourcesListItemWidget(
            resource: state.resources[index],
            animationController: animationController,
          );
        },
      ),
    );
  }
}

class ResourcesListItemWidget extends StatelessWidget {
  final ResourceItem resource;
  final AnimationController animationController;

  const ResourcesListItemWidget({
    super.key,
    required this.resource,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animationController,
            curve: Curves.easeOut,
          )),
          child: ResourceCard(
            resource: resource,
            onRemove: () =>
                context.read<ResourcesCubit>().removeResource(resource.id),
            onEdit: () => _editResource(context, resource),
            onTap: () {},
          ),
        );
      },
    );
  }

  void _editResource(BuildContext context, ResourceItem resource) {
    final cubit = context.read<ResourcesCubit>();

    if (resource.type == ResourceType.link) {
      ResourcesEditLinkDialogWidget.show(context, resource, cubit);
    } else if (resource.type == ResourceType.book) {
      ResourcesEditBookDialogWidget.show(context, resource, cubit);
    }
  }
}

class ResourcesEditLinkDialogWidget {
  static void show(
    BuildContext context,
    ResourceItem resource,
    ResourcesCubit cubit,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => LinkDialog(
        initialResource: resource,
        onAdd: cubit.editResource,
      ),
    );
  }
}

class ResourcesEditBookDialogWidget {
  static void show(
    BuildContext context,
    ResourceItem resource,
    ResourcesCubit cubit,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => BookDialog(
        initialResource: resource,
        onAdd: cubit.editResource,
      ),
    );
  }
}
