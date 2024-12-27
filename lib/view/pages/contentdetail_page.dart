part of 'pages.dart';

class ContentDetailPage extends StatefulWidget {
  final String contentId;
  const ContentDetailPage({required this.contentId});

  @override
  State<ContentDetailPage> createState() => _ContentDetailPageState();
}

class _ContentDetailPageState extends State<ContentDetailPage> {
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
            fontSize: 20,
          ),
        ),
      ),
      body: ChangeNotifierProvider<ContentViewModel>(
        create: (context) => contentViewModel,
        child: Consumer<ContentViewModel>(
          builder: (context, value, _) {
            switch (value.purchasedContents.status) {
              case Status.loading:
                return Center(
                  child:
                      CircularProgressIndicator(color: AppColors.primaryColor),
                );
              case Status.error:
                return Center(
                  child: Text(
                    'Failed to load content: ${value.purchasedContents.message}',
                    style: TextStyle(color: Colors.red),
                  ),
                );
              case Status.completed:
                final String? contentLink =
                    value.purchasedContents.data?[0].contentLink;
                final String? videoId = contentLink != null
                    ? Uri.parse(contentLink).host.contains('youtu.be')
                        ? contentLink
                            .split('/')
                            .last
                            .split('?')
                            .first
                            .split('=')
                            .last
                        : Uri.parse(contentLink).queryParameters['v'] ??
                            contentLink.split('/').last.split('?').first
                    : 'JE4lT3e3xFU';
                final YoutubePlayerController _controller =
                    YoutubePlayerController(
                  initialVideoId: videoId!,
                  flags: const YoutubePlayerFlags(
                    autoPlay: false,
                    mute: false,
                  ),
                );
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (value.purchasedContents.data![1] == true)
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: YoutubePlayer(
                                controller: _controller,
                                showVideoProgressIndicator: true,
                                progressIndicatorColor: AppColors.primaryColor,
                              ),
                            ),
                          )
                        else
                          Center(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: YoutubePlayer(
                                    controller: _controller,
                                    showVideoProgressIndicator: true,
                                    progressIndicatorColor:
                                        AppColors.primaryColor,
                                  ),
                                ),
                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Center(
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            width: 64,
                                            height: 64,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.textColor_1,
                                            ),
                                          ),
                                          Icon(
                                            Icons.lock,
                                            size: 40,
                                            color: AppColors.primaryColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        SizedBox(height: 20),
                        Text(
                          value.purchasedContents.data![0].contentTitle!,
                          style: TextStyle(
                            color: AppColors.textColor_1,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Description",
                          style: TextStyle(
                            color: AppColors.textColor_1,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 12),
                        if (value.purchasedContents.data![1] == true)
                          Text(
                              value.purchasedContents.data![0]
                                  .contentDescription!,
                              style: TextStyle(
                                color: AppColors.textColor_2,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.justify)
                        else
                          Text(
                            value
                                .purchasedContents.data![0].contentDescription!,
                            style: TextStyle(
                              color: AppColors.textColor_2,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.justify,
                          ),
                        if (value.purchasedContents.data![1] == false)
                          SizedBox(height: 20),
                        if (value.purchasedContents.data![1] == false)
                          Text(
                            "What you'll learn",
                            style: TextStyle(
                              color: AppColors.textColor_1,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        if (value.purchasedContents.data![1] == false)
                          SizedBox(height: 10),
                        if (value.purchasedContents.data![1] == false)
                          for (var insight in value
                              .purchasedContents.data![0].contentInsights!)
                            Checklist(insight),
                        SizedBox(height: 28),
                        if (value.purchasedContents.data![1] == false)
                          Container(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              icon:
                                  Icon(Icons.shopping_bag, color: Colors.white),
                              label: Text(
                                "Buy now",
                                style: TextStyle(
                                    color: AppColors.textColor_0,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.secondaryColor,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              onPressed: () {
                                context.push('/pricing/${contentId}');
                              },
                            ),
                          )
                        else
                          Container(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              label: Text(
                                "Done",
                                style: TextStyle(
                                    color: AppColors.textColor_0,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.secondaryColor,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              onPressed: () {
                                context.go('/mainmenu');
                              },
                            ),
                          )
                      ],
                    ),
                  ),
                );
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
}
