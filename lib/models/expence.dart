import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final uuid = const Uuid().v4();
//date formatter
final formattedDate = DateFormat.yMd();

enum Category { food, travel, leasure, work }

final CategoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.leasure: Icons.leave_bags_at_home,
  Category.travel: Icons.travel_explore,
  Category.work: Icons.work,
};

class ExpenceModel {
  ExpenceModel(
      {required this.amount,
      required this.date,
      required this.title,
      required this.category})
      : id = uuid;

  final String id;
  final String title;
  final int amount;
  final DateTime date;
  final Category category;
}

