// ignore_for_file: file_names, non_constant_identifier_names, unused_field, prefer_const_constructors, invalid_language_version_override
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final _storage = FlutterSecureStorage();


  static Future setName(String name)async {
    await _storage.write(key:'Name', value: name);


  }

  static Future getName()async {
    return await _storage.read(key: 'Name');
  }
}
 