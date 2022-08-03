// Created by Muhamad Fauzi Ridwan on 07/11/21.

import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:ulaskelas/core/bases/states/_states.dart';
import 'package:ulaskelas/core/client/_client.dart';
import 'package:ulaskelas/core/constants/filename_const.dart';
import 'package:ulaskelas/core/environment/_environment.dart';
import 'package:ulaskelas/core/extension/_extension.dart';
import 'package:ulaskelas/features/matkul/form/data/models/_models.dart';
import 'package:ulaskelas/features/matkul/form/domain/entities/query_review.dart';
import 'package:ulaskelas/features/matkul/form/domain/entities/query_search_tag.dart';
import 'package:ulaskelas/services/_services.dart';

part 'review_local_data_source.dart';
part 'review_remote_data_source.dart';
part 'tag_local_data_source.dart';
part 'tag_remote_data_source.dart';
