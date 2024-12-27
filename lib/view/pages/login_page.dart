part of 'pages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthViewModel authViewModel = AuthViewModel();

  final ctrlEmail = TextEditingController();
  final ctrlPassword = TextEditingController();

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.backgroundColor,
      body: ChangeNotifierProvider<AuthViewModel>(
        create: (context) => authViewModel,
        child: Consumer<AuthViewModel>(builder: (context, value, child) {
          return Stack(
            children: [
              SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Center(
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height,
                    ),
                    color: AppColors.textColor_0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/fomate_logo.png',
                            height: 160,
                          ),
                          Text(
                            "Fomate",
                            style: TextStyle(
                              fontSize: 32,
                              fontFamily: 'ProzaLibre',
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
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
                          const SizedBox(height: 32),
                          Container(
                            width: double.infinity,
                            child: TextField(
                              controller: ctrlEmail,
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                color: AppColors.textColor_1,
                              ),
                              enabled: !value.isLoading,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textColor_1,
                                  fontFamily: 'Poppins',
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.primaryColor,
                                      width: 2.0),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.secondaryColor,
                                      width: 2.0),
                                ),
                              ),
                            ),
                            constraints: const BoxConstraints(maxWidth: 350),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            child: TextField(
                              controller: ctrlPassword,
                              obscureText: !isPasswordVisible,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textColor_1,
                                  fontFamily: 'Poppins',
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.primaryColor,
                                      width: 2.0),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.secondaryColor,
                                      width: 2.0),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      isPasswordVisible = !isPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                color: AppColors.textColor_1,
                              ),
                              enabled: !value.isLoading,
                            ),
                            constraints: const BoxConstraints(maxWidth: 350),
                          ),
                          const SizedBox(height: 32),
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: value.isLoading
                                  ? null
                                  : () async {
                                      try {
                                        await authViewModel.login(
                                            context,
                                            ctrlEmail.text.toString(),
                                            ctrlPassword.text.toString());
                                      } catch (e) {
                                        print("Error while login: $e");
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.secondaryColor,
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
                              GestureDetector(
                                onTap: () {
                                  context.go('/register');
                                },
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (value.isLoading)
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black12,
                  child: Center(
                    child: CircularProgressIndicator(
                        color: AppColors.primaryColor),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
