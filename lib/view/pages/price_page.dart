part of 'pages.dart';

class PricePage extends StatefulWidget {
  const PricePage({super.key});

  @override
  State<PricePage> createState() => _PricePageState();
}

class _PricePageState extends State<PricePage> {
  PricingViewmodel pricingViewmodel = PricingViewmodel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            color: AppColors.textColor_0, // Menetapkan warna putih pada ikon
          ),
        ),
        title: const Text(
          "Pricing",
          style: TextStyle(
            color: AppColors.textColor_0,
            fontFamily: 'Poppins',
            fontSize: 22,
          ),
        ),
      ),
      body: Container(
        color: Colors.white, // Set the background color to white
        child: ChangeNotifierProvider<PricingViewmodel>(
          create: (_) => pricingViewmodel,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildPricingCard(
                    title: "Lifetime Deal",
                    titleColor: AppColors.textColor_1,
                    price: "Rp. 149.900,00",
                    description:
                        "Unlock full educational content, exclusive articles, and videos.",
                    features: [
                      "Unlimited Video Access: Watch exclusive educational videos on digital wellness and social media management.",
                      "Practical Strategies: Discover actionable techniques to manage screen time and build healthier digital habits."
                    ],
                    color: AppColors.primaryColor,
                    textColor: AppColors.textColor_0,
                    checkCircleColor: AppColors.textColor_1,
                    dividerColor: AppColors.textColor_0,
                    buttonContentColor: AppColors.primaryColor,
                  ),
                  const SizedBox(height: 16),
                  _buildPricingCard(
                    title: "Single Deal",
                    titleColor: AppColors.textColor_1,
                    price: "Rp. 79.900,00",
                    description:
                        "Unlock one selected educational content, including a video and article, to boost your well-being.",
                    features: [
                      "Single Video Access: Watch an exclusive video on topics like digital wellness or social media management.",
                      "Practical Insights: Learn actionable tips and strategies to manage screen time and build healthier habits."
                    ],
                    color: AppColors.textColor_0,
                    textColor: AppColors.primaryColor,
                    dividerColor: AppColors.textColor_1,
                    checkCircleColor: AppColors.textColor_1,
                    borderColor: AppColors.primaryColor,
                    buttonContentColor: AppColors.textColor_0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPricingCard({
    required String title,
    required Color titleColor,
    required String price,
    required String description,
    required List<String> features,
    required Color color,
    required Color textColor,
    required Color dividerColor,
    required Color checkCircleColor,
    Color? borderColor,
    required Color buttonContentColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: title == "Lifetime Deal"
            ? LinearGradient(
                colors: [AppColors.primaryColor, AppColors.secondaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: title != "Lifetime Deal" ? color : null,
        borderRadius: BorderRadius.circular(12.0),
        border: borderColor != null
            ? Border.all(color: borderColor, width: 1.5)
            : null,
        boxShadow: [
          BoxShadow(
            color: AppColors.textColor_1.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: AppColors.textColor_1,
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Icon(
                  Icons.lock_open,
                  color: AppColors.primaryColor,
                  size: 32.0,
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                title,
                style: TextStyle(
                  color: titleColor,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Text(
            price,
            style: TextStyle(
              color: textColor,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w900,
              fontSize: 24.0,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            description,
            style: TextStyle(
              color: textColor.withOpacity(0.9),
              fontFamily: 'Poppins',
              fontSize: 14.0,
            ),
          ),
          const SizedBox(height: 8.0),
          Divider(
            color: dividerColor,
            thickness: 1.0,
          ),
          const SizedBox(height: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: features
                .map(
                  (feature) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: checkCircleColor,
                          size: 20.0,
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: feature.split(":")[0] + ": ",
                                  style: TextStyle(
                                    color: textColor.withOpacity(0.9),
                                    fontSize: 14.0,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(
                                  text: feature.split(":")[1],
                                  style: TextStyle(
                                    color: textColor.withOpacity(0.9),
                                    fontSize: 14.0,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16.0),
          Center(
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  try {
                    if (title == "Lifetime Deal") {
                      pricingViewmodel
                          .purchaseAllContent("675bbf18ac9914f7212128f7");
                    } else {
                      pricingViewmodel.purchaseContent(
                          "675bbf18ac9914f7212128f7",
                          "675beec515b742ed2895a34f");
                    }
                  } catch (e) {
                    print("Terjadi kesalahan saat melakukan pembelian: $e");
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: textColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                ),
                child: Text(
                  "Purchase",
                  style: TextStyle(
                    color: buttonContentColor,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
