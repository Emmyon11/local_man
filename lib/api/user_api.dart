import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_man/constants/appwrite_constants.dart';
import 'package:local_man/core/providers.dart';
import 'package:local_man/models/user_model.dart';
import 'package:local_man/views/auth/controller/auth_controller.dart';

final userAPIProvider = Provider((ref) {
  final databases = ref.watch(databaseProvider);
  return UserAPI(databases: databases, ref: ref);
});

abstract class IUser {
  Future<UserModel?> getCurrUserDocument();
  Future<UserModel?> getUserDocument({required String userId});
  Future<Document?> updateUserCredential(
      {required String userId, required Map<String, dynamic> data});
  Future<Document?> updateUserSingleField(
      {required String userId, required String name, required String value});
}

class UserAPI implements IUser {
  final Databases _databases;
  final Ref _ref;

  UserAPI({required Databases databases, required Ref ref})
      : _databases = databases,
        _ref = ref;

  @override
  Future<UserModel?> getCurrUserDocument() async {
    UserModel userData;
    User? user = _ref.watch(currUserProvider).value;
    try {
      if (user != null) {
        Document userDoc = await _databases.getDocument(
            databaseId: AppwriteConstants.databaseId,
            collectionId: AppwriteConstants.userCollectionId,
            documentId: user.$id);
        userData = UserModel.fromMap(userDoc.data);
        return userData;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Document?> updateUserCredential(
      {required String userId, required Map<String, dynamic> data}) async {
    try {
      final Document updatedUser = await _databases.updateDocument(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.userCollectionId,
          documentId: userId,
          data: data);
      return updatedUser;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Document> updateUserSingleField(
      {required String userId,
      required String name,
      required String value}) async {
    try {
      final Document updatedUser = await _databases.updateDocument(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.userCollectionId,
          documentId: userId,
          data: {
            name: [value]
          });
      return updatedUser;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel?> getUserDocument({required String userId}) async {
    Document userDoc = await _databases.getDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.userCollectionId,
        documentId: userId);
    final userData = UserModel.fromMap(userDoc.data);
    return userData;
  }
}
