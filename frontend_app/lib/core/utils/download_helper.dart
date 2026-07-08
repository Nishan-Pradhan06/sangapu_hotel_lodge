import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:file_saver/file_saver.dart';

class DownloadHelper {
  static Future<String> saveDocument({
    required String fileName,
    required Uint8List bytes,
    required String extension,
  }) async {
    final fullName = '$fileName.$extension';

    try {
      if (Platform.isAndroid) {
        // Attempt to save directly to the public Download folder on Android.
        // Android 10+ allows creating files in the Download directory without extra permissions.
        final dir = Directory('/storage/emulated/0/Download');
        if (!await dir.exists()) {
          await dir.create(recursive: true);
        }

        final file = File('${dir.path}/$fullName');
        
        // Handle file name collision by appending a number if it already exists
        File finalFile = file;
        int counter = 1;
        while (await finalFile.exists()) {
          finalFile = File('${dir.path}/${fileName}_$counter.$extension');
          counter++;
        }

        await finalFile.writeAsBytes(bytes);
        return finalFile.path;
      } else if (Platform.isIOS) {
        // On iOS, save to the Application Documents Directory. 
        // Note: For it to be visible in the Files app, UIFileSharingEnabled and 
        // LSSupportsOpeningDocumentsInPlace must be set to true in Info.plist
        final dir = await getApplicationDocumentsDirectory();
        
        final file = File('${dir.path}/$fullName');
        
        File finalFile = file;
        int counter = 1;
        while (await finalFile.exists()) {
          finalFile = File('${dir.path}/${fileName}_$counter.$extension');
          counter++;
        }

        await finalFile.writeAsBytes(bytes);
        return finalFile.path;
      }
    } catch (e) {
      // Fallback if writing directly fails (e.g., due to permissions on older Android versions)
      try {
        final fallbackPath = await FileSaver.instance.saveFile(
          name: fileName,
          bytes: bytes,
          fileExtension: extension,
        );
        return fallbackPath;
      } catch (fallbackError) {
        throw Exception('Failed to save file: $e\nFallback error: $fallbackError');
      }
    }

    // Fallback for other platforms (Web, Desktop, etc)
    try {
        final fallbackPath = await FileSaver.instance.saveFile(
          name: fileName,
          bytes: bytes,
          fileExtension: extension,
        );
        return fallbackPath;
    } catch (e) {
        throw Exception('Failed to save file: $e');
    }
  }
}
