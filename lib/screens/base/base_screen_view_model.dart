import 'package:flutter/material.dart';

class BaseScreenViewModel with ChangeNotifier {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  // MARK: - Init
  BaseScreenViewModel();
}
