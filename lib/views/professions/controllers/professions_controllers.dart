import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_man/api/profession_api.dart';
import 'package:local_man/models/professions.dart';

final professionControllerProvider =
    StateNotifierProvider<ProfessionController, bool>((ref) {
  return ProfessionController(ref: ref);
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
      await _ref.watch(professionAPIProvider).saveProfession(
          profession: profession, professionName: professionName);
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
}
