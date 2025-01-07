part of 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  TimerViewModel timerViewModel = TimerViewModel();
  AuthViewModel authViewModel = AuthViewModel();
  HomeViewModel homeViewModel = HomeViewModel();

  User? user;

  final List<String> insights = [
    "Excessive social media can affect your mental health. Take a break and clear your mind.",
    "Spend time offline to connect with nature and loved ones. Social media can wait.",
    "Remember to set boundaries for your social media usage to maintain a healthy balance.",
    "Digital detox isn't just a trend—it's a way to reclaim your time and energy.",
    "Quality over quantity! Use social media purposefully and avoid mindless scrolling."
  ];
  String currentInsight = "";
  Timer? _timer;
  void _setRandomInsight() {
    setState(() {
      currentInsight = insights[Random().nextInt(insights.length)];
    });
  }

  void _startInsightTimer() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      _setRandomInsight();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUser();
    WidgetsBinding.instance.addObserver(this);
    _setRandomInsight();
    _startInsightTimer();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _loadUser();
    }
  }

  Future<void> saveSelectedApps(String? selectedApp) async {
    if (selectedApp == null) return;
    timerViewModel.apps.clear();
    timerViewModel
        .addApp(AppModel(appName: selectedApp, packageName: selectedApp));
  }

  Future<void> _loadUser() async {
    var userData = await UserLocalStorage.getUserData();
    setState(() {
      user = userData;
    });
    if (user != null) {
      print("USER LOADED: ${user.toString()}");
      try {
        print("USER ID: " + user!.id!);
        await homeViewModel.getHomeData(user!.id!);
      } catch (e) {
        print("ERROR FETCHING HOME DATA: $e");
      }
    } else {
      print("USER DATA NOT FOUND.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.backgroundColor,
      body: ChangeNotifierProvider<HomeViewModel>(
        create: (context) => homeViewModel,
        child: Consumer<HomeViewModel>(builder: (context, value, child) {
          return Stack(children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 38),
                  _greetingSection(
                      context, authViewModel, user ?? User(username: 'Guest')),
                  _userAvatar(value),
                  SizedBox(height: 16),
                  _healthPointSection(value),
                  SizedBox(height: 20),
                  _insightSection(currentInsight),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Your Schedule",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  _scheduleSection(value, timerViewModel),
                  SizedBox(height: 32),
                  _arrangeScheduleButton(
                      context, timerViewModel, saveSelectedApps, value),
                  SizedBox(height: 32),
                ],
              ),
            ),
            if (value.isLoading)
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: double.infinity,
                color: AppColors.backgroundColor,
                child: Center(
                  child:
                      CircularProgressIndicator(color: AppColors.primaryColor),
                ),
              ),
          ]);
        }),
      ),
    );
  }
}

Widget _greetingSection(
    BuildContext context, AuthViewModel authViewModel, User user) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5.0),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              "assets/images/fomate_logo.png",
              height: 50,
              width: 50,
            ),
            SizedBox(width: 4),
            Text(
              "Hello, ${user.username}!",
              style: TextStyle(
                  fontSize: 18,
                  color: AppColors.textColor_1,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins'),
            ),
          ]),
          ElevatedButton.icon(
            icon: Icon(Icons.logout, color: Colors.white, size: 20),
            label: Text(
              "Logout",
              style: TextStyle(
                  color: AppColors.textColor_0,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondaryColor,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            onPressed: () {
              try {
                authViewModel.logout(context);
              } catch (e) {
                print("Error while logout: $e");
              }
            },
          ),
        ],
      ),
    ),
  );
}

