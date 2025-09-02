import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/utils/assets.dart';
import 'package:study_box/feature/onboarding/data/model/onboarding_model.dart';
import 'package:study_box/feature/onboarding/presentation/view/widget/onboarding_bottom_section.dart';
import 'package:study_box/feature/onboarding/presentation/view/widget/onboarding_page.dart';

class OnboardingViewBody extends StatefulWidget {
  const OnboardingViewBody({super.key});

  @override
  State<OnboardingViewBody> createState() => _OnboardingViewBodyState();
}

class _OnboardingViewBodyState extends State<OnboardingViewBody>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<OnboardingModel> _onboardingData = [
    OnboardingModel(
      image: Assets.imagesJpgOnboardingImage1,
      title: 'StudyBox – كل مذاكرتك في مكان واح',
      description:
          'اجمع موادك، ملفاتك، وملاحظاتك في تطبيق واحد بسيط يساعدك تنظم دراستك من غير لخبطة',
    ),
    OnboardingModel(
      image: Assets.imagesJpgOnboardingImage2,
      title: 'رتب موادك بسهولة',
      description:
          'أنشئ قسم لكل مادة، وخلي كل الملفات، الملاحظات، والتسجيلات متجمعة مع بعض عشان توصّلها بسرعة',
    ),
    OnboardingModel(
      image: Assets.imagesJpgOnboardingImage3,
      title: 'ملاحظاتك وملفاتك في مكان آمن',
      description:
          'دوّن ملاحظاتك، ارفع ملفاتك، واحفظ تسجيلاتك الصوتية علشان تراجعها في أي وقت وأي مكان',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
    _animationController.reset();
    _animationController.forward();
  }

  void _nextPage() {
    if (_currentIndex < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skipToEnd() {
    _pageController.animateToPage(
      _onboardingData.length - 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _getStarted() {
    // Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: _onboardingData.length,
              itemBuilder: (context, index) {
                return OnboardingPage(
                  data: _onboardingData[index],
                  fadeAnimation: _fadeAnimation,
                  slideAnimation: _slideAnimation,
                  currentIndex: _currentIndex,
                  totalPages: _onboardingData.length,
                  onSkip: _skipToEnd,
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: OnboardingBottomSection(
                currentIndex: _currentIndex,
                totalPages: _onboardingData.length,
                onNext: _nextPage,
                onGetStarted: _getStarted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
