part of 'pages.dart';

class PricingPage extends StatefulWidget {
  final String contentId;
  const PricingPage({required this.contentId});

  @override
  State<PricingPage> createState() => _PricingPageState();
}

class _PricingPageState extends State<PricingPage> {
  ContentViewModel contentViewModel = ContentViewModel();

  String userId = "676a498e14808629f4d44778";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String contentId = widget.contentId;

    return Scaffold(
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
            color: Colors.white,
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
                        userId,
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
                        userId,
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
