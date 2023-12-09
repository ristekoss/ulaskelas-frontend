// Created by Muhamad Fauzi Ridwan on 07/11/21.
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:ristek_material_component/ristek_material_component.dart';
import 'package:ulaskelas/core/bases/states/_states.dart';
import 'package:ulaskelas/core/constants/_constants.dart';
import 'package:ulaskelas/core/error/_error.dart';
import 'package:ulaskelas/features/matkul/detail/data/datasources/_datasources.dart';
import 'package:ulaskelas/features/matkul/detail/data/repositories/_repositories.dart';
import 'package:ulaskelas/features/matkul/detail/domain/repositories/_repositories.dart';
import 'package:ulaskelas/features/matkul/form/data/datasources/_datasources.dart';
import 'package:ulaskelas/features/matkul/form/data/models/_models.dart';
import 'package:ulaskelas/features/matkul/form/data/repositories/_repositories.dart';
import 'package:ulaskelas/features/matkul/form/domain/entities/query_review.dart';
import 'package:ulaskelas/features/matkul/form/domain/entities/query_search_tag.dart';
import 'package:ulaskelas/features/matkul/form/domain/repositories/_repositories.dart';
import 'package:ulaskelas/features/matkul/search/domain/entities/_entities.dart';

import '../../../../../services/_services.dart';
import '../../../search/data/models/_models.dart';

part 'review_course_form_state.dart';
part 'search_tag_state.dart';
part 'review_course_state.dart';
