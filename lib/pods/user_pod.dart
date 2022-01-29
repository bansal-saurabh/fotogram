import 'package:flutter/widgets.dart';
import 'package:fotogram/helpers/authorization.dart';
import 'package:fotogram/models/user.dart';

class UserPod with ChangeNotifier {
  User? _user;
  final Authorization _authorization = Authorization();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authorization.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
