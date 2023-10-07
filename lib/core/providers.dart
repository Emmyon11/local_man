import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_man/constants/appwrite_constants.dart';

final clientProvider = Provider((ref) {
  return Client()
      .setEndpoint(AppwriteConstants.endpoint)
      .setProject(AppwriteConstants.projectId);
});

final accountProvider = Provider((ref) {
  return Account(ref.watch(clientProvider));
});

final databaseProvider = Provider((ref) {
  final client = ref.watch(clientProvider);
  return Databases(client);
});
final storageProvider = Provider((ref) {
  final client = ref.watch(clientProvider);
  return Storage(client);
});

final appwriteRealtimeProvider = Provider((ref) {
  final client = ref.watch(clientProvider);
  return Realtime(client);
});
