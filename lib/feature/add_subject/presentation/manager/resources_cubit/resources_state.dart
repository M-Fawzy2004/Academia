import 'package:equatable/equatable.dart';
import 'package:study_box/feature/add_subject/data/model/resource_item.dart';

abstract class ResourcesState extends Equatable {
  const ResourcesState();

  @override
  List<Object?> get props => [];
}

class ResourcesInitial extends ResourcesState {}

class ResourcesLoaded extends ResourcesState {
  final List<ResourceItem> resources;
  final bool isExpanded;
  final bool isLoading;
  final String? loadingType;

  const ResourcesLoaded({
    required this.resources,
    required this.isExpanded,
    this.isLoading = false,
    this.loadingType,
  });

  ResourcesLoaded copyWith({
    List<ResourceItem>? resources,
    bool? isExpanded,
    bool? isLoading,
    String? loadingType,
  }) {
    return ResourcesLoaded(
      resources: resources ?? this.resources,
      isExpanded: isExpanded ?? this.isExpanded,
      isLoading: isLoading ?? this.isLoading,
      loadingType: loadingType,
    );
  }

  @override
  List<Object?> get props => [resources, isExpanded, isLoading, loadingType];
}

class ResourcesError extends ResourcesState {
  final String message;

  const ResourcesError(this.message);

  @override
  List<Object?> get props => [message];
}
