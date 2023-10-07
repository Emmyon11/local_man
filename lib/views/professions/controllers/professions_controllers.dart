import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_man/api/profession_api.dart';
import 'package:local_man/api/user_api.dart';
import 'package:local_man/models/professions.dart';
import 'package:local_man/views/auth/controller/auth_controller.dart';

final professionControllerProvider =
    StateNotifierProvider<ProfessionController, bool>((ref) {
  return ProfessionController(ref: ref);
});

final professionStreamProvider = StreamProvider((ref) {
  return ref.watch(professionAPIProvider).getStreamofProfession();
});
final getUserProfessionByIdProvider =
    FutureProvider.family((ref, String professionId) async {
  return ref
      .watch(professionControllerProvider.notifier)
      .getProfessionbyId(professionId: professionId);
});

class ProfessionController extends StateNotifier<bool> {
  final Ref _ref;
  ProfessionController({required Ref ref})
      : _ref = ref,
        super(false);

  Future<ProfessionModel> createProfession(
      {required String professionName}) async {
    final ProfessionModel profession = ProfessionModel(
        name: professionName,
        members: [],
        createdAt: '',
        updatedAt: '',
        uid: '',
        descriptiion: '',
        picture: '');

    try {
      //save profession data to the database via the profession API
      await _ref.watch(professionAPIProvider).saveProfession(
          profession: profession, professionName: professionName);

      //get profession data from the database via the profession API
      final professionData = await _ref
          .watch(professionAPIProvider)
          .getProfession(professionName: professionName);

      return professionData;
    } on AppwriteException catch (e) {
      throw e.message ?? 'Something went wrong while creating a profession';
    } catch (e) {
      rethrow;
    }
  }

  Future<Document?> joinProfession(
      {required String professionName, required List<String> members}) async {
    try {
      final user = _ref.watch(currUserProvider).value;
      if (user != null) {
        final professionData = await _ref
            .watch(professionAPIProvider)
            .joinProfession(
                id: user.$id, professionName: professionName, members: members);
        await _ref.watch(userAPIProvider).updateUserSingleField(
            userId: user.$id, name: 'profession', value: professionData.$id);
        return professionData;
      }
      return null;
    } on AppwriteException catch (e) {
      throw e.message ?? 'Something went wrong while creating a profession';
    } catch (e) {
      rethrow;
    }
  }

  Future<ProfessionModel?> getProfession(
      {required String professionName}) async {
    try {
      final profession = await _ref
          .watch(professionAPIProvider)
          .getProfession(professionName: professionName);
      return profession;
    } on AppwriteException catch (e) {
      if (e.message!
          .contains('Document with the requested ID could not be found')) {
        return null;
      }
      throw e.message ?? 'Something went wrong while creating a profession';
    } catch (e) {
      if (e
          .toString()
          .contains('Document with the requested ID could not be found')) {
        return null;
      }
      throw 'Something went wrong while creating a profession';
    }
  }

  Future<ProfessionModel?> getProfessionbyId(
      {required String professionId}) async {
    try {
      final profession = await _ref
          .watch(professionAPIProvider)
          .getProfessionById(professionId: professionId);

      return profession;
    } on AppwriteException catch (e) {
      if (e.message!
          .contains('Document with the requested ID could not be found')) {
        return null;
      }
      throw e.message ?? 'Something went wrong while creating a profession';
    } catch (e) {
      if (e
          .toString()
          .contains('Document with the requested ID could not be found')) {
        return null;
      }
      throw 'Something went wrong while creating a profession';
    }
  }
}
