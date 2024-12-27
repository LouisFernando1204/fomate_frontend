part of 'pages.dart';

class LogoLoadingPage extends StatefulWidget {
  const LogoLoadingPage({super.key});

  @override
  State<LogoLoadingPage> createState() => _LogoLoadingPageState();
}

class _LogoLoadingPageState extends State<LogoLoadingPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 2));
      final userData = await UserLocalStorage.getUserData();
      if (userData == null) {
        context.go('/blueloading1');
      } else {
        context.go('/mainmenu');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/fomate_logo.png',
                  height: 180,
                ),
                const Text(
                  'Fomate',
                  style: TextStyle(
                    fontSize: 36,
                    fontFamily: 'ProzaLibre',
                  ),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: const Text(
                'Balance Your Screen, Boost Your Life.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
