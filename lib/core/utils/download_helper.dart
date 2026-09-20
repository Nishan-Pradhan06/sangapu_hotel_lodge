import 'dart:io';
import 'dart:typed_data';
import 'package:file_saver/file_saver.dart';
import 'package:path_provider/path_provider.dart';

class DownloadHelper {
  static Future<String?> saveDocument({
    required String fileName,
    required Uint8List bytes,
    required String extension,
  }) async {
    MimeType mimeType;
    if (extension == 'pdf') {
      mimeType = MimeType.pdf;
    } else if (extension == 'xlsx' || extension == 'xls') {
      mimeType = MimeType.microsoftExcel;
    } else {
      mimeType = MimeType.other;
    }

    final fullName = '$fileName.$extension';

    if (Platform.isAndroid) {
      // 1. Primary: Save directly to the public device Download folder
      // so the user can easily find and access files directly from their phone storage.
      try {
        final downloadDir = Directory('/storage/emulated/0/Download');
        if (!await downloadDir.exists()) {
          await downloadDir.create(recursive: true);
        }

        File targetFile = File('${downloadDir.path}/$fullName');
        int counter = 1;
        while (await targetFile.exists()) {
          targetFile =
              File('${downloadDir.path}/${fileName}_$counter.$extension');
          counter++;
        }

        await targetFile.writeAsBytes(bytes);
        return targetFile.path;
      } catch (storageError) {
        // 2. Safe Google Play Policy Compliant Fallback:
        // On devices where Scoped Storage restricts direct POSIX write (Android 11+),
        // invoke Android's official Storage Access Framework (SAF) via saveAs.
        try {
          final savedPath = await FileSaver.instance.saveAs(
            name: fileName,
            bytes: bytes,
            fileExtension: extension,
            mimeType: mimeType,
          );
          if (savedPath != null &&
              savedPath.isNotEmpty &&
              !savedPath.contains('Something went wrong') &&
              !savedPath.startsWith('Error')) {
            return savedPath;
          }
        } catch (_) {}

        // 3. Fallback: Save to app-specific external storage to ensure export never fails
        final fallbackPath = await FileSaver.instance.saveFile(
          name: fileName,
          bytes: bytes,
          fileExtension: extension,
          mimeType: mimeType,
        );

        if (fallbackPath.contains('Something went wrong') ||
            fallbackPath.startsWith('Error')) {
          throw Exception('Unable to save file to storage');
        }
        return fallbackPath;
      }
    } else if (Platform.isIOS) {
      try {
        final dir = await getApplicationDocumentsDirectory();
        File targetFile = File('${dir.path}/$fullName');
        int counter = 1;
        while (await targetFile.exists()) {
          targetFile = File('${dir.path}/${fileName}_$counter.$extension');
          counter++;
        }
        await targetFile.writeAsBytes(bytes);
        return targetFile.path;
      } catch (_) {
        final fallbackPath = await FileSaver.instance.saveFile(
          name: fileName,
          bytes: bytes,
          fileExtension: extension,
          mimeType: mimeType,
        );
        return fallbackPath;
      }
    }

    // Other platforms (Desktop, Web)
    return await FileSaver.instance.saveFile(
      name: fileName,
      bytes: bytes,
      fileExtension: extension,
      mimeType: mimeType,
    );
  }
}
