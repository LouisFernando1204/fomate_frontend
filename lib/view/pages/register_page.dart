part of 'pages.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthViewModel authViewModel = AuthViewModel();

  final ctrlUsername = TextEditingController();
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
        child: Consumer<AuthViewModel>(
          builder: (context, value, child) {
            return Stack(
              children: [
                SingleChildScrollView(
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
                            const SizedBox(height: 6),
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
                              constraints: const BoxConstraints(maxWidth: 350),
                              child: TextField(
                                controller: ctrlUsername,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  color: AppColors.textColor_1,
                                ),
                                enabled: !value.isLoading,
                                decoration: InputDecoration(
                                  labelText: 'Username',
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
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: double.infinity,
                              constraints: const BoxConstraints(maxWidth: 350),
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
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: double.infinity,
                              constraints: const BoxConstraints(maxWidth: 350),
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
                            ),
                            const SizedBox(height: 32),
                            Container(
                              width: double.infinity,
                              constraints: const BoxConstraints(maxWidth: 350),
                              child: ElevatedButton(
                                onPressed: value.isLoading
                                    ? null
                                    : () async {
                                        try {
                                          await authViewModel.register(
                                              context,
                                              ctrlUsername.text.trim(),
                                              ctrlEmail.text.trim(),
                                              ctrlPassword.text.trim());
                                        } catch (e) {
                                          print("Error while register: $e");
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
                                  'Create account',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: AppColors.textColor_0,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account? ",
                                  style: TextStyle(
                                    color: AppColors.textColor_2,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => context.go('/login'),
                                  child: Text(
                                    "Login",
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
          },
        ),
      ),
    );
  }
}
