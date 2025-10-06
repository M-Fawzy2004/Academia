import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/feature/add_subject/presentation/manager/resources_cubit/resources_cubit.dart';
import 'package:study_box/feature/add_subject/presentation/manager/resources_cubit/resources_state.dart';
import 'package:study_box/feature/add_subject/presentation/view/widget/link_dialog.dart';
import 'add_button.dart';
import 'package:study_box/feature/add_subject/data/model/resource_item.dart';

class ResourcesAddButtonsWidget extends StatelessWidget {
  final ResourcesLoaded state;
  final bool isArabic;

  const ResourcesAddButtonsWidget({
    super.key,
    required this.state,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ResourcesCubit>();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ResourcesLinkButtonWidget(
            isArabic: isArabic,
            isLoading: state.isLoading && state.loadingType == 'link',
            cubit: cubit,
          ),
          widthBox(16),
          ResourcesImageButtonWidget(
            isArabic: isArabic,
            isLoading: state.isLoading && state.loadingType == 'image',
            cubit: cubit,
          ),
          widthBox(16),
          ResourcesPdfButtonWidget(
            isLoading: state.isLoading && state.loadingType == 'pdf',
            cubit: cubit,
          ),
          widthBox(16),
          ResourcesBookButtonWidget(
            isArabic: isArabic,
            isLoading: state.isLoading && state.loadingType == 'book',
            cubit: cubit,
          ),
        ],
      ),
    );
  }
}

class ResourcesLinkButtonWidget extends StatelessWidget {
  final bool isArabic;
  final bool isLoading;
  final ResourcesCubit cubit;

  const ResourcesLinkButtonWidget({
    super.key,
    required this.isArabic,
    required this.isLoading,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return AddButton(
      icon: Icons.play_circle_outline,
      label: isArabic ? 'رابط فيديو' : 'Video Link',
      color: Colors.purple,
      onTap: () => _showLinkDialog(context),
      isLoading: isLoading,
    );
  }

  void _showLinkDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => LinkDialog(
        forcedType: ResourceType.video,
        onAdd: cubit.addResource,
      ),
    );
  }
}

class ResourcesImageButtonWidget extends StatelessWidget {
  final bool isArabic;
  final bool isLoading;
  final ResourcesCubit cubit;

  const ResourcesImageButtonWidget({
    super.key,
    required this.isArabic,
    required this.isLoading,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return AddButton(
      icon: Icons.image,
      label: isArabic ? 'صورة' : 'Image',
      color: Colors.green,
      onTap: () => cubit.addImage(context),
      isLoading: isLoading,
    );
  }
}

class ResourcesPdfButtonWidget extends StatelessWidget {
  final bool isLoading;
  final ResourcesCubit cubit;

  const ResourcesPdfButtonWidget({
    super.key,
    required this.isLoading,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return AddButton(
      icon: Icons.picture_as_pdf,
      label: 'PDF',
      color: Colors.red,
      onTap: () => cubit.addPDF(context),
      isLoading: isLoading,
    );
  }
}

class ResourcesBookButtonWidget extends StatelessWidget {
  final bool isArabic;
  final bool isLoading;
  final ResourcesCubit cubit;

  const ResourcesBookButtonWidget({
    super.key,
    required this.isArabic,
    required this.isLoading,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return AddButton(
      icon: Icons.book,
      label: isArabic ? 'كتاب' : 'Book',
      color: Colors.orange,
      onTap: () => _showBookDialog(context),
      isLoading: isLoading,
    );
  }

  void _showBookDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => LinkDialog(
        forcedType: ResourceType.book,
        onAdd: cubit.addResource,
      ),
    );
  }
}