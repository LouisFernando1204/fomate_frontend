part of 'pages.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          true, // Allows screen to resize for the keyboard
      backgroundColor: AppColors.textColor_0,
      body: SingleChildScrollView(
        // Makes the content scrollable
        child: Container(
          color: AppColors.textColor_0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Image.asset(
                  'assets/images/FomateLogo.png',
                  height: 220,
                ),
                Text(
                  "Fomate",
                  style: TextStyle(
                    fontSize: 32, // Set font size
                    fontFamily: 'ProzaLibre',
                    fontStyle: FontStyle.italic, // Italic style
                    fontWeight: FontWeight.bold, // Bold text
                  ),
                ),
                Text(
                  "Start balancing your screen time",
                  style: TextStyle(
                      color: AppColors.textColor_2,
                      fontFamily: 'Poppins',
                      fontSize: 14),
                ),
                Text(
                  "and well-being",
                  style: TextStyle(
                      color: AppColors.textColor_2,
                      fontFamily: 'Poppins',
                      fontSize: 14),
                ),
                const SizedBox(height: 20),
                Container(
                  child: TextField(
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      color: AppColors.textColor_1,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        fontSize: 14,
                        color: AppColors.textColor_1,
                        fontFamily: 'Poppins',
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12), // Adjust padding
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.primaryColor, width: 2.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.secondaryColor, width: 2.0),
                      ),
                    ),
                  ),
                  constraints: const BoxConstraints(maxWidth: 350),
                ),
                const SizedBox(height: 20),
                Container(
                  child: TextField(
                    obscureText: true, // Hides the password
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      color: AppColors.textColor_1,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        fontSize: 14,
                        color: AppColors.textColor_1,
                        fontFamily: 'Poppins',
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12), // Adjust padding
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.primaryColor, width: 2.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.secondaryColor, width: 2.0),
                      ),
                    ),
                  ),
                  constraints: const BoxConstraints(maxWidth: 350),
                ),
                const SizedBox(height: 20),
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      // Button pressed action
                      print("Button Pressed");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryColor, // Button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 100, vertical: 10),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.textColor_0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  constraints: const BoxConstraints(maxWidth: 350),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? ",
                        style: TextStyle(
                          color: AppColors.textColor_2,
                          fontFamily: 'Poppins',
                        )),
                    Text("Register",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
