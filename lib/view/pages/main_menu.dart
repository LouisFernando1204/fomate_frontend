part of 'pages.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Menu"),
      ),
      body: const Center(
        child: Text(
          "Welcome to the Fomate App!",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
