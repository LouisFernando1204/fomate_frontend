part of 'pages.dart';

class ContentDetailpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: 'aHku2K9G89M', // Replace with your YouTube video ID
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.textColor_0, 
          ),
        ),
        title: const Text(
          "Content Detail",
          style: TextStyle(
            color: AppColors.textColor_0,
            fontFamily: 'Poppins',
            fontSize: 22,
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0), 
                  child: YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: AppColors.primaryColor,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Social Media Impacts Mental Health? ",
                style: TextStyle(
                  color: AppColors.textColor_1,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 20),
              Text("Description",
                  style: TextStyle(
                    color: AppColors.textColor_1,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  )),
              SizedBox(height: 12),
              Text(
                "Did you know that excessive use of social media can impact mental health? In this content, we will discuss how social media affects an individual's well-being, such as mood and self confidence.",
                style: TextStyle(
                  color: AppColors.textColor_2,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 20),
              Text("What you'll learn",
                  style: TextStyle(
                    color: AppColors.textColor_1,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  )),
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
        padding:
            const EdgeInsets.symmetric(vertical: 5.0), 
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.check,
              color: Colors.green,
              size: 22,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: AppColors.textColor_2, 
                  fontFamily: 'Poppins',
                  fontWeight:
                      FontWeight.w400,
                  fontSize: 14, 
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
