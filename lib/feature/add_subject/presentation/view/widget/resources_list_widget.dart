import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:study_box/core/const/app_constant.dart';
import 'package:study_box/feature/add_subject/data/model/resource_item.dart';
import 'package:study_box/feature/add_subject/presentation/manager/resources_cubit/resources_cubit.dart';
import 'package:study_box/feature/add_subject/presentation/manager/resources_cubit/resources_state.dart';
import 'package:study_box/feature/add_subject/presentation/view/widget/book_dialog.dart';
import 'package:study_box/feature/add_subject/presentation/view/widget/link_dialog.dart';
import 'resource_card.dart';

class ResourcesListWidget extends StatefulWidget {
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
  State<ResourcesListWidget> createState() => _ResourcesListWidgetState();
}

class _ResourcesListWidgetState extends State<ResourcesListWidget> {
  String? uploaderName;
  String? planLabel;

  @override
  void initState() {
    super.initState();
    _loadUserMeta();
  }

  Future<void> _loadUserMeta() async {
    try {
      final client = Supabase.instance.client;
      final user = client.auth.currentUser;
      if (user == null) return;

      final List<dynamic> rows = await client
          .from(AppConstant.tableAuthUsers)
          .select('name, email')
          .eq('id', user.id);
      String? name = rows.isNotEmpty ? (rows.first['name'] as String?) : null;
      name ??= user.userMetadata?['name'] as String?;
      name ??= user.email;

      final List<dynamic> prof = await client
          .from(AppConstant.subscriptionTable)
          .select('subscription_tier')
          .eq('id', user.id);
      String? tier = prof.isNotEmpty
          ? (prof.first['subscription_tier'] as String?)
          : null;
      tier ??= 'free';

      if (mounted) {
        setState(() {
          uploaderName = name;
          planLabel = tier;
        });
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: widget.maxHeight?.toDouble() ?? 400.h,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.state.resources.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return ResourcesListItemWidget(
            resource: widget.state.resources[index],
            animationController: widget.animationController,
            uploaderName: uploaderName,
            planLabel: planLabel,
          );
        },
      ),
    );
  }
}

class ResourcesListItemWidget extends StatelessWidget {
  final ResourceItem resource;
  final AnimationController animationController;
  final String? uploaderName;
  final String? planLabel;

  const ResourcesListItemWidget({
    super.key,
    required this.resource,
    required this.animationController,
    this.uploaderName,
    this.planLabel,
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
            uploaderName: uploaderName,
            planLabel: planLabel,
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