Widget _userAvatar(HomeViewModel value) {
  String avatarPath;

  switch (value.userHealth.status) {
    case Status.loading:
      return Center(
        child: CircularProgressIndicator(color: AppColors.primaryColor),
      );
    case Status.error:
      return Center(
        child: Text(
          'Failed to load userHealth: ${value.userHealth.message}',
          style: TextStyle(color: Colors.red),
        ),
      );
    case Status.completed:
      if (value.userHealth.data! >= 80) {
        avatarPath = "assets/images/AvatarAsset1.png";
      } else if (value.userHealth.data! >= 60) {
        avatarPath = "assets/images/AvatarAsset2.png";
      } else if (value.userHealth.data! >= 40) {
        avatarPath = "assets/images/AvatarAsset3.png";
      } else if (value.userHealth.data! >= 20) {
        avatarPath = "assets/images/AvatarAsset4.png";
      } else {
        avatarPath = "assets/images/AvatarAsset5.png";
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Center(
            child: Image.asset(
              avatarPath,
              height: 280,
            ),
          ),
        ],
      );
    default:
      return Container();
  }
}

Widget _healthPointSection(HomeViewModel value) {
  switch (value.userHealth.status) {
    case Status.loading:
      return Center(
        child: CircularProgressIndicator(color: AppColors.primaryColor),
      );
    case Status.error:
      return Center(
        child: Text(
          'Failed to load user health: ${value.userHealth.message}',
          style: TextStyle(color: Colors.red),
        ),
      );
    case Status.completed:
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Health Point:",
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: value.userHealth.data! / 100,
                      backgroundColor: Colors.grey[300],
                      color: Colors.green,
                      minHeight: 15,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "${value.userHealth.data!}%",
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      );
    default:
      return Container();
  }
}

Widget _insightSection(String currentInsight) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Insights!",
              style: TextStyle(
                color: AppColors.textColor_0,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 5),
          Center(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 800),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: Text(
                '"$currentInsight"',
                key: ValueKey<String>(currentInsight),
                style: TextStyle(
                  color: AppColors.textColor_0,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _scheduleSection(HomeViewModel value, TimerViewModel timerViewModel) {
  List<Widget> scheduleWidgets = [];
  if (timerViewModel.getAllApps().isNotEmpty) {
    scheduleWidgets.add(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...timerViewModel.getAllApps().map((app) {
              return _scheduleTile(
                app.appName ?? "No App Name",
                "Usage Time: ... \nTimer: ${timerViewModel.timerDuration} minute(s)",
                "trying",
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
  switch (value.scheduleList.status) {
    case Status.loading:
      scheduleWidgets.add(
        Center(
          child: CircularProgressIndicator(color: AppColors.primaryColor),
        ),
      );
    case Status.error:
      scheduleWidgets.add(
        Center(
          child: Text(
            'Failed to load schedule list: ${value.scheduleList.message}',
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
    case Status.completed:
      if ((value.scheduleList.data == null ||
              value.scheduleList.data!.isEmpty) &&
          timerViewModel.getAllApps().isEmpty) {
        scheduleWidgets.add(
          Column(
            children: [
              SizedBox(height: 70),
              Center(
                child: Text(
                  "You don't have a schedule",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textColor_2,
                  ),
                ),
              ),
              SizedBox(height: 70),
            ],
          ),
        );
      } else {
        scheduleWidgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ...List.generate(value.scheduleList.data?.length ?? 0, (index) {
                  final schedule =
                      value.scheduleList.data!.reversed.toList()[index];
                  String startTime = schedule.startTime!;
                  String endTime = schedule.endTime!;
                  startTime = startTime.contains('.')
                      ? startTime.split('.')[0]
                      : startTime;
                  endTime =
                      endTime.contains('.') ? endTime.split('.')[0] : endTime;
                  DateTime parsedStartTime =
                      DateFormat("yyyy-MM-dd HH:mm:ss").parse(startTime);
                  DateTime parsedEndTime =
                      DateFormat("yyyy-MM-dd HH:mm:ss").parse(endTime);
                  final timerDuration = schedule.timer!.toInt();
                  final usageDuration =
                      parsedEndTime.difference(parsedStartTime).inMinutes;
                  return _scheduleTile(
                    schedule.appName ?? "No App Name",
                    "Usage Time: ${DateFormat('HH:mm:ss').format(parsedStartTime)} - ${DateFormat('HH:mm:ss').format(parsedEndTime)}\nTimer: ${schedule.timer} minute(s)",
                    usageDuration > timerDuration ? "failed" : "success",
                  );
                }),
              ],
            ),
          ),
        );
      }
    default:
      scheduleWidgets.add(Container());
  }
  return Column(
    children: scheduleWidgets,
  );
}

Widget _scheduleTile(
    String appName, String usageDuration, String scheduleStatus) {
  Icon scheduleIcon = scheduleStatus == "trying"
      ? Icon(Icons.warning, color: Colors.orange)
      : scheduleStatus == "success"
          ? Icon(Icons.check_circle, color: Colors.green)
          : scheduleStatus == "failed"
              ? Icon(Icons.cancel, color: Colors.red)
              : Icon(Icons.help, color: Colors.grey);

  return Card(
    elevation: 14,
    shadowColor: Colors.black.withOpacity(0.4),
    color: AppColors.textColor_0,
    child: ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 18),
      title: Text(
        appName,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.secondaryColor,
        ),
      ),
      subtitle: Text(
        usageDuration,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryColor,
        ),
      ),
      trailing: scheduleIcon,
    ),
  );
}

Widget _arrangeScheduleButton(
    BuildContext context,
    TimerViewModel timerViewModel,
    Future<void> Function(String?) saveSelectedApps,
    HomeViewModel value) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Container(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(Icons.calendar_today, color: Colors.white),
        label: Text(
          "Arrange your schedule",
          style: TextStyle(
              color: AppColors.textColor_0,
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryColor,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        onPressed: () {
          _showBottomModal(context, timerViewModel, saveSelectedApps, value);
        },
      ),
    ),
  );
}

