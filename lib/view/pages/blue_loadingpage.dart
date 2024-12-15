part of 'pages.dart';

class BlueLoadingPage extends StatelessWidget {
  final bool isLastPage; // Determines if this is the last page

  const BlueLoadingPage({Key? key, required this.isLastPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define dynamic content
    final title = isLastPage
        ? "Manage Your Screen Time with Ease"
        : "Fomate helps you stay mindful of your screen time.";
    final description = isLastPage
        ? "Balance Your Day with Fomate – Smart Reminders for Healthy Screen Habits."
        : "Set your schedule, get reminders, and keep your digital life in balance.";
    final buttonText = isLastPage ? "Getting Started" : "Next";
    final VoidCallback onButtonPressed = isLastPage
        ? () {
            // Navigate to the main menu
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MainMenu()),
            );
          }
        : () {
            // Navigate to the last page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BlueLoadingPage(isLastPage: true),
              ),
            );
          };

    return Scaffold(
      backgroundColor: Colors.lightBlue[100], // Light blue background
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          // Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          // Avatar Image
          Image.asset(
            'assets/images/BlueAvatar.png', // Replace with the correct image path
            height: 200,
          ),
          const Spacer(),
          // Dot Indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 10,
                width: 10,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isLastPage ? Colors.white : Colors.blue, // First dot
                ),
              ),
              Container(
                height: 10,
                width: 10,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isLastPage ? Colors.blue : Colors.white, // Second dot
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Button
          ElevatedButton(
            onPressed: onButtonPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            ),
            child: Text(
              buttonText,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
