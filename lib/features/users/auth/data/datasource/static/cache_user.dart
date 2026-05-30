import 'package:get/get.dart';
import 'package:dartz/dartz.dart';
import '../../../../../../core/constants/caching_keys_constants.dart';
import '../../../../../../core/services/app_service.dart';
import '../../models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheUser {
  Future<Either<String, bool>> call(UserModel user) async {
    final SharedPreferences sharedPrefs =
        Get.find<AppServices>().appSharedPrefs;

    bool result = true;

    result =
        result &&
        await sharedPrefs.setString(
          CachingKeysConstants.kUserEmail,
          user.email,
        );
    result =
        result &&
        await sharedPrefs.setString(
          CachingKeysConstants.kUserFullName,
          user.fullName,
        );
    result =
        result &&
        await sharedPrefs.setString(CachingKeysConstants.kUserId, user.id);

    result =
        result &&
        await sharedPrefs.setString(
          CachingKeysConstants.kUserPassword,
          user.password,
        );

    if (user.accessToken.isNotEmpty) {
      result =
          result &&
          await sharedPrefs.setString(
            CachingKeysConstants.kUserToken,
            user.accessToken,
          );
    }

    if (user.tokenType.isNotEmpty) {
      result =
          result &&
          await sharedPrefs.setString(
            CachingKeysConstants.kUserTokenType,
            user.tokenType,
          );
    }

    result =
        result &&
        await sharedPrefs.setString(CachingKeysConstants.kUserRole, user.role);

    if (user.address.isNotEmpty) {
      result =
          result &&
          await sharedPrefs.setString(
            CachingKeysConstants.kUserAddress,
            user.address,
          );
    }
    if (user.phone.isNotEmpty) {
      result =
          result &&
          await sharedPrefs.setString(
            CachingKeysConstants.kUserPhone,
            user.phone,
          );
    }

    if (user.avatarUrl.isNotEmpty) {
      // Build the full local server path from the filename
      final filename = user.avatarUrl.split('/').last;
      final fullAvatarUrl =
          'http://10.0.2.2/VetVision-API/VetVision-API/storage/app/public/avatars/$filename';
      result =
          result &&
          await sharedPrefs.setString(
            CachingKeysConstants.kUserAvatarUrl,
            fullAvatarUrl,
          );
    }

    if (result) {
      return const Right(true);
    } else {
      return const Left("user not saved!");
    }
  }
}
