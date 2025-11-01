import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/localization/translate.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/app_radius.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/core/widget/custom_text_field.dart';

class CustomSearchWidget extends StatefulWidget {
  final Function(
    String searchQuery,
    String? selectedGrade,
    String? selectedSemester,
  )? onSearchChanged;
  final String searchHint;
  final bool showGradeFilter;
  final bool showSemesterFilter;
  final List<FilterOption>? customGradeOptions;
  final List<FilterOption>? customSemesterOptions;

  const CustomSearchWidget({
    super.key,
    this.onSearchChanged,
    this.searchHint = 'Search subjects...',
    this.showGradeFilter = true,
    this.showSemesterFilter = true,
    this.customGradeOptions,
    this.customSemesterOptions,
  });

  @override
  State<CustomSearchWidget> createState() => _CustomSearchWidgetState();
}

class _CustomSearchWidgetState extends State<CustomSearchWidget>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;

  bool _isExpanded = false;
  String? _selectedGrade;
  String? _selectedSemester;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _toggleFilters() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _onSearchChanged() {
    widget.onSearchChanged?.call(
      _searchController.text,
      _selectedGrade,
      _selectedSemester,
    );
  }

  void _clearFilters() {
    setState(() {
      _searchController.clear();
      _selectedGrade = null;
      _selectedSemester = null;
    });
    _onSearchChanged();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchBar(context),
        SizedBox(height: 12.h),
        if (widget.showGradeFilter || widget.showSemesterFilter)
          _buildFiltersSection(context),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            borderRadius: AppRadius.large,
            controller: _searchController,
            onChanged: (value) => _onSearchChanged(),
            hintText: context.tr.search_subject,
            prefixIcon: IconlyLight.search,
            height: 45.h,
            fillColor: AppColors.primaryColor.withOpacity(0.1),
            hintColor: AppColors.getDarkGreyColor(context),
          ),
        ),
        if (widget.showGradeFilter || widget.showSemesterFilter)
          _buildFilterToggleButton(),
        if (_hasActiveFilters()) _buildClearButton(),
      ],
    );
  }

  Widget _buildFilterToggleButton() {
    return GestureDetector(
      onTap: _toggleFilters,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.all(8.w),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: _isExpanded
              ? AppColors.primaryColor
              : AppColors.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppRadius.large),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.tune_rounded,
              color: _isExpanded ? Colors.white : AppColors.primaryColor,
              size: 20.sp,
            ),
            if (_hasActiveFilters()) ...[
              SizedBox(width: 4.w),
              Container(
                width: 8.w,
                height: 8.h,
                decoration: BoxDecoration(
                  color: _isExpanded ? Colors.white : AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildClearButton() {
    return GestureDetector(
      onTap: _clearFilters,
      child: Container(
        padding: EdgeInsets.all(12.5.w),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppRadius.large),
        ),
        child: Icon(
          Icons.clear_rounded,
          color: Colors.red,
          size: 20.sp,
        ),
      ),
    );
  }

  Widget _buildFiltersSection(BuildContext context) {
    return AnimatedBuilder(
      animation: _slideAnimation,
      builder: (context, child) {
        return ClipRect(
          child: Align(
            alignment: Alignment.topCenter,
            heightFactor: _slideAnimation.value,
            child: child,
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppRadius.large),
          border: Border.all(
            color: AppColors.primaryColor.withOpacity(0.2),
            width: 1.w,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.filter_list_rounded,
                  color: AppColors.primaryColor,
                  size: 20.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  context.tr.filter_results,
                  style: Styles.font14PrimaryColorTextBold(context),
                ),
              ],
            ),
            if (widget.showGradeFilter) ...[
              heightBox(15),
              _buildGradeFilter(context),
            ],
            if (widget.showSemesterFilter) ...[
              heightBox(15),
              _buildSemesterFilter(context),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildGradeFilter(BuildContext context) {
    final grades = widget.customGradeOptions ?? _getDefaultGradeOptions();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr.year_title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.getTextPrimaryColor(context),
          ),
        ),
        heightBox(10),
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: grades.map((grade) {
            final isSelected = _selectedGrade == grade.value;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedGrade =
                      _selectedGrade == grade.value ? null : grade.value;
                });
                _onSearchChanged();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryColor
                      : AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppRadius.large),
                ),
                child: Text(
                  grade.label,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: isSelected
                        ? Colors.white
                        : AppColors.getTextPrimaryColor(context),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSemesterFilter(BuildContext context) {
    final semesters =
        widget.customSemesterOptions ?? _getDefaultSemesterOptions();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr.semester_title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.getTextPrimaryColor(context),
          ),
        ),
        heightBox(10),
        Row(
          children: semesters.map((semester) {
            final isSelected = _selectedSemester == semester.value;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedSemester = _selectedSemester == semester.value
                        ? null
                        : semester.value;
                  });
                  _onSearchChanged();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: EdgeInsets.only(right: 8.w),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryColor
                        : AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.large),
                  ),
                  child: Text(
                    semester.label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? Colors.white
                          : AppColors.getTextPrimaryColor(context),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  List<FilterOption> _getDefaultGradeOptions() {
    return [
      FilterOption(value: '1', label: context.tr.first),
      FilterOption(value: '2', label: context.tr.second),
      FilterOption(value: '3', label: context.tr.third),
      FilterOption(value: '4', label: context.tr.fourth),
      FilterOption(value: '5', label: context.tr.fifth),
      FilterOption(value: '6', label: context.tr.sixth),
      FilterOption(value: '7', label: context.tr.seventh),
    ];
  }

  List<FilterOption> _getDefaultSemesterOptions() {
    return [
      FilterOption(value: '1', label: context.tr.first_semester),
      FilterOption(value: '2', label: context.tr.second_semester),
    ];
  }

  bool _hasActiveFilters() {
    return _selectedGrade != null ||
        _selectedSemester != null ||
        _searchController.text.isNotEmpty;
  }
}

class FilterOption {
  final String value;
  final String label;

  const FilterOption({
    required this.value,
    required this.label,
  });
}
