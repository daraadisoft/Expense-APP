import 'package:flutter/material.dart';

abstract class BaseController extends ChangeNotifier{
  @protected
  @mustCallSuper
  Future<void> init()async {}
}