import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/feature/add_subject/data/model/resource_item.dart';
import 'package:study_box/feature/add_subject/data/service/image_picker_service.dart';
import 'package:study_box/feature/add_subject/data/service/pdf_picker_service.dart';
import 'resources_state.dart';

class ResourcesCubit extends Cubit<ResourcesState> {
  final Function(List<ResourceItem>)? onResourcesChanged;

  ResourcesCubit({this.onResourcesChanged}) : super(ResourcesInitial());

  void initialize({
    List<ResourceItem> initialResources = const [],
    bool initiallyExpanded = false,
  }) {
    emit(ResourcesLoaded(
      resources: List.from(initialResources),
      isExpanded: initiallyExpanded,
    ));
  }

  void toggleExpansion() {
    final currentState = state;
    if (currentState is ResourcesLoaded) {
      emit(currentState.copyWith(isExpanded: !currentState.isExpanded));
    }
  }

  void addResource(ResourceItem resource) {
    final currentState = state;
    if (currentState is ResourcesLoaded) {
      final updatedResources = [...currentState.resources, resource];
      emit(currentState.copyWith(
        resources: updatedResources,
        isExpanded: true,
      ));
      onResourcesChanged?.call(updatedResources);
    }
  }

  void removeResource(String id) {
    final currentState = state;
    if (currentState is ResourcesLoaded) {
      final updatedResources = currentState.resources
          .where((resource) => resource.id != id)
          .toList();
      emit(currentState.copyWith(resources: updatedResources));
      onResourcesChanged?.call(updatedResources);
    }
  }

  void editResource(ResourceItem updatedResource) {
    final currentState = state;
    if (currentState is ResourcesLoaded) {
      final updatedResources = currentState.resources.map((resource) {
        return resource.id == updatedResource.id ? updatedResource : resource;
      }).toList();
      emit(currentState.copyWith(resources: updatedResources));
      onResourcesChanged?.call(updatedResources);
    }
  }

  Future<void> addImage(BuildContext context) async {
    final currentState = state;
    if (currentState is ResourcesLoaded) {
      emit(currentState.copyWith(isLoading: true, loadingType: 'image'));

      try {
        await ImagePickerService.showImageSourceDialog(context, addResource);
      } catch (e) {
        emit(ResourcesError(e.toString()));
      } finally {
        if (state is ResourcesLoaded) {
          emit((state as ResourcesLoaded).copyWith(
            isLoading: false,
            loadingType: null,
          ));
        }
      }
    }
  }

  Future<void> addPDF(BuildContext context) async {
    final currentState = state;
    if (currentState is ResourcesLoaded) {
      emit(currentState.copyWith(isLoading: true, loadingType: 'pdf'));

      try {
        final resource = await PdfPickerService.pickPdf(context);
        if (resource != null) {
          addResource(resource);
        }
      } catch (e) {
        emit(ResourcesError(e.toString()));
      } finally {
        if (state is ResourcesLoaded) {
          emit((state as ResourcesLoaded).copyWith(
            isLoading: false,
            loadingType: null,
          ));
        }
      }
    }
  }

  void setLoadingState(String type, bool isLoading) {
    final currentState = state;
    if (currentState is ResourcesLoaded) {
      emit(currentState.copyWith(
        isLoading: isLoading,
        loadingType: isLoading ? type : null,
      ));
    }
  }
}