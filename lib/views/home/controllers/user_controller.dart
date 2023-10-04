import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_man/api/user_api.dart';
import 'package:local_man/models/user_model.dart';

final userControllerProvider =
    StateNotifierProvider<UserController, bool>((ref) {
  return UserController(ref: ref);
});

class UserController extends StateNotifier<bool> {
  final Ref _ref;
  UserController({required Ref ref})
      : _ref = ref,
        super(false);

  Future<Document?> upDateUser({required UserModel user}) async {
    try {
      state = true;
      final updatedUser = await _ref
          .watch(userAPIProvider)
          .updateUserCredential(userId: user.uid, data: user.toMap());
      state = false;
      return updatedUser;
    } on PlatformException catch (e) {
      throw e.message ?? 'Something went wrong';
    } on AppwriteException catch (e) {
      throw e.message ?? 'Something went wrong';
    } catch (e) {
      throw 'Something went wrong';
    }
  }
}

// String userId,
//       String? fullName,
//       String? personalAdress,
//       int? age,
//       List<String?>? profession,
//       String? companyName,
//       String? companyAddress,
//       String? discription,
//       String? email,
//       String? phoneNo,
//       List<String?>? customers,
//       List<String?>? reviews,
//       String? profilePic,
//       List<String?>? showcaseImg
