import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fomate_frontend/repository/repository.dart';
import 'package:fomate_frontend/data/response/api_response.dart';
import 'package:fomate_frontend/model/model.dart';
import 'dart:async';
import 'package:app_usage/app_usage.dart';
import 'package:fomate_frontend/model/app_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fomate_frontend/main.dart';
import 'package:fomate_frontend/utils/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'content_viewmodel.dart';
part 'auth_viewmodel.dart';
part 'timer_viewmodel.dart';