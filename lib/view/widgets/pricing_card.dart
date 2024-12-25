part of 'widgets.dart';

class PricingCard extends StatefulWidget {
  final String title;
  final Color titleColor;
  final String price;
  final String description;
  final List<String> features;
  final Color color;
  final Color textColor;
  final Color dividerColor;
  final Color checkCircleColor;
  final Color? borderColor;
  final Color buttonContentColor;
  final String contentId;
  final String userId;
  final ContentViewModel contentViewModel;
  const PricingCard(
    this.title,
    this.titleColor,
    this.price,
    this.description,
    this.features,
    this.color,
    this.textColor,
    this.dividerColor,
    this.checkCircleColor,
    this.borderColor,
    this.buttonContentColor,
    this.contentId,
    this.userId,
    this.contentViewModel,
  );

  @override
  State<PricingCard> createState() => _PricingCardState();
}

class _PricingCardState extends State<PricingCard> {
  @override
  Widget build(BuildContext context) {
    String title = widget.title;
    Color titleColor = widget.titleColor;
    String price = widget.price;
    String description = widget.description;
    List<String> features = widget.features;
    Color color = widget.color;
    Color textColor = widget.textColor;
    Color dividerColor = widget.dividerColor;
    Color checkCircleColor = widget.checkCircleColor;
    Color borderColor = widget.borderColor!;
    Color buttonContentColor = widget.buttonContentColor;
    String contentId = widget.contentId;
    String userId = widget.userId;
    ContentViewModel contentViewModel = widget.contentViewModel;

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
            color: AppColors.textColor_1.withOpacity(0.2),
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
                onPressed: () async {
                  try {
                    if (title == "Lifetime Deal") {
                      await contentViewModel.purchaseAllContent(userId);
                      context.push('/content_list');
                    } else {
                      print("MASUK KE SINGLE DEAL!");
                      await contentViewModel.purchaseContent(userId, contentId);
                      context.push('/content_detail/${contentId}');
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
