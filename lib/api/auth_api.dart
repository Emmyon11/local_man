import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_man/core/providers.dart';

final authAPIProvider = Provider((ref) {
  final account = ref.watch(accountProvider);
  return AuthPI(account: account);
});

final userSessionProvider = FutureProvider((ref) async {
  return ref.watch(authAPIProvider).getCurrentSession();
});

class AuthPI {
  final Account _account;

  AuthPI({required Account account}) : _account = account;

  Future<User> login({required String authprovider}) async {
    try {
      await _account.createOAuth2Session(provider: authprovider);
      final User user = await _account.get();
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      final user = await _account.get();
      return user;
    } catch (e) {
      return null;
    }
  }

  Future<Session?> getCurrentSession() async {
    try {
      final user = await _account.getSession(sessionId: 'current');
      return user;
    } catch (e) {
      return null;
    }
  }
}
