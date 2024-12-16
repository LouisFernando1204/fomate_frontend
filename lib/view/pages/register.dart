part of 'pages.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: const Color.fromARGB(255, 246, 250, 251),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/FomateLogo.png',
                height: 180,
              ),
              Text(
                "Fomate",
                style: TextStyle(
                  fontSize: 30, // Set font size
                  fontStyle: FontStyle.italic, // Italic style
                  fontWeight: FontWeight.bold, // Bold text
                ),
              ),
              Text(
                "Start balancing your screen time",
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                "and well-being",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 20), // Adds space between Image and TextField
              SizedBox(height: 20), // Adds space between Image and TextField
              Container(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 2.0),
                    ),
                  ),
                ),
                constraints: BoxConstraints(maxWidth: 350),
              ),

              SizedBox(height: 20),
              Container(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 2.0),
                    ),
                  ),
                ),
                constraints: BoxConstraints(maxWidth: 350),
              ),
              SizedBox(height: 20),
              Container(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 2.0),
                    ),
                  ),
                ),
                constraints: BoxConstraints(maxWidth: 350),
              ),
              SizedBox(height: 20),

              Container(
                child: ElevatedButton(
                  onPressed: () {
                    // Button pressed action
                    print("Button Pressed");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color.fromARGB(255, 2, 62, 138), // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                  ),
                  child: Text(
                    'Create account',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                constraints: BoxConstraints(maxWidth: 350),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",
                      style: TextStyle(color: Colors.grey)),
                  Text("Login",
                      style: TextStyle(
                          color: const Color.fromARGB(255, 72, 202, 228))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
