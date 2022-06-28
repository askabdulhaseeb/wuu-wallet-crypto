import 'package:flutter/material.dart';
import '../models/app_user.dart';

class UserProvider extends ChangeNotifier {
  final AppUser _user = AppUser(
    uid: 'null',
    name: 'Test User',
    email: 'test@test.com',
    imageURL: '',
  );
}
