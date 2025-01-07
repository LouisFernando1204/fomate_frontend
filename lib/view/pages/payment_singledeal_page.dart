part of 'pages.dart';

class PaymentSingleDealPage extends StatefulWidget {
  final String contentId;
  const PaymentSingleDealPage({required this.contentId});

  @override
  State<PaymentSingleDealPage> createState() => _PaymentSingleDealPageState();
}

class _PaymentSingleDealPageState extends State<PaymentSingleDealPage> {
  ContentViewModel contentViewModel = ContentViewModel();

  int _selectedPaymentMethod = 0;

  final ctrlCardNumber = TextEditingController();
  final ctrlExpiration = TextEditingController();
  final ctrlCVV = TextEditingController();
  final ctrlCouponCode = TextEditingController();
  int totalPrice = 79900;

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
      String contentId = widget.contentId;
      contentViewModel.checkPurchasedContent(userId!, contentId);
    }
  }

  @override
  Widget build(BuildContext context) {
    String contentId = widget.contentId;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.textColor_0,
          ),
        ),
        title: Text(
          "Payment",
          style: TextStyle(
            color: AppColors.textColor_0,
            fontFamily: 'Poppins',
            fontSize: 20,
          ),
        ),
      ),
      body: ChangeNotifierProvider<ContentViewModel>(
        create: (context) => contentViewModel,
        child: Consumer<ContentViewModel>(builder: (context, value, child) {
          switch (value.purchasedContents.status) {
            case Status.loading:
              return Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              );
            case Status.error:
              return Center(
                child: Text(
                  'Failed to load content: ${value.purchasedContents.message}',
                  style: TextStyle(color: Colors.red),
                ),
              );
            case Status.completed:
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Center(
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Payment Method",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 14),
                              Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _selectedPaymentMethod = 0;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color:
                                                    _selectedPaymentMethod == 0
                                                        ? Colors.blue[50]
                                                        : Colors.transparent,
                                                border: Border.all(
                                                  color:
                                                      _selectedPaymentMethod ==
                                                              0
                                                          ? AppColors
                                                              .secondaryColor
                                                          : Colors.grey,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    "assets/images/visa_mastercard.png",
                                                    height: 24,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _selectedPaymentMethod = 1;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color:
                                                    _selectedPaymentMethod == 1
                                                        ? Colors.blue[50]
                                                        : Colors.transparent,
                                                border: Border.all(
                                                  color:
                                                      _selectedPaymentMethod ==
                                                              1
                                                          ? AppColors
                                                              .secondaryColor
                                                          : Colors.grey,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    "assets/images/paypal.png",
                                                    height: 24,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                    TextField(
                                      controller: ctrlCardNumber,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Poppins',
                                        color: AppColors.textColor_1,
                                      ),
                                      decoration: InputDecoration(
                                        labelText: 'Card Number',
                                        hintText: '0000-0000-0000-0000',
                                        labelStyle: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.textColor_1,
                                          fontFamily: 'Poppins',
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 18),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.primaryColor,
                                              width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.secondaryColor,
                                              width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        prefixIcon: Icon(Icons.credit_card),
                                      ),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(16),
                                        TextInputFormatter.withFunction(
                                          (oldValue, newValue) {
                                            String text = newValue.text
                                                .replaceAll(RegExp(r'\D'), '');
                                            StringBuffer newText =
                                                StringBuffer();
                                            for (int i = 0;
                                                i < text.length;
                                                i++) {
                                              if (i > 0 && i % 4 == 0) {
                                                newText.write('-');
                                              }
                                              newText.write(text[i]);
                                            }
                                            return newValue.copyWith(
                                              text: newText.toString(),
                                              selection:
                                                  TextSelection.collapsed(
                                                      offset: newText.length),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: TextField(
                                          controller: ctrlExpiration,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                          ),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(5),
                                            TextInputFormatter.withFunction(
                                                (oldValue, newValue) {
                                              String text = newValue.text
                                                  .replaceAll('/', '');
                                              String formattedText = '';
                                              if (text.length >= 2) {
                                                formattedText =
                                                    '${text.substring(0, 2)}/${text.substring(2)}';
                                              } else {
                                                formattedText = text;
                                              }
                                              if (formattedText.length > 5) {
                                                formattedText = formattedText
                                                    .substring(0, 5);
                                              }
                                              return TextEditingValue(
                                                text: formattedText,
                                                selection:
                                                    TextSelection.collapsed(
                                                        offset: formattedText
                                                            .length),
                                              );
                                            }),
                                          ],
                                          decoration: InputDecoration(
                                            labelText: 'Expiration',
                                            hintText: 'MM/YY',
                                            labelStyle: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontFamily: 'Poppins',
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 18),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColors.primaryColor,
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      AppColors.secondaryColor,
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            prefixIcon:
                                                Icon(Icons.calendar_today),
                                          ),
                                        )),
                                        SizedBox(width: 16),
                                        Expanded(
                                          child: TextField(
                                            controller: ctrlCVV,
                                            obscureText: true,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Poppins',
                                              color: AppColors.textColor_1,
                                            ),
                                            decoration: InputDecoration(
                                              labelText: 'CVV',
                                              hintText: '•••',
                                              labelStyle: TextStyle(
                                                fontSize: 14,
                                                color: AppColors.textColor_1,
                                                fontFamily: 'Poppins',
                                              ),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 18),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        AppColors.primaryColor,
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: AppColors
                                                        .secondaryColor,
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              prefixIcon: Icon(Icons.lock),
                                            ),
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  3),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                "You're buying",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 14),
                              Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Image.network(
                                              value.purchasedContents.data![0]
                                                  .contentThumbnail!,
                                              width: 60,
                                              height: 60,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(width: 12),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                value
                                                            .purchasedContents
                                                            .data![0]
                                                            .contentTitle!
                                                            .length >
                                                        15
                                                    ? '${value.purchasedContents.data![0].contentTitle!.substring(0, 25)}...'
                                                    : value.purchasedContents
                                                        .data![0].contentTitle!,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Poppins',
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Sales Tax (5%):",
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          "Rp. ${NumberFormat.currency(locale: 'id', symbol: '', decimalDigits: 0).format((79900) * (5 / 100))}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "TOTAL:",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          "Rp. ${NumberFormat.currency(locale: 'id', symbol: '', decimalDigits: 0).format(totalPrice)}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                    TextField(
                                      controller: ctrlCouponCode,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Poppins',
                                        color: AppColors.textColor_1,
                                      ),
                                      decoration: InputDecoration(
                                        labelText: 'Coupon code',
                                        labelStyle: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.textColor_1,
                                          fontFamily: 'Poppins',
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 18),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.primaryColor,
                                              width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.secondaryColor,
                                              width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        prefixIcon:
                                            Icon(Icons.confirmation_num),
                                        suffixIcon: TextButton(
                                          onPressed: () {
                                            setState(() {
                                              totalPrice -= ((totalPrice * 0.05)
                                                  .truncate());
                                            });
                                          },
                                          child: Text(
                                            "Apply",
                                            style: TextStyle(
                                                color: AppColors.secondaryColor,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 24),
                              Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    try {
                                      await contentViewModel.purchaseContent(
                                          context, userId!, contentId);
                                    } catch (e) {
                                      print(
                                          "Error while purchasing all content: $e");
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.secondaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 100, vertical: 10),
                                  ),
                                  child: Text(
                                    'Buy now',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: AppColors.textColor_0,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
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
            default:
              return Container();
          }
        }),
      ),
    );
  }
}
