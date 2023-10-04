import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_man/constants/appwrite_constants.dart';
import 'package:local_man/core/providers.dart';
import 'package:local_man/models/professions.dart';

final professionAPIProvider = Provider((ref) {
  final databases = ref.watch(databaseProvider);
  return ProfessionAPI(databases: databases);
});

class ProfessionAPI {
  final Databases _databases;

  ProfessionAPI({required Databases databases}) : _databases = databases;

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
}
