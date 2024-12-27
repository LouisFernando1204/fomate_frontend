part of 'pages.dart';

class PricingPage extends StatefulWidget {
  final String contentId;
  const PricingPage({required this.contentId});

  @override
  State<PricingPage> createState() => _PricingPageState();
}

class _PricingPageState extends State<PricingPage> {
  ContentViewModel contentViewModel = ContentViewModel();

  String? userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    var userData = await UserLocalStorage.getUserData();
    setState(() {
      userId = userData?.id;
    });
    if (userId != null) {
      print("USER ID: " + userId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    String contentId = widget.contentId;

    if (userId == null) {
      return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        resizeToAvoidBottomInset: true,
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
            "Pricing",
            style: TextStyle(
              color: AppColors.textColor_0,
              fontFamily: 'Poppins',
              fontSize: 20,
            ),
          ),
        ),
        body: Center(
          child: CircularProgressIndicator(color: AppColors.primaryColor),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      resizeToAvoidBottomInset: true,
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
          "Pricing",
          style: TextStyle(
            color: AppColors.textColor_0,
            fontFamily: 'Poppins',
            fontSize: 20,
          ),
        ),
      ),
      body: ChangeNotifierProvider<ContentViewModel>(
        create: (context) => contentViewModel,
        child: Stack(children: [
          Container(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PricingCard(
                        "Lifetime Deal",
                        AppColors.textColor_1,
                        "Rp. 149.900,00",
                        "Unlock full educational content, exclusive articles, and videos.",
                        [
                          "Unlimited Video Access: Watch exclusive educational videos on digital wellness and social media management.",
                          "Practical Strategies: Discover actionable techniques to manage screen time and build healthier digital habits."
                        ],
                        AppColors.primaryColor,
                        AppColors.textColor_0,
                        AppColors.textColor_1,
                        AppColors.textColor_0,
                        AppColors.textColor_0,
                        AppColors.primaryColor,
                        contentId,
                        userId!,
                        contentViewModel),
                    const SizedBox(height: 16),
                    PricingCard(
                        "Single Deal",
                        AppColors.textColor_1,
                        "Rp. 79.900,00",
                        "Unlock one selected educational content, including a video and article, to boost your well-being.",
                        [
                          "Single Video Access: Watch an exclusive video on topics like digital wellness or social media management.",
                          "Practical Insights: Learn actionable tips and strategies to manage screen time and build healthier habits."
                        ],
                        AppColors.textColor_0,
                        AppColors.primaryColor,
                        AppColors.textColor_1,
                        AppColors.textColor_1,
                        AppColors.textColor_0,
                        AppColors.textColor_0,
                        contentId,
                        userId!,
                        contentViewModel),
                  ],
                ),
              ),
            ),
          ),
          Consumer<ContentViewModel>(
            builder: (context, value, child) {
              if (value.isLoading) {
                return Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black12,
                  child: Center(
                    child: CircularProgressIndicator(
                        color: AppColors.primaryColor),
                  ),
                );
              }
              return Container();
            },
          )
        ]),
      ),
    );
  }
}
