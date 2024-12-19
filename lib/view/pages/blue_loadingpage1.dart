part of 'pages.dart';

class BlueLoadingPage1 extends StatelessWidget {
  const BlueLoadingPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title =
        '\"Fomate helps you stay mindful of your screen time. Set your schedule, get reminders, and keep your digital life in balance.\"';
    final description = "";
    final buttonText = "Next";

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                    color: AppColors.textColor_0,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: const TextStyle(),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/images/BlueAvatar.png',
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Container(
                        height: 10,
                        width: 10,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.backgroundColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BlueLoadingPage2(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.textColor_1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 2,
                      ),
                    ),
                    child: Text(
                      buttonText,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.textColor_0,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
