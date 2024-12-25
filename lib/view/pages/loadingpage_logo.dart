part of 'pages.dart';

class LoadingPageLogo extends StatefulWidget {
  const LoadingPageLogo({Key? key}) : super(key: key);

  @override
  State<LoadingPageLogo> createState() => _LoadingPageLogoState();
}

class _LoadingPageLogoState extends State<LoadingPageLogo> {
  @override
  void initState() {
    super.initState();
    // Automatically navigate to the next page after 3 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const BlueLoadingPage1()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 120),
            Image.asset(
              'assets/images/FomateLogo.png',
              height: 335,
            ),
            Transform.translate(
              offset: const Offset(0, -55),
              child: const Text(
                'Fomate',
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'ProzaLibre',
                ),
              ),
            ),
            const SizedBox(height: 170),
            const Text(
              'Balance Your Screen, Boost Your Life.',
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
            // const SizedBox(height: 40),
            // const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
