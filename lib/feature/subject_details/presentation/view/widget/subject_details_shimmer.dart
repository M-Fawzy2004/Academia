import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubjectDetailsShimmer extends StatelessWidget {
  const SubjectDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.h),
        const _HeaderCardShimmer(),
        SizedBox(height: 15.h),
        const _SectionCardShimmer(),
        SizedBox(height: 12.h),
        const _SectionCardShimmer(),
        SizedBox(height: 12.h),
        const _SectionCardShimmer(),
        SizedBox(height: 20.h),
      ],
    );
  }
}

class _HeaderCardShimmer extends StatelessWidget {
  const _HeaderCardShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ShimmerBox(height: 20.h, width: 180.w),
                SizedBox(height: 10.h),
                _ShimmerBox(height: 16.h, width: 120.w),
                SizedBox(height: 10.h),
                _ShimmerBox(height: 16.h, width: 80.w),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            children: [
              _ShimmerCircle(size: 40.w),
              SizedBox(height: 10.h),
              _ShimmerCircle(size: 40.w),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionCardShimmer extends StatelessWidget {
  const _SectionCardShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ShimmerBox(height: 18.h, width: 140.w),
              _ShimmerBox(height: 28.h, width: 76.w, borderRadius: 20.r),
            ],
          ),
          SizedBox(height: 12.h),
          _ShimmerBox(height: 56.h, width: double.infinity, borderRadius: 12.r),
        ],
      ),
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  const _ShimmerBox({
    required this.height,
    required this.width,
    this.borderRadius,
  });

  final double height;
  final double width;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return _Shimmer(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.25),
          borderRadius: BorderRadius.circular(borderRadius ?? 6.r),
        ),
      ),
    );
  }
}

class _ShimmerCircle extends StatelessWidget {
  const _ShimmerCircle({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return _Shimmer(
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.25),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class _Shimmer extends StatefulWidget {
  const _Shimmer({required this.child});
  final Widget child;

  @override
  State<_Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<_Shimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment(-1.0 - 3.0 * _controller.value, 0),
              end: Alignment(1.0 - 3.0 * _controller.value, 0),
              colors: [
                Colors.grey.withOpacity(0.2),
                Colors.grey.withOpacity(0.45),
                Colors.grey.withOpacity(0.2),
              ],
              stops: const [0.2, 0.5, 0.8],
            ).createShader(rect);
          },
          blendMode: BlendMode.srcATop,
          child: widget.child,
        );
      },
    );
  }
}
