// Created by Muhamad Fauzi Ridwan on 07/11/21.

import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:ulaskelas/core/client/_client.dart';
import 'package:ulaskelas/core/constants/filename_const.dart';
import 'package:ulaskelas/core/environment/_environment.dart';
import 'package:ulaskelas/core/extension/_extension.dart';
import 'package:ulaskelas/features/matkul/bookmarks/data/models/_models.dart';
import 'package:ulaskelas/features/matkul/main/domain/entities/query_search_course.dart';
import 'package:ulaskelas/features/matkul/search/data/models/_models.dart';
import 'package:ulaskelas/services/_services.dart';

part 'course_local_data_source.dart';
part 'course_remote_data_source.dart';
