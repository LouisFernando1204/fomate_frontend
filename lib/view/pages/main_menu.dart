part of 'pages.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _currentIndex = 0;

  // Add all pages for the bottom navigation
  final List<Widget> _pages = [
    HomePage(), // Home Page content
    BlueLoadingPage2(), // Content Page content (if available)
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundColor, // Background color of the bar
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Shadow color
              blurRadius: 20, // Blur radius of the shadow
              offset: Offset(0, -5), // Position of the shadow (above the bar)
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book),
              label: 'Content',
            ),
          ],
          selectedItemColor: AppColors.secondaryColor, // Color for the selected item
          unselectedItemColor: Colors.grey, // Color for unselected items
          backgroundColor:
              AppColors.backgroundColor, // Color for the bottom bar
        ),
      ),
    );
  }
}
