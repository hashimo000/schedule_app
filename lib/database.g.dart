// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $EventsTable extends Events with TableInfo<$EventsTable, Event> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _classNameMeta =
      const VerificationMeta('className');
  @override
  late final GeneratedColumn<String> className = GeneratedColumn<String>(
      'class_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _absenceCountMeta =
      const VerificationMeta('absenceCount');
  @override
  late final GeneratedColumn<int> absenceCount = GeneratedColumn<int>(
      'absence_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _rowMeta = const VerificationMeta('row');
  @override
  late final GeneratedColumn<int> row = GeneratedColumn<int>(
      'row', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _columnMeta = const VerificationMeta('column');
  @override
  late final GeneratedColumn<int> column = GeneratedColumn<int>(
      'column', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, className, absenceCount, row, column];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'events';
  @override
  VerificationContext validateIntegrity(Insertable<Event> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('class_name')) {
      context.handle(_classNameMeta,
          className.isAcceptableOrUnknown(data['class_name']!, _classNameMeta));
    } else if (isInserting) {
      context.missing(_classNameMeta);
    }
    if (data.containsKey('absence_count')) {
      context.handle(
          _absenceCountMeta,
          absenceCount.isAcceptableOrUnknown(
              data['absence_count']!, _absenceCountMeta));
    }
    if (data.containsKey('row')) {
      context.handle(
          _rowMeta, row.isAcceptableOrUnknown(data['row']!, _rowMeta));
    } else if (isInserting) {
      context.missing(_rowMeta);
    }
    if (data.containsKey('column')) {
      context.handle(_columnMeta,
          column.isAcceptableOrUnknown(data['column']!, _columnMeta));
    } else if (isInserting) {
      context.missing(_columnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Event map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Event(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      className: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}class_name'])!,
      absenceCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}absence_count'])!,
      row: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}row'])!,
      column: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}column'])!,
    );
  }

  @override
  $EventsTable createAlias(String alias) {
    return $EventsTable(attachedDatabase, alias);
  }
}

class Event extends DataClass implements Insertable<Event> {
  final int id;
  final String className;
  final int absenceCount;
  final int row;
  final int column;
  const Event(
      {required this.id,
      required this.className,
      required this.absenceCount,
      required this.row,
      required this.column});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['class_name'] = Variable<String>(className);
    map['absence_count'] = Variable<int>(absenceCount);
    map['row'] = Variable<int>(row);
    map['column'] = Variable<int>(column);
    return map;
  }

  EventsCompanion toCompanion(bool nullToAbsent) {
    return EventsCompanion(
      id: Value(id),
      className: Value(className),
      absenceCount: Value(absenceCount),
      row: Value(row),
      column: Value(column),
    );
  }

  factory Event.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Event(
      id: serializer.fromJson<int>(json['id']),
      className: serializer.fromJson<String>(json['className']),
      absenceCount: serializer.fromJson<int>(json['absenceCount']),
      row: serializer.fromJson<int>(json['row']),
      column: serializer.fromJson<int>(json['column']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'className': serializer.toJson<String>(className),
      'absenceCount': serializer.toJson<int>(absenceCount),
      'row': serializer.toJson<int>(row),
      'column': serializer.toJson<int>(column),
    };
  }

  Event copyWith(
          {int? id,
          String? className,
          int? absenceCount,
          int? row,
          int? column}) =>
      Event(
        id: id ?? this.id,
        className: className ?? this.className,
        absenceCount: absenceCount ?? this.absenceCount,
        row: row ?? this.row,
        column: column ?? this.column,
      );
  @override
  String toString() {
    return (StringBuffer('Event(')
          ..write('id: $id, ')
          ..write('className: $className, ')
          ..write('absenceCount: $absenceCount, ')
          ..write('row: $row, ')
          ..write('column: $column')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, className, absenceCount, row, column);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Event &&
          other.id == this.id &&
          other.className == this.className &&
          other.absenceCount == this.absenceCount &&
          other.row == this.row &&
          other.column == this.column);
}

class EventsCompanion extends UpdateCompanion<Event> {
  final Value<int> id;
  final Value<String> className;
  final Value<int> absenceCount;
  final Value<int> row;
  final Value<int> column;
  const EventsCompanion({
    this.id = const Value.absent(),
    this.className = const Value.absent(),
    this.absenceCount = const Value.absent(),
    this.row = const Value.absent(),
    this.column = const Value.absent(),
  });
  EventsCompanion.insert({
    this.id = const Value.absent(),
    required String className,
    this.absenceCount = const Value.absent(),
    required int row,
    required int column,
  })  : className = Value(className),
        row = Value(row),
        column = Value(column);
  static Insertable<Event> custom({
    Expression<int>? id,
    Expression<String>? className,
    Expression<int>? absenceCount,
    Expression<int>? row,
    Expression<int>? column,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (className != null) 'class_name': className,
      if (absenceCount != null) 'absence_count': absenceCount,
      if (row != null) 'row': row,
      if (column != null) 'column': column,
    });
  }

  EventsCompanion copyWith(
      {Value<int>? id,
      Value<String>? className,
      Value<int>? absenceCount,
      Value<int>? row,
      Value<int>? column}) {
    return EventsCompanion(
      id: id ?? this.id,
      className: className ?? this.className,
      absenceCount: absenceCount ?? this.absenceCount,
      row: row ?? this.row,
      column: column ?? this.column,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (className.present) {
      map['class_name'] = Variable<String>(className.value);
    }
    if (absenceCount.present) {
      map['absence_count'] = Variable<int>(absenceCount.value);
    }
    if (row.present) {
      map['row'] = Variable<int>(row.value);
    }
    if (column.present) {
      map['column'] = Variable<int>(column.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventsCompanion(')
          ..write('id: $id, ')
          ..write('className: $className, ')
          ..write('absenceCount: $absenceCount, ')
          ..write('row: $row, ')
          ..write('column: $column')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $EventsTable events = $EventsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [events];
}
