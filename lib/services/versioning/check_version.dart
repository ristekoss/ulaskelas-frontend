import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:ulaskelas/services/versioning/store_version_service.dart';

@Deprecated('Not a proper version control')
Future<bool> canUpdate(
  BuildContext context,
) async {
  try {
    final data = await PackageInfo.fromPlatform();
    final version = await StoreVersionService.getStoreVersion(context);
    final local = data.version.split('.');
    final store = version?.split('.');
    final localCoreVersion = local[0] + local[1];
    final storeCoreVersion = store![0] + store[1];
    return int.parse(storeCoreVersion) > int.parse(localCoreVersion);
  } catch (e) {
    return false;
  }
}
