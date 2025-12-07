// ==================== lib/services/storage_service.dart ====================
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  
  // Upload single file
  Future<String> uploadFile({
    required File file,
    required String folder,
    required String fileName,
    Function(double)? onProgress,
  }) async {
    try {
      final ref = _storage.ref().child('$folder/$fileName');
      final uploadTask = ref.putFile(file);
      
      // Listen to upload progress
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        final progress = snapshot.bytesTransferred / snapshot.totalBytes;
        if (onProgress != null) {
          onProgress(progress);
        }
      });
      
      // Wait for upload to complete
      await uploadTask;
      
      // Get download URL
      final downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Upload error: $e');
      rethrow;
    }
  }
  
  // Upload multiple files
  Future<List<String>> uploadMultipleFiles({
    required List<File> files,
    required String folder,
    Function(double)? onProgress,
  }) async {
    try {
      List<String> downloadUrls = [];
      int totalFiles = files.length;
      int completedFiles = 0;
      
      for (var file in files) {
        final fileName = '${DateTime.now().millisecondsSinceEpoch}_${path.basename(file.path)}';
        
        final url = await uploadFile(
          file: file,
          folder: folder,
          fileName: fileName,
          onProgress: (progress) {
            final overallProgress = (completedFiles + progress) / totalFiles;
            if (onProgress != null) {
              onProgress(overallProgress);
            }
          },
        );
        
        downloadUrls.add(url);
        completedFiles++;
      }
      
      return downloadUrls;
    } catch (e) {
      print('Multiple upload error: $e');
      rethrow;
    }
  }
  
  // Upload resource files
  Future<Map<String, dynamic>> uploadResourceFiles({
    required List<File> files,
    required String resourceId,
    required String uploaderId,
    Function(double)? onProgress,
  }) async {
    try {
      final folder = 'resources/$uploaderId/$resourceId';
      List<String> fileUrls = [];
      List<String> fileNames = [];
      List<int> fileSizes = [];
      
      int totalFiles = files.length;
      int completedFiles = 0;
      
      for (var file in files) {
        final fileName = path.basename(file.path);
        final fileSize = await file.length();
        
        // Check file size (max 50MB)
        if (fileSize > 50 * 1024 * 1024) {
          throw Exception('File $fileName exceeds 50MB limit');
        }
        
        final url = await uploadFile(
          file: file,
          folder: folder,
          fileName: fileName,
          onProgress: (progress) {
            final overallProgress = (completedFiles + progress) / totalFiles;
            if (onProgress != null) {
              onProgress(overallProgress);
            }
          },
        );
        
        fileUrls.add(url);
        fileNames.add(fileName);
        fileSizes.add(fileSize);
        completedFiles++;
      }
      
      return {
        'fileUrls': fileUrls,
        'fileNames': fileNames,
        'fileSizes': fileSizes,
      };
    } catch (e) {
      print('Resource upload error: $e');
      rethrow;
    }
  }
  
  // Upload profile picture
  Future<String> uploadProfilePicture({
    required File file,
    required String userId,
  }) async {
    try {
      final fileName = 'profile_$userId.jpg';
      return await uploadFile(
        file: file,
        folder: 'profiles',
        fileName: fileName,
      );
    } catch (e) {
      print('Profile upload error: $e');
      rethrow;
    }
  }
  
  // Delete file
  Future<void> deleteFile(String fileUrl) async {
    try {
      final ref = _storage.refFromURL(fileUrl);
      await ref.delete();
    } catch (e) {
      print('Delete error: $e');
      rethrow;
    }
  }
  
  // Delete multiple files
  Future<void> deleteMultipleFiles(List<String> fileUrls) async {
    try {
      await Future.wait(
        fileUrls.map((url) => deleteFile(url)),
      );
    } catch (e) {
      print('Multiple delete error: $e');
      rethrow;
    }
  }
  
  // Delete resource folder
  Future<void> deleteResourceFolder({
    required String resourceId,
    required String uploaderId,
  }) async {
    try {
      final folder = 'resources/$uploaderId/$resourceId';
      final ref = _storage.ref().child(folder);
      final listResult = await ref.listAll();
      
      // Delete all files in folder
      await Future.wait(
        listResult.items.map((item) => item.delete()),
      );
    } catch (e) {
      print('Folder delete error: $e');
      rethrow;
    }
  }
  
  // Get file metadata
  Future<FullMetadata> getFileMetadata(String fileUrl) async {
    try {
      final ref = _storage.refFromURL(fileUrl);
      return await ref.getMetadata();
    } catch (e) {
      print('Get metadata error: $e');
      rethrow;
    }
  }
  
  // Get download URL
  Future<String> getDownloadUrl(String filePath) async {
    try {
      final ref = _storage.ref().child(filePath);
      return await ref.getDownloadURL();
    } catch (e) {
      print('Get URL error: $e');
      rethrow;
    }
  }
}