void _showBottomModal(
  BuildContext context,
  TimerViewModel timerViewModel,
  Future<void> Function(String?) saveSelectedApps,
  HomeViewModel value,
) {
  String? selectedApp;
  int timerDuration = 5;
  TextEditingController ctrlTimerDuration =
      TextEditingController(text: timerDuration.toString());

  if (timerViewModel.getAllApps().isNotEmpty) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: AppColors.backgroundColor,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(22.0),
          child: Center(
            child: Text(
              "You already have a schedule running now!",
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  } else {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: AppColors.backgroundColor,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Social Media App",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor_1,
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButton<String>(
                      dropdownColor: AppColors.backgroundColor,
                      isExpanded: true,
                      value: selectedApp,
                      hint: const Text(
                        "Select an App",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: AppColors.textColor_1,
                        ),
                      ),
                      items: value.appList.data != null
                          ? value.appList.data!.map((app) {
                              return DropdownMenuItem<String>(
                                value: app.appName,
                                child: Text(
                                  app.appName![0].toUpperCase() +
                                      app.appName!.substring(1),
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: AppColors.textColor_1,
                                  ),
                                ),
                              );
                            }).toList()
                          : [],
                      onChanged: (String? newValue) {
                        setModalState(() {
                          selectedApp = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Duration (minutes)",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor_1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            setModalState(() {
                              if (timerDuration > 1) {
                                timerDuration--;
                                ctrlTimerDuration.text =
                                    timerDuration.toString();
                              }
                            });
                          },
                        ),
                        SizedBox(
                          width: 50,
                          child: TextField(
                            controller: ctrlTimerDuration,
                            onChanged: (value) {
                              setModalState(() {
                                timerDuration =
                                    int.tryParse(value) ?? timerDuration;
                              });
                            },
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: AppColors.textColor_1,
                            ),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            setModalState(() {
                              timerDuration++;
                              ctrlTimerDuration.text = timerDuration.toString();
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondaryColor,
                        ),
                        onPressed: () async {
                          await saveSelectedApps(selectedApp);
                          timerViewModel.setTimerDuration(timerDuration);
                          timerDuration = 5;
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Set Timer",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textColor_0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20)
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
