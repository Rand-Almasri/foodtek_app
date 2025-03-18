class OnboardingModel {
  final String title;
  final String subtitle;
  final String imagePath;

  OnboardingModel({
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });
}

// بيانات شاشات ال onboarding
final List<OnboardingModel> onboardingData = [
  OnboardingModel(
    title: 'Welcome To Sahlah',
    subtitle: 'Enjoy A Fast And Smooth Food Delivery At Your Doorstep',
    imagePath: 'assets/images/onboarding_welcome.jpeg',
  ),
  OnboardingModel(
    title: 'Get Delivery On Time',
    subtitle: 'Order Your Favorite Food From Within The Plam Of Your Hand and The Zone Of Your Comfort',
    imagePath: 'assets/images/onboarding_delivery.jpeg',
  ),

  OnboardingModel(
    title: 'Turn On Your Location',
    subtitle: 'To Make Sure We Can Deliver To Your Address',
    imagePath: 'assets/images/onboarding_delivery.jpeg',
  ),
];