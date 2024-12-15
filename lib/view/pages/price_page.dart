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
        backgroundColor: Color(0xFF48CAE4),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          "Pricing",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: ChangeNotifierProvider<PricingViewmodel>(
        create: (context) => pricingViewmodel,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildPricingCard(
                  title: "Lifetime Deal",
                  price: "Rp. 149.900,00",
                  description:
                      "Unlock full educational content, exclusive articles, and videos.",
                  features: [
                    "Unlimited Video Access: Watch exclusive educational videos on digital wellness and social media management.",
                    "Practical Strategies: Discover actionable techniques to manage screen time and build healthier digital habits."
                  ],
                  color: Color(0xFF48CAE4),
                  textColor: Colors.white,
                  dividerColor: Colors.white
                ),
                const SizedBox(height: 16),
                _buildPricingCard(
                  title: "Single Deal",
                  price: "Rp. 79.900,00",
                  description:
                      "Unlock one selected educational content, including a video and article, to boost your well-being.",
                  features: [
                    "Single Video Access: Watch an exclusive video on topics like digital wellness or social media management.",
                    "Practical Insights: Learn actionable tips and strategies to manage screen time and build healthier habits."
                  ],
                  color: Colors.white,
                  textColor: Color(0xFF48CAE4),
                  dividerColor: Colors.black,
                  borderColor: Color(0xFF48CAE4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPricingCard({
    required String title,
    required String price,
    required String description,
    required List<String> features,
    required Color color,
    required Color textColor,
    required Color dividerColor,
    Color? borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.0),
        border: borderColor != null
            ? Border.all(color: borderColor, width: 1.5)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
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
              Icon(
                Icons.lock,
                color: textColor,
                size: 32.0,
              ),
              const SizedBox(width: 8.0),
              Text(
                title,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Text(
            price,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            description,
            style: TextStyle(
              color: textColor.withOpacity(0.9),
              fontSize: 14.0,
            ),
          ),
          const SizedBox(height: 8.0),
          Divider(
            color: dividerColor, // Warna garis
            thickness: 1.0, // Ketebalan garis
          ),
          const SizedBox(height: 8.0), // Jarak setelah garis

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
                          color: textColor,
                          size: 20.0,
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            feature,
                            style: TextStyle(
                              color: textColor.withOpacity(0.9),
                              fontSize: 14.0,
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
              width: double.infinity, // Membuat tombol memiliki lebar maksimum
              child: ElevatedButton(
                onPressed: () {
                  // Handle purchase button action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: textColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0), // Hanya padding vertikal
                ),
                child: Text(
                  "Purchase",
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
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
