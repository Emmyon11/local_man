import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_man/constants/appwrite_constants.dart';
import 'package:local_man/core/providers.dart';
import 'package:local_man/models/professions.dart';

final professionAPIProvider = Provider((ref) {
  final databases = ref.watch(databaseProvider);
  final realtime = ref.watch(appwriteRealtimeProvider);
  return ProfessionAPI(databases: databases, realtime: realtime);
});

class ProfessionAPI {
  final Databases _databases;
  final Realtime _realtime;

  ProfessionAPI({required Databases databases, required Realtime realtime})
      : _databases = databases,
        _realtime = realtime;

  Future<Document> saveProfession(
      {required ProfessionModel profession,
      required String professionName}) async {
    try {
      final response = await _databases.createDocument(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.professionsCollectionId,
          documentId: '04102323$professionName',
          data: profession.toMap());
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Document> joinProfession(
      {required String id,
      required String professionName,
      required List<String> members}) async {
    try {
      members.add(id);
      final response = await _databases.updateDocument(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.professionsCollectionId,
          documentId: '04102323$professionName',
          data: {'members': members});
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<ProfessionModel> getProfession(
      {required String professionName}) async {
    final response = await _databases.getDocument(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.professionsCollectionId,
      documentId: '04102323$professionName',
    );
    final profession = ProfessionModel.fromMap(response.data);
    return profession;
  }

  Future<ProfessionModel> getProfessionById(
      {required String professionId}) async {
    final response = await _databases.getDocument(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.professionsCollectionId,
      documentId: professionId,
    );
    final profession = ProfessionModel.fromMap(response.data);
    return profession;
  }

  Stream<RealtimeMessage> getStreamofProfession() {
    return _realtime.subscribe([
      'databases.${AppwriteConstants.databaseId}.collections.${AppwriteConstants.professionsCollectionId}.documents'
    ]).stream;
  }
}
