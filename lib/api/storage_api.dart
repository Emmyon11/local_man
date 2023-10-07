import 'dart:io' as dart_io;

import 'package:appwrite/models.dart';

import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_man/constants/appwrite_constants.dart';
import 'package:local_man/core/providers.dart';

final storageAPIProvider = Provider((ref) {
  final storage = ref.watch(storageProvider);
  return StorageAPI(storage: storage);
});

class StorageAPI {
  final Storage _storage;

  StorageAPI({required Storage storage}) : _storage = storage;

  Future<File> saveImageStorage(
      {required dart_io.File file, required String fileId}) async {
    final imageList =
        await _storage.listFiles(bucketId: AppwriteConstants.imageBucketId);
    if (imageList.files.toList().any((element) => element.$id == fileId)) {
      await _storage.deleteFile(
          bucketId: AppwriteConstants.imageBucketId, fileId: fileId);
      final imageFile = await _storage.createFile(
          bucketId: AppwriteConstants.imageBucketId,
          fileId: fileId,
          file: InputFile.fromPath(path: file.path));

      return imageFile;
    }

    final imageFile = await _storage.createFile(
        bucketId: AppwriteConstants.imageBucketId,
        fileId: fileId,
        file: InputFile.fromPath(path: file.path));

    return imageFile;
  }
}
