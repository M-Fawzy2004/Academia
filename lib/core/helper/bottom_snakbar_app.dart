// // ignore_for_file: library_private_types_in_public_api
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:study_box/core/helper/spacing.dart';
// import 'package:study_box/core/theme/app_color.dart';
// import 'package:study_box/core/theme/styles.dart' show Styles;

// void showCustomSnackBar({
//   required BuildContext context,
//   required String message,
//   SnackBarType type = SnackBarType.info,
//   String? actionLabel,
//   VoidCallback? onActionPressed,
// }) {
//   final colors = _getColorsForType(type, context);

//   ScaffoldMessenger.of(context).clearSnackBars();

//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: CustomSnackBarContent(
//         message: message,
//         type: type,
//         actionLabel: actionLabel,
//         onActionPressed: onActionPressed,
//         colors: colors,
//       ),
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       behavior: SnackBarBehavior.floating,
//       duration: const Duration(seconds: 3),
//       margin: EdgeInsets.only(bottom: 25.h, left: 16.w, right: 16.w),
//       padding: EdgeInsets.zero,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
//     ),
//   );
// }

// class CustomSnackBarContent extends StatefulWidget {
//   final String message;
//   final SnackBarType type;
//   final String? actionLabel;
//   final VoidCallback? onActionPressed;
//   final _SnackBarColors colors;

//   const CustomSnackBarContent({
//     super.key,
//     required this.message,
//     required this.type,
//     this.actionLabel,
//     this.onActionPressed,
//     required this.colors,
//   });

//   @override
//   State<CustomSnackBarContent> createState() => _CustomSnackBarContentState();
// }

// class _CustomSnackBarContentState extends State<CustomSnackBarContent>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _fadeAnimation;
//   double _dragOffset = 0;
//   bool _isDragging = false;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );

//     _scaleAnimation = Tween<double>(
//       begin: 0.8,
//       end: 1.0,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

//     _fadeAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _handlePanUpdate(DragUpdateDetails details) {
//     setState(() {
//       _isDragging = true;
//       _dragOffset += details.delta.dy;
//       _dragOffset = _dragOffset.clamp(0.0, double.infinity);
//     });
//   }

//   void _handlePanEnd(DragEndDetails details) {
//     const double dismissThreshold = 80.0;
//     const double velocityThreshold = 300.0;

//     if (_dragOffset > dismissThreshold ||
//         details.velocity.pixelsPerSecond.dy > velocityThreshold) {
//       ScaffoldMessenger.of(context).hideCurrentSnackBar();
//     } else {
//       setState(() {
//         _dragOffset = 0;
//         _isDragging = false;
//       });
//     }
//   }

//   void _dismiss() {
//     ScaffoldMessenger.of(context).hideCurrentSnackBar();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScaleTransition(
//       scale: _scaleAnimation,
//       child: FadeTransition(
//         opacity: _fadeAnimation,
//         child: Transform.translate(
//           offset: Offset(0, _dragOffset),
//           child: AnimatedOpacity(
//             opacity: _isDragging ? 0.8 : 1.0,
//             duration: const Duration(milliseconds: 100),
//             child: GestureDetector(
//               onPanUpdate: _handlePanUpdate,
//               onPanEnd: _handlePanEnd,
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
//                 decoration: BoxDecoration(
//                   color: widget.colors.backgroundColor,
//                   borderRadius: BorderRadius.circular(25.r),
//                   border: Border.all(
//                     color: widget.colors.borderColor,
//                     width: 1,
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 10,
//                       offset: const Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(
//                       _getIconForType(widget.type),
//                       color: widget.colors.iconColor,
//                       size: 20.sp,
//                     ),
//                     widthBox(15),
//                     Expanded(
//                       child: Text(
//                         widget.message,
//                         style: Styles.font14GreyExtraBold(
//                           context,
//                         ).copyWith(color: widget.colors.textColor),
//                       ),
//                     ),
//                     if (widget.actionLabel != null) ...[
//                       widthBox(10),
//                       GestureDetector(
//                         onTap: () {
//                           widget.onActionPressed?.call();
//                           _dismiss();
//                         },
//                         child: Text(
//                           widget.actionLabel!,
//                           style: Styles.font14GreyExtraBold(context).copyWith(
//                             color: widget.colors.iconColor,
//                             decoration: TextDecoration.underline,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Updated enum to include warning
// enum SnackBarType { success, error, info, warning }

// class _SnackBarColors {
//   final Color backgroundColor;
//   final Color borderColor;
//   final Color iconColor;
//   final Color textColor;

//   _SnackBarColors({
//     required this.backgroundColor,
//     required this.borderColor,
//     required this.iconColor,
//     required this.textColor,
//   });
// }

// // Helper function to get the appropriate icon for each type
// IconData _getIconForType(SnackBarType type) {
//   switch (type) {
//     case SnackBarType.success:
//       return Icons.check_circle_outline;
//     case SnackBarType.error:
//       return Icons.error_outline;
//     case SnackBarType.warning:
//       return Icons.warning_amber_outlined;
//     case SnackBarType.info:
//       return Icons.info_outline;
//   }
// }

// // Updated function to include warning colors
// _SnackBarColors _getColorsForType(SnackBarType type, BuildContext context) {
//   switch (type) {
//     case SnackBarType.info:
//       return _SnackBarColors(
//         backgroundColor: AppColors.getSurfaceColor(context),
//         borderColor: AppColors.getSurfaceColor(context),
//         iconColor: AppColors.primaryColor,
//         textColor: AppColors.primaryColor,
//       );
//     case SnackBarType.error:
//       return _SnackBarColors(
//         backgroundColor: const Color(0xFFE53935),
//         borderColor: const Color(0xFFEF5350),
//         iconColor: Colors.white,
//         textColor: Colors.white,
//       );
//     case SnackBarType.success:
//       return _SnackBarColors(
//         backgroundColor: AppColors.primaryColor,
//         borderColor: AppColors.primaryColor,
//         iconColor: Colors.white,
//         textColor: Colors.white,
//       );
//     case SnackBarType.warning:
//       return _SnackBarColors(
//         backgroundColor: const Color(0xFFFF9800),
//         borderColor: const Color(0xFFFFB04C),
//         iconColor: Colors.white,
//         textColor: Colors.white,
//       );
//   }
// }
