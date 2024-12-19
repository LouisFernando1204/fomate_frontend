part of 'pages.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 23),
            _greetingSection(),
            SizedBox(height: 20),
            _healthPointSection(),
            SizedBox(height: 20),
            _insightSection(),
            SizedBox(height: 20),
            _scheduleSection(),
            SizedBox(height: 20),
            _arrangeScheduleButton(context),
          ],
        ),
      ),
    );
  }

  Widget _greetingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/FomateLogo.png",
                height: 60,
                width: 60,
              ),
              Text(
                "Hello, LynLyn!",
                style: TextStyle(
                    fontSize: 18,
                    color: AppColors.textColor_1,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins'),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Center(
          child: Image.asset(
            "assets/images/LynLyn1.png",
            height: 280,
          ),
        ),
      ],
    );
  }

  Widget _healthPointSection() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.center, // Center-aligns children horizontally
      children: [
        Text(
          "Health Point:",
          style: TextStyle(
              fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.center, // Centers the row content
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: 0.7,
                    backgroundColor: Colors.grey[300],
                    color: Colors.green,
                    minHeight: 15,
                  ),
                ),
              ),
              SizedBox(
                  width: 10), // Adds spacing between the bar and percentage
              Text(
                "70%",
                style: TextStyle(
                  fontSize: 16, 
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _insightSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center, // Align content to the center
          children: [
            Center(
              child: Text(
                "Insights!",
                style: TextStyle(
                  color: AppColors.textColor_0,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 5),
            Center(
              child: Text(
                '"Excessive social media can affect your mental health. Take a break, clear your mind, and reconnect with the real world!"',
                style: TextStyle(
                    color: AppColors.textColor_0,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.italic),
                textAlign: TextAlign.center, // Center-aligns multi-line text
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _scheduleSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your Schedule Today",
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 10),
          _scheduleTile(
            "Check-in on Social Media",
            "09:10 - 09:50",
            true,
          ),
          _scheduleTile(
            "Outdoor Walk or Light Exercise",
            "10:30 - 11:30",
            true,
          ),
          _scheduleTile(
            "Hobby Time",
            "13:00 - 13:30",
            false,
          ),
        ],
      ),
    );
  }

  Widget _scheduleTile(String title, String time, bool isCompleted) {
    return Card(
      elevation: 14, // Increased elevation for a more prominent shadow
      shadowColor: Colors.black
          .withOpacity(0.4), // Optional: Adjust shadow color and opacity
      color: AppColors.textColor_0,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: AppColors.secondaryColor,
          ),
        ),
        subtitle: Text(
          time,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryColor,
          ),
        ),
        trailing: Icon(
          isCompleted ? Icons.check_circle : Icons.cancel,
          color: isCompleted ? Colors.green : Colors.red,
        ),
      ),
    );
  }

  Widget _arrangeScheduleButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Center(
        child: ElevatedButton.icon(
          icon: Icon(Icons.calendar_today, color: Colors.white),
          label: Text(
            "Arrange your schedule",
            style: TextStyle(
            color: AppColors.textColor_0, 
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondaryColor,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainMenu()),
            );
          },
        ),
      ),
    );
  }
}
