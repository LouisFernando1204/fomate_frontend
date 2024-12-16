part of 'pages.dart';

class ContentDetailpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF48CAE4),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white, // Menetapkan warna putih pada ikon
          ),
        ),
        title: const Text(
          "Content Detail",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/ContentVideo.png',
                  height: 200,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Social Media Impacts Mental Health? ",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontSize: 20.0),
              ),
              SizedBox(height: 20),
              Text("Description",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black87,
                      fontSize: 20.0)),
              SizedBox(height: 20),
              Text(
                "Did you know that excessive use of social media can impact mental health? In this content, we will discuss how social media affects an individual's well-being, such as mood and self confidence.",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 20),
              Text("What you'll learn",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black87,
                      fontSize: 20.0)),
              SizedBox(height: 10),
              checklist(
                  title:
                      "Understanding the impact of social media on mental health."),
              checklist(
                  title: "Recognizing the signs of social media addiction."),
              checklist(title: "Building healthier relationships online."),
              checklist(title: "Strategies for maintaining digital balance."),
              checklist(title: "The benefits of a digital detox.")
            ],
          ),
        ),
      ),
    );
  }

  Widget checklist({required String title}) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/check.png',
            ),
            SizedBox(width: 10),
            Flexible(
              // Ensures the text wraps within the available width
              child: Text(
                title,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
