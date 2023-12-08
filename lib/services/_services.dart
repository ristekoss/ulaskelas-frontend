// Created by Muhamad Fauzi Ridwan on 24/08/21.

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ulaskelas/core/_core.dart';
import 'package:ulaskelas/core/environment/secrets.dart';

part 'date_service.dart';
part 'delay_service.dart';
part 'duration_service.dart';
part 'file_service.dart';
part 'hive_db_service.dart';
part 'pref_service.dart';
part 'share_service.dart';
part 'mixpanel_service.dart';
