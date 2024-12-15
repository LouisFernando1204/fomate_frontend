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
        leading:
            IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
        title: const Text(
            style: TextStyle(
              color: Colors.white,
            ),
            "Pricing"),
      ),
      body: ChangeNotifierProvider<PricingViewmodel>(
          create: (context) => pricingViewmodel,
          child: const SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  
                ],
              ),
            ),
          )),
    );
  }
}
