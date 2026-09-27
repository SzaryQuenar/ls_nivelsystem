import 'package:drift/drift.dart';

class Budowy extends Table {

  TextColumn get id => text()();

  TextColumn get numerBudowy => text()();

  TextColumn get nazwa => text()();

  TextColumn get miejscowosc =>
      text().nullable()();

  TextColumn get inwestor =>
      text().nullable()();

  TextColumn get opis =>
      text().nullable()();

  DateTimeColumn get createdAt =>
      dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}