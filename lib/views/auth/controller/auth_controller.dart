import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_man/api/auth_api.dart';
import 'package:http/http.dart' as http;
import 'package:local_man/api/user_api.dart';
import 'package:local_man/constants/appwrite_constants.dart';
import 'package:local_man/core/providers.dart';
import 'package:local_man/models/user_model.dart';

//provider for the whole oauth instance
final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(ref: ref);
});

//future provider for the current logged in user
final currUserProvider = FutureProvider((ref) {
  final authcontroller = ref.watch(authControllerProvider.notifier);
  return authcontroller.getCurrentUser();
});

final currUserDocProvider = FutureProvider((ref) {
  final authcontroller = ref.watch(authControllerProvider.notifier);
  return authcontroller.getCurrentUserDoc();
});
final saveCurrUserProvider = FutureProvider((ref) {
  final authcontroller = ref.watch(authControllerProvider.notifier);
  return authcontroller.saveUser();
});
final loginProvider = FutureProvider.family((ref, String authprovider) {
  final authcontroller = ref.watch(authControllerProvider.notifier);
  return authcontroller.login(authprovider: authprovider);
});

abstract class IAuth {
  Future login({required String authprovider});
  Future getCurrentUser();
}

class AuthController extends StateNotifier<bool> implements IAuth {
  final Ref _ref;

  AuthController({required Ref ref})
      : _ref = ref,
        super(false);

//logged in user via oauth
  @override
  Future login({required String authprovider}) async {
    try {
      User user =
          await _ref.watch(authAPIProvider).login(authprovider: authprovider);
      return user;
    } on PlatformException catch (e) {
      state = false;
      throw e.message ?? 'Something went wrong';
    } on AppwriteException catch (e) {
      throw e.message ?? 'Something went wrong';
    } catch (e) {
      throw 'Something went wrong';
    }
  }

//save the current user detail from the database
  Future<UserModel?> saveUser() async {
    try {
      User? user = await getCurrentUser();
      String profilePic = await getUserImageUrl();

      if (user != null) {
        UserModel userModel = UserModel(
            fullName: user.name,
            personalAdress: '',
            age: 15,
            uid: user.$id,
            profession: [],
            companyName: '',
            companyAddress: '',
            discription: '',
            email: user.email,
            phoneNo: '',
            customers: [],
            reviews: [],
            profilePic: profilePic,
            showcaseImg: []);

        await _ref.watch(databaseProvider).createDocument(
            databaseId: AppwriteConstants.databaseId,
            collectionId: AppwriteConstants.userCollectionId,
            documentId: userModel.uid,
            data: userModel.toMap());
        UserModel? userdoc = await getCurrentUserDoc();
        return userdoc;
      }
      return null;
    } on PlatformException catch (e) {
      state = false;
      throw e.message ?? 'Something went wrong';
    } on AppwriteException catch (e) {
      throw e.message ?? 'Something went wrong';
    } catch (e) {
      throw 'Something went wrong';
    }
  }

//get the current user logged in detail from appwrite database
  @override
  Future<User?> getCurrentUser() async {
    try {
      User? user = await _ref.watch(authAPIProvider).getCurrentUser();
      return user;
    } on PlatformException catch (e) {
      throw e.message ?? 'Something went wrong';
    } on AppwriteException catch (e) {
      throw e.message ?? 'Something went wrong';
    } catch (e) {
      throw 'Something went wrong';
    }
  }

//get the current user document from appwrite database
  Future<UserModel?> getCurrentUserDoc() async {
    try {
      UserModel? user = await _ref.watch(userAPIProvider).getCurrUserDocument();
      return user;
    } on PlatformException catch (e) {
      throw e.message ?? 'Something went wrong';
    } on AppwriteException catch (e) {
      throw e.message ?? 'Something went wrong';
    } catch (e) {
      throw 'Something went wrong';
    }
  }

  Future getUserImageUrl() async {
    final user = _ref.watch(userSessionProvider).value;
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    try {
      if (user != null) {
        final token = user.providerAccessToken;
        final url = Uri.parse('https://www.googleapis.com/oauth2/v1/userinfo');

        // Await the http get response, then decode the json-formatted response.
        final response = await http.get(url, headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
        final imageUrl = jsonDecode(response.body)['picture'];
        return imageUrl;
      }
    } catch (e) {
      rethrow;
    }
  }
}
