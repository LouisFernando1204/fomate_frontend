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
    Future.delayed(const Duration(seconds: 20), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const BlueLoadingPage(isLastPage: false)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/FomateLogo.png', // Replace with your actual path
              height: 150,
            ),
            const SizedBox(height: 20),
            const Text(
              'Fomate',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'ProzaLibre', // Specify the custom font family
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Balance Your Screen, Boost Your Life.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
