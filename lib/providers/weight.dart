import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Weight with ChangeNotifier {
  final int id;
  final String name;
  final int unitId;
  final int depends;
  final double multiplier;

  Weight({
    @required this.id,
    @required this.name,
    @required this.unitId,
    @required this.depends,
    @required this.multiplier,
  });
}