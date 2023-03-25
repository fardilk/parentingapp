// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _passwordMeta =
      const VerificationMeta('password');
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
      'password', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phoneNumberMeta =
      const VerificationMeta('phoneNumber');
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
      'phone_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _firstNameMeta =
      const VerificationMeta('firstName');
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
      'first_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastNameMeta =
      const VerificationMeta('lastName');
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
      'last_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<Uint8List> image = GeneratedColumn<Uint8List>(
      'image', aliasedName, true,
      type: DriftSqlType.blob, requiredDuringInsert: false);
  static const VerificationMeta _birthdayMeta =
      const VerificationMeta('birthday');
  @override
  late final GeneratedColumn<DateTime> birthday = GeneratedColumn<DateTime>(
      'birthday', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _isVerifiedMeta =
      const VerificationMeta('isVerified');
  @override
  late final GeneratedColumn<bool> isVerified =
      GeneratedColumn<bool>('is_verified', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_verified" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }),
          defaultValue: const Constant(false));
  static const VerificationMeta _isPhoneVerifiedMeta =
      const VerificationMeta('isPhoneVerified');
  @override
  late final GeneratedColumn<bool> isPhoneVerified =
      GeneratedColumn<bool>('is_phone_verified', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_phone_verified" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }),
          defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        email,
        password,
        phoneNumber,
        firstName,
        lastName,
        gender,
        image,
        birthday,
        isVerified,
        isPhoneVerified
      ];
  @override
  String get aliasedName => _alias ?? 'users';
  @override
  String get actualTableName => 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('phone_number')) {
      context.handle(
          _phoneNumberMeta,
          phoneNumber.isAcceptableOrUnknown(
              data['phone_number']!, _phoneNumberMeta));
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    }
    if (data.containsKey('birthday')) {
      context.handle(_birthdayMeta,
          birthday.isAcceptableOrUnknown(data['birthday']!, _birthdayMeta));
    }
    if (data.containsKey('is_verified')) {
      context.handle(
          _isVerifiedMeta,
          isVerified.isAcceptableOrUnknown(
              data['is_verified']!, _isVerifiedMeta));
    }
    if (data.containsKey('is_phone_verified')) {
      context.handle(
          _isPhoneVerifiedMeta,
          isPhoneVerified.isAcceptableOrUnknown(
              data['is_phone_verified']!, _isPhoneVerifiedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      password: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password'])!,
      phoneNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone_number']),
      firstName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}first_name']),
      lastName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_name']),
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender']),
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}image']),
      birthday: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}birthday']),
      isVerified: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_verified'])!,
      isPhoneVerified: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}is_phone_verified'])!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String email;
  final String password;
  final String? phoneNumber;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final Uint8List? image;
  final DateTime? birthday;
  final bool isVerified;
  final bool isPhoneVerified;
  const User(
      {required this.id,
      required this.email,
      required this.password,
      this.phoneNumber,
      this.firstName,
      this.lastName,
      this.gender,
      this.image,
      this.birthday,
      required this.isVerified,
      required this.isPhoneVerified});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['email'] = Variable<String>(email);
    map['password'] = Variable<String>(password);
    if (!nullToAbsent || phoneNumber != null) {
      map['phone_number'] = Variable<String>(phoneNumber);
    }
    if (!nullToAbsent || firstName != null) {
      map['first_name'] = Variable<String>(firstName);
    }
    if (!nullToAbsent || lastName != null) {
      map['last_name'] = Variable<String>(lastName);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(gender);
    }
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<Uint8List>(image);
    }
    if (!nullToAbsent || birthday != null) {
      map['birthday'] = Variable<DateTime>(birthday);
    }
    map['is_verified'] = Variable<bool>(isVerified);
    map['is_phone_verified'] = Variable<bool>(isPhoneVerified);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      email: Value(email),
      password: Value(password),
      phoneNumber: phoneNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneNumber),
      firstName: firstName == null && nullToAbsent
          ? const Value.absent()
          : Value(firstName),
      lastName: lastName == null && nullToAbsent
          ? const Value.absent()
          : Value(lastName),
      gender:
          gender == null && nullToAbsent ? const Value.absent() : Value(gender),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
      birthday: birthday == null && nullToAbsent
          ? const Value.absent()
          : Value(birthday),
      isVerified: Value(isVerified),
      isPhoneVerified: Value(isPhoneVerified),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      email: serializer.fromJson<String>(json['email']),
      password: serializer.fromJson<String>(json['password']),
      phoneNumber: serializer.fromJson<String?>(json['phoneNumber']),
      firstName: serializer.fromJson<String?>(json['firstName']),
      lastName: serializer.fromJson<String?>(json['lastName']),
      gender: serializer.fromJson<String?>(json['gender']),
      image: serializer.fromJson<Uint8List?>(json['image']),
      birthday: serializer.fromJson<DateTime?>(json['birthday']),
      isVerified: serializer.fromJson<bool>(json['isVerified']),
      isPhoneVerified: serializer.fromJson<bool>(json['isPhoneVerified']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'email': serializer.toJson<String>(email),
      'password': serializer.toJson<String>(password),
      'phoneNumber': serializer.toJson<String?>(phoneNumber),
      'firstName': serializer.toJson<String?>(firstName),
      'lastName': serializer.toJson<String?>(lastName),
      'gender': serializer.toJson<String?>(gender),
      'image': serializer.toJson<Uint8List?>(image),
      'birthday': serializer.toJson<DateTime?>(birthday),
      'isVerified': serializer.toJson<bool>(isVerified),
      'isPhoneVerified': serializer.toJson<bool>(isPhoneVerified),
    };
  }

  User copyWith(
          {int? id,
          String? email,
          String? password,
          Value<String?> phoneNumber = const Value.absent(),
          Value<String?> firstName = const Value.absent(),
          Value<String?> lastName = const Value.absent(),
          Value<String?> gender = const Value.absent(),
          Value<Uint8List?> image = const Value.absent(),
          Value<DateTime?> birthday = const Value.absent(),
          bool? isVerified,
          bool? isPhoneVerified}) =>
      User(
        id: id ?? this.id,
        email: email ?? this.email,
        password: password ?? this.password,
        phoneNumber: phoneNumber.present ? phoneNumber.value : this.phoneNumber,
        firstName: firstName.present ? firstName.value : this.firstName,
        lastName: lastName.present ? lastName.value : this.lastName,
        gender: gender.present ? gender.value : this.gender,
        image: image.present ? image.value : this.image,
        birthday: birthday.present ? birthday.value : this.birthday,
        isVerified: isVerified ?? this.isVerified,
        isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('password: $password, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('gender: $gender, ')
          ..write('image: $image, ')
          ..write('birthday: $birthday, ')
          ..write('isVerified: $isVerified, ')
          ..write('isPhoneVerified: $isPhoneVerified')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      email,
      password,
      phoneNumber,
      firstName,
      lastName,
      gender,
      $driftBlobEquality.hash(image),
      birthday,
      isVerified,
      isPhoneVerified);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.email == this.email &&
          other.password == this.password &&
          other.phoneNumber == this.phoneNumber &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.gender == this.gender &&
          $driftBlobEquality.equals(other.image, this.image) &&
          other.birthday == this.birthday &&
          other.isVerified == this.isVerified &&
          other.isPhoneVerified == this.isPhoneVerified);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> email;
  final Value<String> password;
  final Value<String?> phoneNumber;
  final Value<String?> firstName;
  final Value<String?> lastName;
  final Value<String?> gender;
  final Value<Uint8List?> image;
  final Value<DateTime?> birthday;
  final Value<bool> isVerified;
  final Value<bool> isPhoneVerified;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.email = const Value.absent(),
    this.password = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.gender = const Value.absent(),
    this.image = const Value.absent(),
    this.birthday = const Value.absent(),
    this.isVerified = const Value.absent(),
    this.isPhoneVerified = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String email,
    required String password,
    this.phoneNumber = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.gender = const Value.absent(),
    this.image = const Value.absent(),
    this.birthday = const Value.absent(),
    this.isVerified = const Value.absent(),
    this.isPhoneVerified = const Value.absent(),
  })  : email = Value(email),
        password = Value(password);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? email,
    Expression<String>? password,
    Expression<String>? phoneNumber,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? gender,
    Expression<Uint8List>? image,
    Expression<DateTime>? birthday,
    Expression<bool>? isVerified,
    Expression<bool>? isPhoneVerified,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (gender != null) 'gender': gender,
      if (image != null) 'image': image,
      if (birthday != null) 'birthday': birthday,
      if (isVerified != null) 'is_verified': isVerified,
      if (isPhoneVerified != null) 'is_phone_verified': isPhoneVerified,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? id,
      Value<String>? email,
      Value<String>? password,
      Value<String?>? phoneNumber,
      Value<String?>? firstName,
      Value<String?>? lastName,
      Value<String?>? gender,
      Value<Uint8List?>? image,
      Value<DateTime?>? birthday,
      Value<bool>? isVerified,
      Value<bool>? isPhoneVerified}) {
    return UsersCompanion(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      image: image ?? this.image,
      birthday: birthday ?? this.birthday,
      isVerified: isVerified ?? this.isVerified,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (image.present) {
      map['image'] = Variable<Uint8List>(image.value);
    }
    if (birthday.present) {
      map['birthday'] = Variable<DateTime>(birthday.value);
    }
    if (isVerified.present) {
      map['is_verified'] = Variable<bool>(isVerified.value);
    }
    if (isPhoneVerified.present) {
      map['is_phone_verified'] = Variable<bool>(isPhoneVerified.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('password: $password, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('gender: $gender, ')
          ..write('image: $image, ')
          ..write('birthday: $birthday, ')
          ..write('isVerified: $isVerified, ')
          ..write('isPhoneVerified: $isPhoneVerified')
          ..write(')'))
        .toString();
  }
}

class $ChildrensTable extends Childrens
    with TableInfo<$ChildrensTable, Children> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChildrensTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userMeta = const VerificationMeta('user');
  @override
  late final GeneratedColumn<int> user = GeneratedColumn<int>(
      'user', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _firstNameMeta =
      const VerificationMeta('firstName');
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
      'first_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastNameMeta =
      const VerificationMeta('lastName');
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
      'last_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _birthdayMeta =
      const VerificationMeta('birthday');
  @override
  late final GeneratedColumn<DateTime> birthday = GeneratedColumn<DateTime>(
      'birthday', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<Uint8List> image = GeneratedColumn<Uint8List>(
      'image', aliasedName, true,
      type: DriftSqlType.blob, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, user, firstName, lastName, gender, birthday, image];
  @override
  String get aliasedName => _alias ?? 'childrens';
  @override
  String get actualTableName => 'childrens';
  @override
  VerificationContext validateIntegrity(Insertable<Children> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user')) {
      context.handle(
          _userMeta, user.isAcceptableOrUnknown(data['user']!, _userMeta));
    } else if (isInserting) {
      context.missing(_userMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    } else if (isInserting) {
      context.missing(_genderMeta);
    }
    if (data.containsKey('birthday')) {
      context.handle(_birthdayMeta,
          birthday.isAcceptableOrUnknown(data['birthday']!, _birthdayMeta));
    } else if (isInserting) {
      context.missing(_birthdayMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Children map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Children(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      user: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user'])!,
      firstName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}first_name'])!,
      lastName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_name'])!,
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender'])!,
      birthday: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}birthday'])!,
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}image']),
    );
  }

  @override
  $ChildrensTable createAlias(String alias) {
    return $ChildrensTable(attachedDatabase, alias);
  }
}

class Children extends DataClass implements Insertable<Children> {
  final int id;
  final int user;
  final String firstName;
  final String lastName;
  final String gender;
  final DateTime birthday;
  final Uint8List? image;
  const Children(
      {required this.id,
      required this.user,
      required this.firstName,
      required this.lastName,
      required this.gender,
      required this.birthday,
      this.image});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user'] = Variable<int>(user);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    map['gender'] = Variable<String>(gender);
    map['birthday'] = Variable<DateTime>(birthday);
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<Uint8List>(image);
    }
    return map;
  }

  ChildrensCompanion toCompanion(bool nullToAbsent) {
    return ChildrensCompanion(
      id: Value(id),
      user: Value(user),
      firstName: Value(firstName),
      lastName: Value(lastName),
      gender: Value(gender),
      birthday: Value(birthday),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
    );
  }

  factory Children.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Children(
      id: serializer.fromJson<int>(json['id']),
      user: serializer.fromJson<int>(json['user']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      gender: serializer.fromJson<String>(json['gender']),
      birthday: serializer.fromJson<DateTime>(json['birthday']),
      image: serializer.fromJson<Uint8List?>(json['image']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'user': serializer.toJson<int>(user),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'gender': serializer.toJson<String>(gender),
      'birthday': serializer.toJson<DateTime>(birthday),
      'image': serializer.toJson<Uint8List?>(image),
    };
  }

  Children copyWith(
          {int? id,
          int? user,
          String? firstName,
          String? lastName,
          String? gender,
          DateTime? birthday,
          Value<Uint8List?> image = const Value.absent()}) =>
      Children(
        id: id ?? this.id,
        user: user ?? this.user,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        gender: gender ?? this.gender,
        birthday: birthday ?? this.birthday,
        image: image.present ? image.value : this.image,
      );
  @override
  String toString() {
    return (StringBuffer('Children(')
          ..write('id: $id, ')
          ..write('user: $user, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('gender: $gender, ')
          ..write('birthday: $birthday, ')
          ..write('image: $image')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, user, firstName, lastName, gender,
      birthday, $driftBlobEquality.hash(image));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Children &&
          other.id == this.id &&
          other.user == this.user &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.gender == this.gender &&
          other.birthday == this.birthday &&
          $driftBlobEquality.equals(other.image, this.image));
}

class ChildrensCompanion extends UpdateCompanion<Children> {
  final Value<int> id;
  final Value<int> user;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String> gender;
  final Value<DateTime> birthday;
  final Value<Uint8List?> image;
  const ChildrensCompanion({
    this.id = const Value.absent(),
    this.user = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.gender = const Value.absent(),
    this.birthday = const Value.absent(),
    this.image = const Value.absent(),
  });
  ChildrensCompanion.insert({
    this.id = const Value.absent(),
    required int user,
    required String firstName,
    required String lastName,
    required String gender,
    required DateTime birthday,
    this.image = const Value.absent(),
  })  : user = Value(user),
        firstName = Value(firstName),
        lastName = Value(lastName),
        gender = Value(gender),
        birthday = Value(birthday);
  static Insertable<Children> custom({
    Expression<int>? id,
    Expression<int>? user,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? gender,
    Expression<DateTime>? birthday,
    Expression<Uint8List>? image,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (user != null) 'user': user,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (gender != null) 'gender': gender,
      if (birthday != null) 'birthday': birthday,
      if (image != null) 'image': image,
    });
  }

  ChildrensCompanion copyWith(
      {Value<int>? id,
      Value<int>? user,
      Value<String>? firstName,
      Value<String>? lastName,
      Value<String>? gender,
      Value<DateTime>? birthday,
      Value<Uint8List?>? image}) {
    return ChildrensCompanion(
      id: id ?? this.id,
      user: user ?? this.user,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      image: image ?? this.image,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (user.present) {
      map['user'] = Variable<int>(user.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (birthday.present) {
      map['birthday'] = Variable<DateTime>(birthday.value);
    }
    if (image.present) {
      map['image'] = Variable<Uint8List>(image.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChildrensCompanion(')
          ..write('id: $id, ')
          ..write('user: $user, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('gender: $gender, ')
          ..write('birthday: $birthday, ')
          ..write('image: $image')
          ..write(')'))
        .toString();
  }
}

class $PreferencesTable extends Preferences
    with TableInfo<$PreferencesTable, Preference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PreferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userMeta = const VerificationMeta('user');
  @override
  late final GeneratedColumn<int> user = GeneratedColumn<int>(
      'user', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _birthClubMeta =
      const VerificationMeta('birthClub');
  @override
  late final GeneratedColumn<bool> birthClub =
      GeneratedColumn<bool>('birth_club', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("birth_club" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }),
          defaultValue: const Constant(false));
  static const VerificationMeta _parentsLifeMeta =
      const VerificationMeta('parentsLife');
  @override
  late final GeneratedColumn<bool> parentsLife =
      GeneratedColumn<bool>('parents_life', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("parents_life" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }),
          defaultValue: const Constant(false));
  static const VerificationMeta _communityMeta =
      const VerificationMeta('community');
  @override
  late final GeneratedColumn<bool> community =
      GeneratedColumn<bool>('community', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("community" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }),
          defaultValue: const Constant(false));
  static const VerificationMeta _pregnancyMeta =
      const VerificationMeta('pregnancy');
  @override
  late final GeneratedColumn<bool> pregnancy =
      GeneratedColumn<bool>('pregnancy', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("pregnancy" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }),
          defaultValue: const Constant(false));
  static const VerificationMeta _fertilityMeta =
      const VerificationMeta('fertility');
  @override
  late final GeneratedColumn<bool> fertility =
      GeneratedColumn<bool>('fertility', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("fertility" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }),
          defaultValue: const Constant(false));
  static const VerificationMeta _babyMeta = const VerificationMeta('baby');
  @override
  late final GeneratedColumn<bool> baby =
      GeneratedColumn<bool>('baby', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("baby" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }),
          defaultValue: const Constant(false));
  static const VerificationMeta _toddlerMeta =
      const VerificationMeta('toddler');
  @override
  late final GeneratedColumn<bool> toddler =
      GeneratedColumn<bool>('toddler', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("toddler" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }),
          defaultValue: const Constant(false));
  static const VerificationMeta _balitaMeta = const VerificationMeta('balita');
  @override
  late final GeneratedColumn<bool> balita =
      GeneratedColumn<bool>('balita', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("balita" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }),
          defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        user,
        birthClub,
        parentsLife,
        community,
        pregnancy,
        fertility,
        baby,
        toddler,
        balita
      ];
  @override
  String get aliasedName => _alias ?? 'preferences';
  @override
  String get actualTableName => 'preferences';
  @override
  VerificationContext validateIntegrity(Insertable<Preference> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user')) {
      context.handle(
          _userMeta, user.isAcceptableOrUnknown(data['user']!, _userMeta));
    } else if (isInserting) {
      context.missing(_userMeta);
    }
    if (data.containsKey('birth_club')) {
      context.handle(_birthClubMeta,
          birthClub.isAcceptableOrUnknown(data['birth_club']!, _birthClubMeta));
    }
    if (data.containsKey('parents_life')) {
      context.handle(
          _parentsLifeMeta,
          parentsLife.isAcceptableOrUnknown(
              data['parents_life']!, _parentsLifeMeta));
    }
    if (data.containsKey('community')) {
      context.handle(_communityMeta,
          community.isAcceptableOrUnknown(data['community']!, _communityMeta));
    }
    if (data.containsKey('pregnancy')) {
      context.handle(_pregnancyMeta,
          pregnancy.isAcceptableOrUnknown(data['pregnancy']!, _pregnancyMeta));
    }
    if (data.containsKey('fertility')) {
      context.handle(_fertilityMeta,
          fertility.isAcceptableOrUnknown(data['fertility']!, _fertilityMeta));
    }
    if (data.containsKey('baby')) {
      context.handle(
          _babyMeta, baby.isAcceptableOrUnknown(data['baby']!, _babyMeta));
    }
    if (data.containsKey('toddler')) {
      context.handle(_toddlerMeta,
          toddler.isAcceptableOrUnknown(data['toddler']!, _toddlerMeta));
    }
    if (data.containsKey('balita')) {
      context.handle(_balitaMeta,
          balita.isAcceptableOrUnknown(data['balita']!, _balitaMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Preference map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Preference(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      user: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user'])!,
      birthClub: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}birth_club'])!,
      parentsLife: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}parents_life'])!,
      community: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}community'])!,
      pregnancy: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}pregnancy'])!,
      fertility: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}fertility'])!,
      baby: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}baby'])!,
      toddler: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}toddler'])!,
      balita: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}balita'])!,
    );
  }

  @override
  $PreferencesTable createAlias(String alias) {
    return $PreferencesTable(attachedDatabase, alias);
  }
}

class Preference extends DataClass implements Insertable<Preference> {
  final int id;
  final int user;
  final bool birthClub;
  final bool parentsLife;
  final bool community;
  final bool pregnancy;
  final bool fertility;
  final bool baby;
  final bool toddler;
  final bool balita;
  const Preference(
      {required this.id,
      required this.user,
      required this.birthClub,
      required this.parentsLife,
      required this.community,
      required this.pregnancy,
      required this.fertility,
      required this.baby,
      required this.toddler,
      required this.balita});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user'] = Variable<int>(user);
    map['birth_club'] = Variable<bool>(birthClub);
    map['parents_life'] = Variable<bool>(parentsLife);
    map['community'] = Variable<bool>(community);
    map['pregnancy'] = Variable<bool>(pregnancy);
    map['fertility'] = Variable<bool>(fertility);
    map['baby'] = Variable<bool>(baby);
    map['toddler'] = Variable<bool>(toddler);
    map['balita'] = Variable<bool>(balita);
    return map;
  }

  PreferencesCompanion toCompanion(bool nullToAbsent) {
    return PreferencesCompanion(
      id: Value(id),
      user: Value(user),
      birthClub: Value(birthClub),
      parentsLife: Value(parentsLife),
      community: Value(community),
      pregnancy: Value(pregnancy),
      fertility: Value(fertility),
      baby: Value(baby),
      toddler: Value(toddler),
      balita: Value(balita),
    );
  }

  factory Preference.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Preference(
      id: serializer.fromJson<int>(json['id']),
      user: serializer.fromJson<int>(json['user']),
      birthClub: serializer.fromJson<bool>(json['birthClub']),
      parentsLife: serializer.fromJson<bool>(json['parentsLife']),
      community: serializer.fromJson<bool>(json['community']),
      pregnancy: serializer.fromJson<bool>(json['pregnancy']),
      fertility: serializer.fromJson<bool>(json['fertility']),
      baby: serializer.fromJson<bool>(json['baby']),
      toddler: serializer.fromJson<bool>(json['toddler']),
      balita: serializer.fromJson<bool>(json['balita']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'user': serializer.toJson<int>(user),
      'birthClub': serializer.toJson<bool>(birthClub),
      'parentsLife': serializer.toJson<bool>(parentsLife),
      'community': serializer.toJson<bool>(community),
      'pregnancy': serializer.toJson<bool>(pregnancy),
      'fertility': serializer.toJson<bool>(fertility),
      'baby': serializer.toJson<bool>(baby),
      'toddler': serializer.toJson<bool>(toddler),
      'balita': serializer.toJson<bool>(balita),
    };
  }

  Preference copyWith(
          {int? id,
          int? user,
          bool? birthClub,
          bool? parentsLife,
          bool? community,
          bool? pregnancy,
          bool? fertility,
          bool? baby,
          bool? toddler,
          bool? balita}) =>
      Preference(
        id: id ?? this.id,
        user: user ?? this.user,
        birthClub: birthClub ?? this.birthClub,
        parentsLife: parentsLife ?? this.parentsLife,
        community: community ?? this.community,
        pregnancy: pregnancy ?? this.pregnancy,
        fertility: fertility ?? this.fertility,
        baby: baby ?? this.baby,
        toddler: toddler ?? this.toddler,
        balita: balita ?? this.balita,
      );
  @override
  String toString() {
    return (StringBuffer('Preference(')
          ..write('id: $id, ')
          ..write('user: $user, ')
          ..write('birthClub: $birthClub, ')
          ..write('parentsLife: $parentsLife, ')
          ..write('community: $community, ')
          ..write('pregnancy: $pregnancy, ')
          ..write('fertility: $fertility, ')
          ..write('baby: $baby, ')
          ..write('toddler: $toddler, ')
          ..write('balita: $balita')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, user, birthClub, parentsLife, community,
      pregnancy, fertility, baby, toddler, balita);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Preference &&
          other.id == this.id &&
          other.user == this.user &&
          other.birthClub == this.birthClub &&
          other.parentsLife == this.parentsLife &&
          other.community == this.community &&
          other.pregnancy == this.pregnancy &&
          other.fertility == this.fertility &&
          other.baby == this.baby &&
          other.toddler == this.toddler &&
          other.balita == this.balita);
}

class PreferencesCompanion extends UpdateCompanion<Preference> {
  final Value<int> id;
  final Value<int> user;
  final Value<bool> birthClub;
  final Value<bool> parentsLife;
  final Value<bool> community;
  final Value<bool> pregnancy;
  final Value<bool> fertility;
  final Value<bool> baby;
  final Value<bool> toddler;
  final Value<bool> balita;
  const PreferencesCompanion({
    this.id = const Value.absent(),
    this.user = const Value.absent(),
    this.birthClub = const Value.absent(),
    this.parentsLife = const Value.absent(),
    this.community = const Value.absent(),
    this.pregnancy = const Value.absent(),
    this.fertility = const Value.absent(),
    this.baby = const Value.absent(),
    this.toddler = const Value.absent(),
    this.balita = const Value.absent(),
  });
  PreferencesCompanion.insert({
    this.id = const Value.absent(),
    required int user,
    this.birthClub = const Value.absent(),
    this.parentsLife = const Value.absent(),
    this.community = const Value.absent(),
    this.pregnancy = const Value.absent(),
    this.fertility = const Value.absent(),
    this.baby = const Value.absent(),
    this.toddler = const Value.absent(),
    this.balita = const Value.absent(),
  }) : user = Value(user);
  static Insertable<Preference> custom({
    Expression<int>? id,
    Expression<int>? user,
    Expression<bool>? birthClub,
    Expression<bool>? parentsLife,
    Expression<bool>? community,
    Expression<bool>? pregnancy,
    Expression<bool>? fertility,
    Expression<bool>? baby,
    Expression<bool>? toddler,
    Expression<bool>? balita,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (user != null) 'user': user,
      if (birthClub != null) 'birth_club': birthClub,
      if (parentsLife != null) 'parents_life': parentsLife,
      if (community != null) 'community': community,
      if (pregnancy != null) 'pregnancy': pregnancy,
      if (fertility != null) 'fertility': fertility,
      if (baby != null) 'baby': baby,
      if (toddler != null) 'toddler': toddler,
      if (balita != null) 'balita': balita,
    });
  }

  PreferencesCompanion copyWith(
      {Value<int>? id,
      Value<int>? user,
      Value<bool>? birthClub,
      Value<bool>? parentsLife,
      Value<bool>? community,
      Value<bool>? pregnancy,
      Value<bool>? fertility,
      Value<bool>? baby,
      Value<bool>? toddler,
      Value<bool>? balita}) {
    return PreferencesCompanion(
      id: id ?? this.id,
      user: user ?? this.user,
      birthClub: birthClub ?? this.birthClub,
      parentsLife: parentsLife ?? this.parentsLife,
      community: community ?? this.community,
      pregnancy: pregnancy ?? this.pregnancy,
      fertility: fertility ?? this.fertility,
      baby: baby ?? this.baby,
      toddler: toddler ?? this.toddler,
      balita: balita ?? this.balita,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (user.present) {
      map['user'] = Variable<int>(user.value);
    }
    if (birthClub.present) {
      map['birth_club'] = Variable<bool>(birthClub.value);
    }
    if (parentsLife.present) {
      map['parents_life'] = Variable<bool>(parentsLife.value);
    }
    if (community.present) {
      map['community'] = Variable<bool>(community.value);
    }
    if (pregnancy.present) {
      map['pregnancy'] = Variable<bool>(pregnancy.value);
    }
    if (fertility.present) {
      map['fertility'] = Variable<bool>(fertility.value);
    }
    if (baby.present) {
      map['baby'] = Variable<bool>(baby.value);
    }
    if (toddler.present) {
      map['toddler'] = Variable<bool>(toddler.value);
    }
    if (balita.present) {
      map['balita'] = Variable<bool>(balita.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PreferencesCompanion(')
          ..write('id: $id, ')
          ..write('user: $user, ')
          ..write('birthClub: $birthClub, ')
          ..write('parentsLife: $parentsLife, ')
          ..write('community: $community, ')
          ..write('pregnancy: $pregnancy, ')
          ..write('fertility: $fertility, ')
          ..write('baby: $baby, ')
          ..write('toddler: $toddler, ')
          ..write('balita: $balita')
          ..write(')'))
        .toString();
  }
}

class $GrowthsTable extends Growths with TableInfo<$GrowthsTable, Growth> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GrowthsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userMeta = const VerificationMeta('user');
  @override
  late final GeneratedColumn<int> user = GeneratedColumn<int>(
      'user', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _childrenMeta =
      const VerificationMeta('children');
  @override
  late final GeneratedColumn<int> children = GeneratedColumn<int>(
      'children', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<double> height = GeneratedColumn<double>(
      'height', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _headCircumferenceMeta =
      const VerificationMeta('headCircumference');
  @override
  late final GeneratedColumn<double> headCircumference =
      GeneratedColumn<double>('head_circumference', aliasedName, false,
          type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _measurementDateMeta =
      const VerificationMeta('measurementDate');
  @override
  late final GeneratedColumn<DateTime> measurementDate =
      GeneratedColumn<DateTime>('measurement_date', aliasedName, false,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          defaultValue: Constant(DateTime.now()));
  @override
  List<GeneratedColumn> get $columns =>
      [id, user, children, height, weight, headCircumference, measurementDate];
  @override
  String get aliasedName => _alias ?? 'growths';
  @override
  String get actualTableName => 'growths';
  @override
  VerificationContext validateIntegrity(Insertable<Growth> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user')) {
      context.handle(
          _userMeta, user.isAcceptableOrUnknown(data['user']!, _userMeta));
    } else if (isInserting) {
      context.missing(_userMeta);
    }
    if (data.containsKey('children')) {
      context.handle(_childrenMeta,
          children.isAcceptableOrUnknown(data['children']!, _childrenMeta));
    } else if (isInserting) {
      context.missing(_childrenMeta);
    }
    if (data.containsKey('height')) {
      context.handle(_heightMeta,
          height.isAcceptableOrUnknown(data['height']!, _heightMeta));
    } else if (isInserting) {
      context.missing(_heightMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    if (data.containsKey('head_circumference')) {
      context.handle(
          _headCircumferenceMeta,
          headCircumference.isAcceptableOrUnknown(
              data['head_circumference']!, _headCircumferenceMeta));
    } else if (isInserting) {
      context.missing(_headCircumferenceMeta);
    }
    if (data.containsKey('measurement_date')) {
      context.handle(
          _measurementDateMeta,
          measurementDate.isAcceptableOrUnknown(
              data['measurement_date']!, _measurementDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Growth map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Growth(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      user: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user'])!,
      children: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}children'])!,
      height: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}height'])!,
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight'])!,
      headCircumference: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}head_circumference'])!,
      measurementDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}measurement_date'])!,
    );
  }

  @override
  $GrowthsTable createAlias(String alias) {
    return $GrowthsTable(attachedDatabase, alias);
  }
}

class Growth extends DataClass implements Insertable<Growth> {
  final int id;
  final int user;
  final int children;
  final double height;
  final double weight;
  final double headCircumference;
  final DateTime measurementDate;
  const Growth(
      {required this.id,
      required this.user,
      required this.children,
      required this.height,
      required this.weight,
      required this.headCircumference,
      required this.measurementDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user'] = Variable<int>(user);
    map['children'] = Variable<int>(children);
    map['height'] = Variable<double>(height);
    map['weight'] = Variable<double>(weight);
    map['head_circumference'] = Variable<double>(headCircumference);
    map['measurement_date'] = Variable<DateTime>(measurementDate);
    return map;
  }

  GrowthsCompanion toCompanion(bool nullToAbsent) {
    return GrowthsCompanion(
      id: Value(id),
      user: Value(user),
      children: Value(children),
      height: Value(height),
      weight: Value(weight),
      headCircumference: Value(headCircumference),
      measurementDate: Value(measurementDate),
    );
  }

  factory Growth.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Growth(
      id: serializer.fromJson<int>(json['id']),
      user: serializer.fromJson<int>(json['user']),
      children: serializer.fromJson<int>(json['children']),
      height: serializer.fromJson<double>(json['height']),
      weight: serializer.fromJson<double>(json['weight']),
      headCircumference: serializer.fromJson<double>(json['headCircumference']),
      measurementDate: serializer.fromJson<DateTime>(json['measurementDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'user': serializer.toJson<int>(user),
      'children': serializer.toJson<int>(children),
      'height': serializer.toJson<double>(height),
      'weight': serializer.toJson<double>(weight),
      'headCircumference': serializer.toJson<double>(headCircumference),
      'measurementDate': serializer.toJson<DateTime>(measurementDate),
    };
  }

  Growth copyWith(
          {int? id,
          int? user,
          int? children,
          double? height,
          double? weight,
          double? headCircumference,
          DateTime? measurementDate}) =>
      Growth(
        id: id ?? this.id,
        user: user ?? this.user,
        children: children ?? this.children,
        height: height ?? this.height,
        weight: weight ?? this.weight,
        headCircumference: headCircumference ?? this.headCircumference,
        measurementDate: measurementDate ?? this.measurementDate,
      );
  @override
  String toString() {
    return (StringBuffer('Growth(')
          ..write('id: $id, ')
          ..write('user: $user, ')
          ..write('children: $children, ')
          ..write('height: $height, ')
          ..write('weight: $weight, ')
          ..write('headCircumference: $headCircumference, ')
          ..write('measurementDate: $measurementDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, user, children, height, weight, headCircumference, measurementDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Growth &&
          other.id == this.id &&
          other.user == this.user &&
          other.children == this.children &&
          other.height == this.height &&
          other.weight == this.weight &&
          other.headCircumference == this.headCircumference &&
          other.measurementDate == this.measurementDate);
}

class GrowthsCompanion extends UpdateCompanion<Growth> {
  final Value<int> id;
  final Value<int> user;
  final Value<int> children;
  final Value<double> height;
  final Value<double> weight;
  final Value<double> headCircumference;
  final Value<DateTime> measurementDate;
  const GrowthsCompanion({
    this.id = const Value.absent(),
    this.user = const Value.absent(),
    this.children = const Value.absent(),
    this.height = const Value.absent(),
    this.weight = const Value.absent(),
    this.headCircumference = const Value.absent(),
    this.measurementDate = const Value.absent(),
  });
  GrowthsCompanion.insert({
    this.id = const Value.absent(),
    required int user,
    required int children,
    required double height,
    required double weight,
    required double headCircumference,
    this.measurementDate = const Value.absent(),
  })  : user = Value(user),
        children = Value(children),
        height = Value(height),
        weight = Value(weight),
        headCircumference = Value(headCircumference);
  static Insertable<Growth> custom({
    Expression<int>? id,
    Expression<int>? user,
    Expression<int>? children,
    Expression<double>? height,
    Expression<double>? weight,
    Expression<double>? headCircumference,
    Expression<DateTime>? measurementDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (user != null) 'user': user,
      if (children != null) 'children': children,
      if (height != null) 'height': height,
      if (weight != null) 'weight': weight,
      if (headCircumference != null) 'head_circumference': headCircumference,
      if (measurementDate != null) 'measurement_date': measurementDate,
    });
  }

  GrowthsCompanion copyWith(
      {Value<int>? id,
      Value<int>? user,
      Value<int>? children,
      Value<double>? height,
      Value<double>? weight,
      Value<double>? headCircumference,
      Value<DateTime>? measurementDate}) {
    return GrowthsCompanion(
      id: id ?? this.id,
      user: user ?? this.user,
      children: children ?? this.children,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      headCircumference: headCircumference ?? this.headCircumference,
      measurementDate: measurementDate ?? this.measurementDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (user.present) {
      map['user'] = Variable<int>(user.value);
    }
    if (children.present) {
      map['children'] = Variable<int>(children.value);
    }
    if (height.present) {
      map['height'] = Variable<double>(height.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (headCircumference.present) {
      map['head_circumference'] = Variable<double>(headCircumference.value);
    }
    if (measurementDate.present) {
      map['measurement_date'] = Variable<DateTime>(measurementDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GrowthsCompanion(')
          ..write('id: $id, ')
          ..write('user: $user, ')
          ..write('children: $children, ')
          ..write('height: $height, ')
          ..write('weight: $weight, ')
          ..write('headCircumference: $headCircumference, ')
          ..write('measurementDate: $measurementDate')
          ..write(')'))
        .toString();
  }
}

class $NotificationsTable extends Notifications
    with TableInfo<$NotificationsTable, NotificationModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userMeta = const VerificationMeta('user');
  @override
  late final GeneratedColumn<int> user = GeneratedColumn<int>(
      'user', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isUnreadMeta =
      const VerificationMeta('isUnread');
  @override
  late final GeneratedColumn<bool> isUnread =
      GeneratedColumn<bool>('is_unread', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_unread" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
      'time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, user, title, type, isUnread, time];
  @override
  String get aliasedName => _alias ?? 'notifications';
  @override
  String get actualTableName => 'notifications';
  @override
  VerificationContext validateIntegrity(Insertable<NotificationModel> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user')) {
      context.handle(
          _userMeta, user.isAcceptableOrUnknown(data['user']!, _userMeta));
    } else if (isInserting) {
      context.missing(_userMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('is_unread')) {
      context.handle(_isUnreadMeta,
          isUnread.isAcceptableOrUnknown(data['is_unread']!, _isUnreadMeta));
    } else if (isInserting) {
      context.missing(_isUnreadMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotificationModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationModel(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      user: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      isUnread: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_unread'])!,
      time: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time'])!,
    );
  }

  @override
  $NotificationsTable createAlias(String alias) {
    return $NotificationsTable(attachedDatabase, alias);
  }
}

class NotificationModel extends DataClass
    implements Insertable<NotificationModel> {
  final int id;
  final int user;
  final String title;
  final String type;
  final bool isUnread;
  final DateTime time;
  const NotificationModel(
      {required this.id,
      required this.user,
      required this.title,
      required this.type,
      required this.isUnread,
      required this.time});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user'] = Variable<int>(user);
    map['title'] = Variable<String>(title);
    map['type'] = Variable<String>(type);
    map['is_unread'] = Variable<bool>(isUnread);
    map['time'] = Variable<DateTime>(time);
    return map;
  }

  NotificationsCompanion toCompanion(bool nullToAbsent) {
    return NotificationsCompanion(
      id: Value(id),
      user: Value(user),
      title: Value(title),
      type: Value(type),
      isUnread: Value(isUnread),
      time: Value(time),
    );
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationModel(
      id: serializer.fromJson<int>(json['id']),
      user: serializer.fromJson<int>(json['user']),
      title: serializer.fromJson<String>(json['title']),
      type: serializer.fromJson<String>(json['type']),
      isUnread: serializer.fromJson<bool>(json['isUnread']),
      time: serializer.fromJson<DateTime>(json['time']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'user': serializer.toJson<int>(user),
      'title': serializer.toJson<String>(title),
      'type': serializer.toJson<String>(type),
      'isUnread': serializer.toJson<bool>(isUnread),
      'time': serializer.toJson<DateTime>(time),
    };
  }

  NotificationModel copyWith(
          {int? id,
          int? user,
          String? title,
          String? type,
          bool? isUnread,
          DateTime? time}) =>
      NotificationModel(
        id: id ?? this.id,
        user: user ?? this.user,
        title: title ?? this.title,
        type: type ?? this.type,
        isUnread: isUnread ?? this.isUnread,
        time: time ?? this.time,
      );
  @override
  String toString() {
    return (StringBuffer('NotificationModel(')
          ..write('id: $id, ')
          ..write('user: $user, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('isUnread: $isUnread, ')
          ..write('time: $time')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, user, title, type, isUnread, time);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationModel &&
          other.id == this.id &&
          other.user == this.user &&
          other.title == this.title &&
          other.type == this.type &&
          other.isUnread == this.isUnread &&
          other.time == this.time);
}

class NotificationsCompanion extends UpdateCompanion<NotificationModel> {
  final Value<int> id;
  final Value<int> user;
  final Value<String> title;
  final Value<String> type;
  final Value<bool> isUnread;
  final Value<DateTime> time;
  const NotificationsCompanion({
    this.id = const Value.absent(),
    this.user = const Value.absent(),
    this.title = const Value.absent(),
    this.type = const Value.absent(),
    this.isUnread = const Value.absent(),
    this.time = const Value.absent(),
  });
  NotificationsCompanion.insert({
    this.id = const Value.absent(),
    required int user,
    required String title,
    required String type,
    required bool isUnread,
    required DateTime time,
  })  : user = Value(user),
        title = Value(title),
        type = Value(type),
        isUnread = Value(isUnread),
        time = Value(time);
  static Insertable<NotificationModel> custom({
    Expression<int>? id,
    Expression<int>? user,
    Expression<String>? title,
    Expression<String>? type,
    Expression<bool>? isUnread,
    Expression<DateTime>? time,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (user != null) 'user': user,
      if (title != null) 'title': title,
      if (type != null) 'type': type,
      if (isUnread != null) 'is_unread': isUnread,
      if (time != null) 'time': time,
    });
  }

  NotificationsCompanion copyWith(
      {Value<int>? id,
      Value<int>? user,
      Value<String>? title,
      Value<String>? type,
      Value<bool>? isUnread,
      Value<DateTime>? time}) {
    return NotificationsCompanion(
      id: id ?? this.id,
      user: user ?? this.user,
      title: title ?? this.title,
      type: type ?? this.type,
      isUnread: isUnread ?? this.isUnread,
      time: time ?? this.time,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (user.present) {
      map['user'] = Variable<int>(user.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (isUnread.present) {
      map['is_unread'] = Variable<bool>(isUnread.value);
    }
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationsCompanion(')
          ..write('id: $id, ')
          ..write('user: $user, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('isUnread: $isUnread, ')
          ..write('time: $time')
          ..write(')'))
        .toString();
  }
}

class $VaccinationsTable extends Vaccinations
    with TableInfo<$VaccinationsTable, Vaccination> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VaccinationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _childrenMeta =
      const VerificationMeta('children');
  @override
  late final GeneratedColumn<int> children = GeneratedColumn<int>(
      'children', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _vaccineMeta =
      const VerificationMeta('vaccine');
  @override
  late final GeneratedColumn<int> vaccine = GeneratedColumn<int>(
      'vaccine', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _vaccineNameMeta =
      const VerificationMeta('vaccineName');
  @override
  late final GeneratedColumn<String> vaccineName = GeneratedColumn<String>(
      'vaccine_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _vaccinationMonthMeta =
      const VerificationMeta('vaccinationMonth');
  @override
  late final GeneratedColumn<int> vaccinationMonth = GeneratedColumn<int>(
      'vaccination_month', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _vaccineBrandMeta =
      const VerificationMeta('vaccineBrand');
  @override
  late final GeneratedColumn<String> vaccineBrand = GeneratedColumn<String>(
      'vaccine_brand', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _locationNameMeta =
      const VerificationMeta('locationName');
  @override
  late final GeneratedColumn<String> locationName = GeneratedColumn<String>(
      'location_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _doctorNameMeta =
      const VerificationMeta('doctorName');
  @override
  late final GeneratedColumn<String> doctorName = GeneratedColumn<String>(
      'doctor_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _batchNumberMeta =
      const VerificationMeta('batchNumber');
  @override
  late final GeneratedColumn<String> batchNumber = GeneratedColumn<String>(
      'batch_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _vaccinationDateMeta =
      const VerificationMeta('vaccinationDate');
  @override
  late final GeneratedColumn<DateTime> vaccinationDate =
      GeneratedColumn<DateTime>('vaccination_date', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _vaccinationScheduleMeta =
      const VerificationMeta('vaccinationSchedule');
  @override
  late final GeneratedColumn<DateTime> vaccinationSchedule =
      GeneratedColumn<DateTime>('vaccination_schedule', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        children,
        vaccine,
        vaccineName,
        vaccinationMonth,
        vaccineBrand,
        locationName,
        doctorName,
        batchNumber,
        notes,
        vaccinationDate,
        vaccinationSchedule
      ];
  @override
  String get aliasedName => _alias ?? 'vaccinations';
  @override
  String get actualTableName => 'vaccinations';
  @override
  VerificationContext validateIntegrity(Insertable<Vaccination> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('children')) {
      context.handle(_childrenMeta,
          children.isAcceptableOrUnknown(data['children']!, _childrenMeta));
    } else if (isInserting) {
      context.missing(_childrenMeta);
    }
    if (data.containsKey('vaccine')) {
      context.handle(_vaccineMeta,
          vaccine.isAcceptableOrUnknown(data['vaccine']!, _vaccineMeta));
    }
    if (data.containsKey('vaccine_name')) {
      context.handle(
          _vaccineNameMeta,
          vaccineName.isAcceptableOrUnknown(
              data['vaccine_name']!, _vaccineNameMeta));
    } else if (isInserting) {
      context.missing(_vaccineNameMeta);
    }
    if (data.containsKey('vaccination_month')) {
      context.handle(
          _vaccinationMonthMeta,
          vaccinationMonth.isAcceptableOrUnknown(
              data['vaccination_month']!, _vaccinationMonthMeta));
    }
    if (data.containsKey('vaccine_brand')) {
      context.handle(
          _vaccineBrandMeta,
          vaccineBrand.isAcceptableOrUnknown(
              data['vaccine_brand']!, _vaccineBrandMeta));
    }
    if (data.containsKey('location_name')) {
      context.handle(
          _locationNameMeta,
          locationName.isAcceptableOrUnknown(
              data['location_name']!, _locationNameMeta));
    }
    if (data.containsKey('doctor_name')) {
      context.handle(
          _doctorNameMeta,
          doctorName.isAcceptableOrUnknown(
              data['doctor_name']!, _doctorNameMeta));
    }
    if (data.containsKey('batch_number')) {
      context.handle(
          _batchNumberMeta,
          batchNumber.isAcceptableOrUnknown(
              data['batch_number']!, _batchNumberMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('vaccination_date')) {
      context.handle(
          _vaccinationDateMeta,
          vaccinationDate.isAcceptableOrUnknown(
              data['vaccination_date']!, _vaccinationDateMeta));
    }
    if (data.containsKey('vaccination_schedule')) {
      context.handle(
          _vaccinationScheduleMeta,
          vaccinationSchedule.isAcceptableOrUnknown(
              data['vaccination_schedule']!, _vaccinationScheduleMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Vaccination map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Vaccination(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      children: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}children'])!,
      vaccine: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}vaccine']),
      vaccineName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}vaccine_name'])!,
      vaccinationMonth: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}vaccination_month']),
      vaccineBrand: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}vaccine_brand']),
      locationName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location_name']),
      doctorName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}doctor_name']),
      batchNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}batch_number']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      vaccinationDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}vaccination_date']),
      vaccinationSchedule: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}vaccination_schedule']),
    );
  }

  @override
  $VaccinationsTable createAlias(String alias) {
    return $VaccinationsTable(attachedDatabase, alias);
  }
}

class Vaccination extends DataClass implements Insertable<Vaccination> {
  final int id;
  final int children;
  final int? vaccine;
  final String vaccineName;
  final int? vaccinationMonth;
  final String? vaccineBrand;
  final String? locationName;
  final String? doctorName;
  final String? batchNumber;
  final String? notes;
  final DateTime? vaccinationDate;
  final DateTime? vaccinationSchedule;
  const Vaccination(
      {required this.id,
      required this.children,
      this.vaccine,
      required this.vaccineName,
      this.vaccinationMonth,
      this.vaccineBrand,
      this.locationName,
      this.doctorName,
      this.batchNumber,
      this.notes,
      this.vaccinationDate,
      this.vaccinationSchedule});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['children'] = Variable<int>(children);
    if (!nullToAbsent || vaccine != null) {
      map['vaccine'] = Variable<int>(vaccine);
    }
    map['vaccine_name'] = Variable<String>(vaccineName);
    if (!nullToAbsent || vaccinationMonth != null) {
      map['vaccination_month'] = Variable<int>(vaccinationMonth);
    }
    if (!nullToAbsent || vaccineBrand != null) {
      map['vaccine_brand'] = Variable<String>(vaccineBrand);
    }
    if (!nullToAbsent || locationName != null) {
      map['location_name'] = Variable<String>(locationName);
    }
    if (!nullToAbsent || doctorName != null) {
      map['doctor_name'] = Variable<String>(doctorName);
    }
    if (!nullToAbsent || batchNumber != null) {
      map['batch_number'] = Variable<String>(batchNumber);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || vaccinationDate != null) {
      map['vaccination_date'] = Variable<DateTime>(vaccinationDate);
    }
    if (!nullToAbsent || vaccinationSchedule != null) {
      map['vaccination_schedule'] = Variable<DateTime>(vaccinationSchedule);
    }
    return map;
  }

  VaccinationsCompanion toCompanion(bool nullToAbsent) {
    return VaccinationsCompanion(
      id: Value(id),
      children: Value(children),
      vaccine: vaccine == null && nullToAbsent
          ? const Value.absent()
          : Value(vaccine),
      vaccineName: Value(vaccineName),
      vaccinationMonth: vaccinationMonth == null && nullToAbsent
          ? const Value.absent()
          : Value(vaccinationMonth),
      vaccineBrand: vaccineBrand == null && nullToAbsent
          ? const Value.absent()
          : Value(vaccineBrand),
      locationName: locationName == null && nullToAbsent
          ? const Value.absent()
          : Value(locationName),
      doctorName: doctorName == null && nullToAbsent
          ? const Value.absent()
          : Value(doctorName),
      batchNumber: batchNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(batchNumber),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      vaccinationDate: vaccinationDate == null && nullToAbsent
          ? const Value.absent()
          : Value(vaccinationDate),
      vaccinationSchedule: vaccinationSchedule == null && nullToAbsent
          ? const Value.absent()
          : Value(vaccinationSchedule),
    );
  }

  factory Vaccination.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Vaccination(
      id: serializer.fromJson<int>(json['id']),
      children: serializer.fromJson<int>(json['children']),
      vaccine: serializer.fromJson<int?>(json['vaccine']),
      vaccineName: serializer.fromJson<String>(json['vaccineName']),
      vaccinationMonth: serializer.fromJson<int?>(json['vaccinationMonth']),
      vaccineBrand: serializer.fromJson<String?>(json['vaccineBrand']),
      locationName: serializer.fromJson<String?>(json['locationName']),
      doctorName: serializer.fromJson<String?>(json['doctorName']),
      batchNumber: serializer.fromJson<String?>(json['batchNumber']),
      notes: serializer.fromJson<String?>(json['notes']),
      vaccinationDate: serializer.fromJson<DateTime?>(json['vaccinationDate']),
      vaccinationSchedule:
          serializer.fromJson<DateTime?>(json['vaccinationSchedule']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'children': serializer.toJson<int>(children),
      'vaccine': serializer.toJson<int?>(vaccine),
      'vaccineName': serializer.toJson<String>(vaccineName),
      'vaccinationMonth': serializer.toJson<int?>(vaccinationMonth),
      'vaccineBrand': serializer.toJson<String?>(vaccineBrand),
      'locationName': serializer.toJson<String?>(locationName),
      'doctorName': serializer.toJson<String?>(doctorName),
      'batchNumber': serializer.toJson<String?>(batchNumber),
      'notes': serializer.toJson<String?>(notes),
      'vaccinationDate': serializer.toJson<DateTime?>(vaccinationDate),
      'vaccinationSchedule': serializer.toJson<DateTime?>(vaccinationSchedule),
    };
  }

  Vaccination copyWith(
          {int? id,
          int? children,
          Value<int?> vaccine = const Value.absent(),
          String? vaccineName,
          Value<int?> vaccinationMonth = const Value.absent(),
          Value<String?> vaccineBrand = const Value.absent(),
          Value<String?> locationName = const Value.absent(),
          Value<String?> doctorName = const Value.absent(),
          Value<String?> batchNumber = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          Value<DateTime?> vaccinationDate = const Value.absent(),
          Value<DateTime?> vaccinationSchedule = const Value.absent()}) =>
      Vaccination(
        id: id ?? this.id,
        children: children ?? this.children,
        vaccine: vaccine.present ? vaccine.value : this.vaccine,
        vaccineName: vaccineName ?? this.vaccineName,
        vaccinationMonth: vaccinationMonth.present
            ? vaccinationMonth.value
            : this.vaccinationMonth,
        vaccineBrand:
            vaccineBrand.present ? vaccineBrand.value : this.vaccineBrand,
        locationName:
            locationName.present ? locationName.value : this.locationName,
        doctorName: doctorName.present ? doctorName.value : this.doctorName,
        batchNumber: batchNumber.present ? batchNumber.value : this.batchNumber,
        notes: notes.present ? notes.value : this.notes,
        vaccinationDate: vaccinationDate.present
            ? vaccinationDate.value
            : this.vaccinationDate,
        vaccinationSchedule: vaccinationSchedule.present
            ? vaccinationSchedule.value
            : this.vaccinationSchedule,
      );
  @override
  String toString() {
    return (StringBuffer('Vaccination(')
          ..write('id: $id, ')
          ..write('children: $children, ')
          ..write('vaccine: $vaccine, ')
          ..write('vaccineName: $vaccineName, ')
          ..write('vaccinationMonth: $vaccinationMonth, ')
          ..write('vaccineBrand: $vaccineBrand, ')
          ..write('locationName: $locationName, ')
          ..write('doctorName: $doctorName, ')
          ..write('batchNumber: $batchNumber, ')
          ..write('notes: $notes, ')
          ..write('vaccinationDate: $vaccinationDate, ')
          ..write('vaccinationSchedule: $vaccinationSchedule')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      children,
      vaccine,
      vaccineName,
      vaccinationMonth,
      vaccineBrand,
      locationName,
      doctorName,
      batchNumber,
      notes,
      vaccinationDate,
      vaccinationSchedule);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Vaccination &&
          other.id == this.id &&
          other.children == this.children &&
          other.vaccine == this.vaccine &&
          other.vaccineName == this.vaccineName &&
          other.vaccinationMonth == this.vaccinationMonth &&
          other.vaccineBrand == this.vaccineBrand &&
          other.locationName == this.locationName &&
          other.doctorName == this.doctorName &&
          other.batchNumber == this.batchNumber &&
          other.notes == this.notes &&
          other.vaccinationDate == this.vaccinationDate &&
          other.vaccinationSchedule == this.vaccinationSchedule);
}

class VaccinationsCompanion extends UpdateCompanion<Vaccination> {
  final Value<int> id;
  final Value<int> children;
  final Value<int?> vaccine;
  final Value<String> vaccineName;
  final Value<int?> vaccinationMonth;
  final Value<String?> vaccineBrand;
  final Value<String?> locationName;
  final Value<String?> doctorName;
  final Value<String?> batchNumber;
  final Value<String?> notes;
  final Value<DateTime?> vaccinationDate;
  final Value<DateTime?> vaccinationSchedule;
  const VaccinationsCompanion({
    this.id = const Value.absent(),
    this.children = const Value.absent(),
    this.vaccine = const Value.absent(),
    this.vaccineName = const Value.absent(),
    this.vaccinationMonth = const Value.absent(),
    this.vaccineBrand = const Value.absent(),
    this.locationName = const Value.absent(),
    this.doctorName = const Value.absent(),
    this.batchNumber = const Value.absent(),
    this.notes = const Value.absent(),
    this.vaccinationDate = const Value.absent(),
    this.vaccinationSchedule = const Value.absent(),
  });
  VaccinationsCompanion.insert({
    this.id = const Value.absent(),
    required int children,
    this.vaccine = const Value.absent(),
    required String vaccineName,
    this.vaccinationMonth = const Value.absent(),
    this.vaccineBrand = const Value.absent(),
    this.locationName = const Value.absent(),
    this.doctorName = const Value.absent(),
    this.batchNumber = const Value.absent(),
    this.notes = const Value.absent(),
    this.vaccinationDate = const Value.absent(),
    this.vaccinationSchedule = const Value.absent(),
  })  : children = Value(children),
        vaccineName = Value(vaccineName);
  static Insertable<Vaccination> custom({
    Expression<int>? id,
    Expression<int>? children,
    Expression<int>? vaccine,
    Expression<String>? vaccineName,
    Expression<int>? vaccinationMonth,
    Expression<String>? vaccineBrand,
    Expression<String>? locationName,
    Expression<String>? doctorName,
    Expression<String>? batchNumber,
    Expression<String>? notes,
    Expression<DateTime>? vaccinationDate,
    Expression<DateTime>? vaccinationSchedule,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (children != null) 'children': children,
      if (vaccine != null) 'vaccine': vaccine,
      if (vaccineName != null) 'vaccine_name': vaccineName,
      if (vaccinationMonth != null) 'vaccination_month': vaccinationMonth,
      if (vaccineBrand != null) 'vaccine_brand': vaccineBrand,
      if (locationName != null) 'location_name': locationName,
      if (doctorName != null) 'doctor_name': doctorName,
      if (batchNumber != null) 'batch_number': batchNumber,
      if (notes != null) 'notes': notes,
      if (vaccinationDate != null) 'vaccination_date': vaccinationDate,
      if (vaccinationSchedule != null)
        'vaccination_schedule': vaccinationSchedule,
    });
  }

  VaccinationsCompanion copyWith(
      {Value<int>? id,
      Value<int>? children,
      Value<int?>? vaccine,
      Value<String>? vaccineName,
      Value<int?>? vaccinationMonth,
      Value<String?>? vaccineBrand,
      Value<String?>? locationName,
      Value<String?>? doctorName,
      Value<String?>? batchNumber,
      Value<String?>? notes,
      Value<DateTime?>? vaccinationDate,
      Value<DateTime?>? vaccinationSchedule}) {
    return VaccinationsCompanion(
      id: id ?? this.id,
      children: children ?? this.children,
      vaccine: vaccine ?? this.vaccine,
      vaccineName: vaccineName ?? this.vaccineName,
      vaccinationMonth: vaccinationMonth ?? this.vaccinationMonth,
      vaccineBrand: vaccineBrand ?? this.vaccineBrand,
      locationName: locationName ?? this.locationName,
      doctorName: doctorName ?? this.doctorName,
      batchNumber: batchNumber ?? this.batchNumber,
      notes: notes ?? this.notes,
      vaccinationDate: vaccinationDate ?? this.vaccinationDate,
      vaccinationSchedule: vaccinationSchedule ?? this.vaccinationSchedule,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (children.present) {
      map['children'] = Variable<int>(children.value);
    }
    if (vaccine.present) {
      map['vaccine'] = Variable<int>(vaccine.value);
    }
    if (vaccineName.present) {
      map['vaccine_name'] = Variable<String>(vaccineName.value);
    }
    if (vaccinationMonth.present) {
      map['vaccination_month'] = Variable<int>(vaccinationMonth.value);
    }
    if (vaccineBrand.present) {
      map['vaccine_brand'] = Variable<String>(vaccineBrand.value);
    }
    if (locationName.present) {
      map['location_name'] = Variable<String>(locationName.value);
    }
    if (doctorName.present) {
      map['doctor_name'] = Variable<String>(doctorName.value);
    }
    if (batchNumber.present) {
      map['batch_number'] = Variable<String>(batchNumber.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (vaccinationDate.present) {
      map['vaccination_date'] = Variable<DateTime>(vaccinationDate.value);
    }
    if (vaccinationSchedule.present) {
      map['vaccination_schedule'] =
          Variable<DateTime>(vaccinationSchedule.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VaccinationsCompanion(')
          ..write('id: $id, ')
          ..write('children: $children, ')
          ..write('vaccine: $vaccine, ')
          ..write('vaccineName: $vaccineName, ')
          ..write('vaccinationMonth: $vaccinationMonth, ')
          ..write('vaccineBrand: $vaccineBrand, ')
          ..write('locationName: $locationName, ')
          ..write('doctorName: $doctorName, ')
          ..write('batchNumber: $batchNumber, ')
          ..write('notes: $notes, ')
          ..write('vaccinationDate: $vaccinationDate, ')
          ..write('vaccinationSchedule: $vaccinationSchedule')
          ..write(')'))
        .toString();
  }
}

class $VaccinesTable extends Vaccines with TableInfo<$VaccinesTable, Vaccine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VaccinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _vaccineNameMeta =
      const VerificationMeta('vaccineName');
  @override
  late final GeneratedColumn<String> vaccineName = GeneratedColumn<String>(
      'vaccine_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _vaccineBrandsMeta =
      const VerificationMeta('vaccineBrands');
  @override
  late final GeneratedColumn<String> vaccineBrands = GeneratedColumn<String>(
      'vaccine_brands', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _benefitsMeta =
      const VerificationMeta('benefits');
  @override
  late final GeneratedColumn<String> benefits = GeneratedColumn<String>(
      'benefits', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _indicationMeta =
      const VerificationMeta('indication');
  @override
  late final GeneratedColumn<String> indication = GeneratedColumn<String>(
      'indication', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _contraIndicationMeta =
      const VerificationMeta('contraIndication');
  @override
  late final GeneratedColumn<String> contraIndication = GeneratedColumn<String>(
      'contra_indication', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sideEffectsMeta =
      const VerificationMeta('sideEffects');
  @override
  late final GeneratedColumn<String> sideEffects = GeneratedColumn<String>(
      'side_effects', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _howToDealMeta =
      const VerificationMeta('howToDeal');
  @override
  late final GeneratedColumn<String> howToDeal = GeneratedColumn<String>(
      'how_to_deal', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _vaccinationMonthMeta =
      const VerificationMeta('vaccinationMonth');
  @override
  late final GeneratedColumn<int> vaccinationMonth = GeneratedColumn<int>(
      'vaccination_month', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _imunisasiKejarMeta =
      const VerificationMeta('imunisasiKejar');
  @override
  late final GeneratedColumn<String> imunisasiKejar = GeneratedColumn<String>(
      'imunisasi_kejar', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        vaccineName,
        vaccineBrands,
        benefits,
        indication,
        contraIndication,
        sideEffects,
        howToDeal,
        vaccinationMonth,
        imunisasiKejar,
        notes,
        source
      ];
  @override
  String get aliasedName => _alias ?? 'vaccines';
  @override
  String get actualTableName => 'vaccines';
  @override
  VerificationContext validateIntegrity(Insertable<Vaccine> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('vaccine_name')) {
      context.handle(
          _vaccineNameMeta,
          vaccineName.isAcceptableOrUnknown(
              data['vaccine_name']!, _vaccineNameMeta));
    } else if (isInserting) {
      context.missing(_vaccineNameMeta);
    }
    if (data.containsKey('vaccine_brands')) {
      context.handle(
          _vaccineBrandsMeta,
          vaccineBrands.isAcceptableOrUnknown(
              data['vaccine_brands']!, _vaccineBrandsMeta));
    }
    if (data.containsKey('benefits')) {
      context.handle(_benefitsMeta,
          benefits.isAcceptableOrUnknown(data['benefits']!, _benefitsMeta));
    }
    if (data.containsKey('indication')) {
      context.handle(
          _indicationMeta,
          indication.isAcceptableOrUnknown(
              data['indication']!, _indicationMeta));
    }
    if (data.containsKey('contra_indication')) {
      context.handle(
          _contraIndicationMeta,
          contraIndication.isAcceptableOrUnknown(
              data['contra_indication']!, _contraIndicationMeta));
    }
    if (data.containsKey('side_effects')) {
      context.handle(
          _sideEffectsMeta,
          sideEffects.isAcceptableOrUnknown(
              data['side_effects']!, _sideEffectsMeta));
    }
    if (data.containsKey('how_to_deal')) {
      context.handle(
          _howToDealMeta,
          howToDeal.isAcceptableOrUnknown(
              data['how_to_deal']!, _howToDealMeta));
    }
    if (data.containsKey('vaccination_month')) {
      context.handle(
          _vaccinationMonthMeta,
          vaccinationMonth.isAcceptableOrUnknown(
              data['vaccination_month']!, _vaccinationMonthMeta));
    } else if (isInserting) {
      context.missing(_vaccinationMonthMeta);
    }
    if (data.containsKey('imunisasi_kejar')) {
      context.handle(
          _imunisasiKejarMeta,
          imunisasiKejar.isAcceptableOrUnknown(
              data['imunisasi_kejar']!, _imunisasiKejarMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Vaccine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Vaccine(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      vaccineName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}vaccine_name'])!,
      vaccineBrands: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}vaccine_brands']),
      benefits: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}benefits']),
      indication: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}indication']),
      contraIndication: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}contra_indication']),
      sideEffects: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}side_effects']),
      howToDeal: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}how_to_deal']),
      vaccinationMonth: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}vaccination_month'])!,
      imunisasiKejar: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}imunisasi_kejar']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source']),
    );
  }

  @override
  $VaccinesTable createAlias(String alias) {
    return $VaccinesTable(attachedDatabase, alias);
  }
}

class Vaccine extends DataClass implements Insertable<Vaccine> {
  final int id;
  final String vaccineName;
  final String? vaccineBrands;
  final String? benefits;
  final String? indication;
  final String? contraIndication;
  final String? sideEffects;
  final String? howToDeal;
  final int vaccinationMonth;
  final String? imunisasiKejar;
  final String? notes;
  final String? source;
  const Vaccine(
      {required this.id,
      required this.vaccineName,
      this.vaccineBrands,
      this.benefits,
      this.indication,
      this.contraIndication,
      this.sideEffects,
      this.howToDeal,
      required this.vaccinationMonth,
      this.imunisasiKejar,
      this.notes,
      this.source});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['vaccine_name'] = Variable<String>(vaccineName);
    if (!nullToAbsent || vaccineBrands != null) {
      map['vaccine_brands'] = Variable<String>(vaccineBrands);
    }
    if (!nullToAbsent || benefits != null) {
      map['benefits'] = Variable<String>(benefits);
    }
    if (!nullToAbsent || indication != null) {
      map['indication'] = Variable<String>(indication);
    }
    if (!nullToAbsent || contraIndication != null) {
      map['contra_indication'] = Variable<String>(contraIndication);
    }
    if (!nullToAbsent || sideEffects != null) {
      map['side_effects'] = Variable<String>(sideEffects);
    }
    if (!nullToAbsent || howToDeal != null) {
      map['how_to_deal'] = Variable<String>(howToDeal);
    }
    map['vaccination_month'] = Variable<int>(vaccinationMonth);
    if (!nullToAbsent || imunisasiKejar != null) {
      map['imunisasi_kejar'] = Variable<String>(imunisasiKejar);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || source != null) {
      map['source'] = Variable<String>(source);
    }
    return map;
  }

  VaccinesCompanion toCompanion(bool nullToAbsent) {
    return VaccinesCompanion(
      id: Value(id),
      vaccineName: Value(vaccineName),
      vaccineBrands: vaccineBrands == null && nullToAbsent
          ? const Value.absent()
          : Value(vaccineBrands),
      benefits: benefits == null && nullToAbsent
          ? const Value.absent()
          : Value(benefits),
      indication: indication == null && nullToAbsent
          ? const Value.absent()
          : Value(indication),
      contraIndication: contraIndication == null && nullToAbsent
          ? const Value.absent()
          : Value(contraIndication),
      sideEffects: sideEffects == null && nullToAbsent
          ? const Value.absent()
          : Value(sideEffects),
      howToDeal: howToDeal == null && nullToAbsent
          ? const Value.absent()
          : Value(howToDeal),
      vaccinationMonth: Value(vaccinationMonth),
      imunisasiKejar: imunisasiKejar == null && nullToAbsent
          ? const Value.absent()
          : Value(imunisasiKejar),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      source:
          source == null && nullToAbsent ? const Value.absent() : Value(source),
    );
  }

  factory Vaccine.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Vaccine(
      id: serializer.fromJson<int>(json['id']),
      vaccineName: serializer.fromJson<String>(json['vaccineName']),
      vaccineBrands: serializer.fromJson<String?>(json['vaccineBrands']),
      benefits: serializer.fromJson<String?>(json['benefits']),
      indication: serializer.fromJson<String?>(json['indication']),
      contraIndication: serializer.fromJson<String?>(json['contraIndication']),
      sideEffects: serializer.fromJson<String?>(json['sideEffects']),
      howToDeal: serializer.fromJson<String?>(json['howToDeal']),
      vaccinationMonth: serializer.fromJson<int>(json['vaccinationMonth']),
      imunisasiKejar: serializer.fromJson<String?>(json['imunisasiKejar']),
      notes: serializer.fromJson<String?>(json['notes']),
      source: serializer.fromJson<String?>(json['source']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'vaccineName': serializer.toJson<String>(vaccineName),
      'vaccineBrands': serializer.toJson<String?>(vaccineBrands),
      'benefits': serializer.toJson<String?>(benefits),
      'indication': serializer.toJson<String?>(indication),
      'contraIndication': serializer.toJson<String?>(contraIndication),
      'sideEffects': serializer.toJson<String?>(sideEffects),
      'howToDeal': serializer.toJson<String?>(howToDeal),
      'vaccinationMonth': serializer.toJson<int>(vaccinationMonth),
      'imunisasiKejar': serializer.toJson<String?>(imunisasiKejar),
      'notes': serializer.toJson<String?>(notes),
      'source': serializer.toJson<String?>(source),
    };
  }

  Vaccine copyWith(
          {int? id,
          String? vaccineName,
          Value<String?> vaccineBrands = const Value.absent(),
          Value<String?> benefits = const Value.absent(),
          Value<String?> indication = const Value.absent(),
          Value<String?> contraIndication = const Value.absent(),
          Value<String?> sideEffects = const Value.absent(),
          Value<String?> howToDeal = const Value.absent(),
          int? vaccinationMonth,
          Value<String?> imunisasiKejar = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          Value<String?> source = const Value.absent()}) =>
      Vaccine(
        id: id ?? this.id,
        vaccineName: vaccineName ?? this.vaccineName,
        vaccineBrands:
            vaccineBrands.present ? vaccineBrands.value : this.vaccineBrands,
        benefits: benefits.present ? benefits.value : this.benefits,
        indication: indication.present ? indication.value : this.indication,
        contraIndication: contraIndication.present
            ? contraIndication.value
            : this.contraIndication,
        sideEffects: sideEffects.present ? sideEffects.value : this.sideEffects,
        howToDeal: howToDeal.present ? howToDeal.value : this.howToDeal,
        vaccinationMonth: vaccinationMonth ?? this.vaccinationMonth,
        imunisasiKejar:
            imunisasiKejar.present ? imunisasiKejar.value : this.imunisasiKejar,
        notes: notes.present ? notes.value : this.notes,
        source: source.present ? source.value : this.source,
      );
  @override
  String toString() {
    return (StringBuffer('Vaccine(')
          ..write('id: $id, ')
          ..write('vaccineName: $vaccineName, ')
          ..write('vaccineBrands: $vaccineBrands, ')
          ..write('benefits: $benefits, ')
          ..write('indication: $indication, ')
          ..write('contraIndication: $contraIndication, ')
          ..write('sideEffects: $sideEffects, ')
          ..write('howToDeal: $howToDeal, ')
          ..write('vaccinationMonth: $vaccinationMonth, ')
          ..write('imunisasiKejar: $imunisasiKejar, ')
          ..write('notes: $notes, ')
          ..write('source: $source')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      vaccineName,
      vaccineBrands,
      benefits,
      indication,
      contraIndication,
      sideEffects,
      howToDeal,
      vaccinationMonth,
      imunisasiKejar,
      notes,
      source);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Vaccine &&
          other.id == this.id &&
          other.vaccineName == this.vaccineName &&
          other.vaccineBrands == this.vaccineBrands &&
          other.benefits == this.benefits &&
          other.indication == this.indication &&
          other.contraIndication == this.contraIndication &&
          other.sideEffects == this.sideEffects &&
          other.howToDeal == this.howToDeal &&
          other.vaccinationMonth == this.vaccinationMonth &&
          other.imunisasiKejar == this.imunisasiKejar &&
          other.notes == this.notes &&
          other.source == this.source);
}

class VaccinesCompanion extends UpdateCompanion<Vaccine> {
  final Value<int> id;
  final Value<String> vaccineName;
  final Value<String?> vaccineBrands;
  final Value<String?> benefits;
  final Value<String?> indication;
  final Value<String?> contraIndication;
  final Value<String?> sideEffects;
  final Value<String?> howToDeal;
  final Value<int> vaccinationMonth;
  final Value<String?> imunisasiKejar;
  final Value<String?> notes;
  final Value<String?> source;
  const VaccinesCompanion({
    this.id = const Value.absent(),
    this.vaccineName = const Value.absent(),
    this.vaccineBrands = const Value.absent(),
    this.benefits = const Value.absent(),
    this.indication = const Value.absent(),
    this.contraIndication = const Value.absent(),
    this.sideEffects = const Value.absent(),
    this.howToDeal = const Value.absent(),
    this.vaccinationMonth = const Value.absent(),
    this.imunisasiKejar = const Value.absent(),
    this.notes = const Value.absent(),
    this.source = const Value.absent(),
  });
  VaccinesCompanion.insert({
    this.id = const Value.absent(),
    required String vaccineName,
    this.vaccineBrands = const Value.absent(),
    this.benefits = const Value.absent(),
    this.indication = const Value.absent(),
    this.contraIndication = const Value.absent(),
    this.sideEffects = const Value.absent(),
    this.howToDeal = const Value.absent(),
    required int vaccinationMonth,
    this.imunisasiKejar = const Value.absent(),
    this.notes = const Value.absent(),
    this.source = const Value.absent(),
  })  : vaccineName = Value(vaccineName),
        vaccinationMonth = Value(vaccinationMonth);
  static Insertable<Vaccine> custom({
    Expression<int>? id,
    Expression<String>? vaccineName,
    Expression<String>? vaccineBrands,
    Expression<String>? benefits,
    Expression<String>? indication,
    Expression<String>? contraIndication,
    Expression<String>? sideEffects,
    Expression<String>? howToDeal,
    Expression<int>? vaccinationMonth,
    Expression<String>? imunisasiKejar,
    Expression<String>? notes,
    Expression<String>? source,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vaccineName != null) 'vaccine_name': vaccineName,
      if (vaccineBrands != null) 'vaccine_brands': vaccineBrands,
      if (benefits != null) 'benefits': benefits,
      if (indication != null) 'indication': indication,
      if (contraIndication != null) 'contra_indication': contraIndication,
      if (sideEffects != null) 'side_effects': sideEffects,
      if (howToDeal != null) 'how_to_deal': howToDeal,
      if (vaccinationMonth != null) 'vaccination_month': vaccinationMonth,
      if (imunisasiKejar != null) 'imunisasi_kejar': imunisasiKejar,
      if (notes != null) 'notes': notes,
      if (source != null) 'source': source,
    });
  }

  VaccinesCompanion copyWith(
      {Value<int>? id,
      Value<String>? vaccineName,
      Value<String?>? vaccineBrands,
      Value<String?>? benefits,
      Value<String?>? indication,
      Value<String?>? contraIndication,
      Value<String?>? sideEffects,
      Value<String?>? howToDeal,
      Value<int>? vaccinationMonth,
      Value<String?>? imunisasiKejar,
      Value<String?>? notes,
      Value<String?>? source}) {
    return VaccinesCompanion(
      id: id ?? this.id,
      vaccineName: vaccineName ?? this.vaccineName,
      vaccineBrands: vaccineBrands ?? this.vaccineBrands,
      benefits: benefits ?? this.benefits,
      indication: indication ?? this.indication,
      contraIndication: contraIndication ?? this.contraIndication,
      sideEffects: sideEffects ?? this.sideEffects,
      howToDeal: howToDeal ?? this.howToDeal,
      vaccinationMonth: vaccinationMonth ?? this.vaccinationMonth,
      imunisasiKejar: imunisasiKejar ?? this.imunisasiKejar,
      notes: notes ?? this.notes,
      source: source ?? this.source,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (vaccineName.present) {
      map['vaccine_name'] = Variable<String>(vaccineName.value);
    }
    if (vaccineBrands.present) {
      map['vaccine_brands'] = Variable<String>(vaccineBrands.value);
    }
    if (benefits.present) {
      map['benefits'] = Variable<String>(benefits.value);
    }
    if (indication.present) {
      map['indication'] = Variable<String>(indication.value);
    }
    if (contraIndication.present) {
      map['contra_indication'] = Variable<String>(contraIndication.value);
    }
    if (sideEffects.present) {
      map['side_effects'] = Variable<String>(sideEffects.value);
    }
    if (howToDeal.present) {
      map['how_to_deal'] = Variable<String>(howToDeal.value);
    }
    if (vaccinationMonth.present) {
      map['vaccination_month'] = Variable<int>(vaccinationMonth.value);
    }
    if (imunisasiKejar.present) {
      map['imunisasi_kejar'] = Variable<String>(imunisasiKejar.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VaccinesCompanion(')
          ..write('id: $id, ')
          ..write('vaccineName: $vaccineName, ')
          ..write('vaccineBrands: $vaccineBrands, ')
          ..write('benefits: $benefits, ')
          ..write('indication: $indication, ')
          ..write('contraIndication: $contraIndication, ')
          ..write('sideEffects: $sideEffects, ')
          ..write('howToDeal: $howToDeal, ')
          ..write('vaccinationMonth: $vaccinationMonth, ')
          ..write('imunisasiKejar: $imunisasiKejar, ')
          ..write('notes: $notes, ')
          ..write('source: $source')
          ..write(')'))
        .toString();
  }
}

class $MilestonesTable extends Milestones
    with TableInfo<$MilestonesTable, Milestone> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MilestonesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _monthMeta = const VerificationMeta('month');
  @override
  late final GeneratedColumn<int> month = GeneratedColumn<int>(
      'month', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
      'image', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _stimulationMeta =
      const VerificationMeta('stimulation');
  @override
  late final GeneratedColumn<String> stimulation = GeneratedColumn<String>(
      'stimulation', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _articlesMeta =
      const VerificationMeta('articles');
  @override
  late final GeneratedColumn<String> articles = GeneratedColumn<String>(
      'articles', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, categoryId, month, image, title, description, stimulation, articles];
  @override
  String get aliasedName => _alias ?? 'milestones';
  @override
  String get actualTableName => 'milestones';
  @override
  VerificationContext validateIntegrity(Insertable<Milestone> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('month')) {
      context.handle(
          _monthMeta, month.isAcceptableOrUnknown(data['month']!, _monthMeta));
    } else if (isInserting) {
      context.missing(_monthMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('stimulation')) {
      context.handle(
          _stimulationMeta,
          stimulation.isAcceptableOrUnknown(
              data['stimulation']!, _stimulationMeta));
    }
    if (data.containsKey('articles')) {
      context.handle(_articlesMeta,
          articles.isAcceptableOrUnknown(data['articles']!, _articlesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Milestone map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Milestone(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id'])!,
      month: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}month'])!,
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      stimulation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}stimulation']),
      articles: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}articles']),
    );
  }

  @override
  $MilestonesTable createAlias(String alias) {
    return $MilestonesTable(attachedDatabase, alias);
  }
}

class Milestone extends DataClass implements Insertable<Milestone> {
  final int id;
  final int categoryId;
  final int month;
  final String? image;
  final String title;
  final String? description;
  final String? stimulation;
  final String? articles;
  const Milestone(
      {required this.id,
      required this.categoryId,
      required this.month,
      this.image,
      required this.title,
      this.description,
      this.stimulation,
      this.articles});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category_id'] = Variable<int>(categoryId);
    map['month'] = Variable<int>(month);
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<String>(image);
    }
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || stimulation != null) {
      map['stimulation'] = Variable<String>(stimulation);
    }
    if (!nullToAbsent || articles != null) {
      map['articles'] = Variable<String>(articles);
    }
    return map;
  }

  MilestonesCompanion toCompanion(bool nullToAbsent) {
    return MilestonesCompanion(
      id: Value(id),
      categoryId: Value(categoryId),
      month: Value(month),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      stimulation: stimulation == null && nullToAbsent
          ? const Value.absent()
          : Value(stimulation),
      articles: articles == null && nullToAbsent
          ? const Value.absent()
          : Value(articles),
    );
  }

  factory Milestone.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Milestone(
      id: serializer.fromJson<int>(json['id']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      month: serializer.fromJson<int>(json['month']),
      image: serializer.fromJson<String?>(json['image']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      stimulation: serializer.fromJson<String?>(json['stimulation']),
      articles: serializer.fromJson<String?>(json['articles']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'categoryId': serializer.toJson<int>(categoryId),
      'month': serializer.toJson<int>(month),
      'image': serializer.toJson<String?>(image),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'stimulation': serializer.toJson<String?>(stimulation),
      'articles': serializer.toJson<String?>(articles),
    };
  }

  Milestone copyWith(
          {int? id,
          int? categoryId,
          int? month,
          Value<String?> image = const Value.absent(),
          String? title,
          Value<String?> description = const Value.absent(),
          Value<String?> stimulation = const Value.absent(),
          Value<String?> articles = const Value.absent()}) =>
      Milestone(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        month: month ?? this.month,
        image: image.present ? image.value : this.image,
        title: title ?? this.title,
        description: description.present ? description.value : this.description,
        stimulation: stimulation.present ? stimulation.value : this.stimulation,
        articles: articles.present ? articles.value : this.articles,
      );
  @override
  String toString() {
    return (StringBuffer('Milestone(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('month: $month, ')
          ..write('image: $image, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('stimulation: $stimulation, ')
          ..write('articles: $articles')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, categoryId, month, image, title, description, stimulation, articles);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Milestone &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.month == this.month &&
          other.image == this.image &&
          other.title == this.title &&
          other.description == this.description &&
          other.stimulation == this.stimulation &&
          other.articles == this.articles);
}

class MilestonesCompanion extends UpdateCompanion<Milestone> {
  final Value<int> id;
  final Value<int> categoryId;
  final Value<int> month;
  final Value<String?> image;
  final Value<String> title;
  final Value<String?> description;
  final Value<String?> stimulation;
  final Value<String?> articles;
  const MilestonesCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.month = const Value.absent(),
    this.image = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.stimulation = const Value.absent(),
    this.articles = const Value.absent(),
  });
  MilestonesCompanion.insert({
    this.id = const Value.absent(),
    required int categoryId,
    required int month,
    this.image = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    this.stimulation = const Value.absent(),
    this.articles = const Value.absent(),
  })  : categoryId = Value(categoryId),
        month = Value(month),
        title = Value(title);
  static Insertable<Milestone> custom({
    Expression<int>? id,
    Expression<int>? categoryId,
    Expression<int>? month,
    Expression<String>? image,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? stimulation,
    Expression<String>? articles,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (month != null) 'month': month,
      if (image != null) 'image': image,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (stimulation != null) 'stimulation': stimulation,
      if (articles != null) 'articles': articles,
    });
  }

  MilestonesCompanion copyWith(
      {Value<int>? id,
      Value<int>? categoryId,
      Value<int>? month,
      Value<String?>? image,
      Value<String>? title,
      Value<String?>? description,
      Value<String?>? stimulation,
      Value<String?>? articles}) {
    return MilestonesCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      month: month ?? this.month,
      image: image ?? this.image,
      title: title ?? this.title,
      description: description ?? this.description,
      stimulation: stimulation ?? this.stimulation,
      articles: articles ?? this.articles,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (month.present) {
      map['month'] = Variable<int>(month.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (stimulation.present) {
      map['stimulation'] = Variable<String>(stimulation.value);
    }
    if (articles.present) {
      map['articles'] = Variable<String>(articles.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MilestonesCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('month: $month, ')
          ..write('image: $image, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('stimulation: $stimulation, ')
          ..write('articles: $articles')
          ..write(')'))
        .toString();
  }
}

class $ChildMilestonesTable extends ChildMilestones
    with TableInfo<$ChildMilestonesTable, ChildMilestone> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChildMilestonesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _childMilestoneIdMeta =
      const VerificationMeta('childMilestoneId');
  @override
  late final GeneratedColumn<int> childMilestoneId = GeneratedColumn<int>(
      'child_milestone_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _milestoneMeta =
      const VerificationMeta('milestone');
  @override
  late final GeneratedColumn<int> milestone = GeneratedColumn<int>(
      'milestone', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _childrenMeta =
      const VerificationMeta('children');
  @override
  late final GeneratedColumn<int> children = GeneratedColumn<int>(
      'children', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [childMilestoneId, milestone, children];
  @override
  String get aliasedName => _alias ?? 'child_milestones';
  @override
  String get actualTableName => 'child_milestones';
  @override
  VerificationContext validateIntegrity(Insertable<ChildMilestone> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('child_milestone_id')) {
      context.handle(
          _childMilestoneIdMeta,
          childMilestoneId.isAcceptableOrUnknown(
              data['child_milestone_id']!, _childMilestoneIdMeta));
    }
    if (data.containsKey('milestone')) {
      context.handle(_milestoneMeta,
          milestone.isAcceptableOrUnknown(data['milestone']!, _milestoneMeta));
    } else if (isInserting) {
      context.missing(_milestoneMeta);
    }
    if (data.containsKey('children')) {
      context.handle(_childrenMeta,
          children.isAcceptableOrUnknown(data['children']!, _childrenMeta));
    } else if (isInserting) {
      context.missing(_childrenMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {childMilestoneId};
  @override
  ChildMilestone map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChildMilestone(
      childMilestoneId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}child_milestone_id'])!,
      milestone: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}milestone'])!,
      children: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}children'])!,
    );
  }

  @override
  $ChildMilestonesTable createAlias(String alias) {
    return $ChildMilestonesTable(attachedDatabase, alias);
  }
}

class ChildMilestone extends DataClass implements Insertable<ChildMilestone> {
  final int childMilestoneId;
  final int milestone;
  final int children;
  const ChildMilestone(
      {required this.childMilestoneId,
      required this.milestone,
      required this.children});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['child_milestone_id'] = Variable<int>(childMilestoneId);
    map['milestone'] = Variable<int>(milestone);
    map['children'] = Variable<int>(children);
    return map;
  }

  ChildMilestonesCompanion toCompanion(bool nullToAbsent) {
    return ChildMilestonesCompanion(
      childMilestoneId: Value(childMilestoneId),
      milestone: Value(milestone),
      children: Value(children),
    );
  }

  factory ChildMilestone.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChildMilestone(
      childMilestoneId: serializer.fromJson<int>(json['childMilestoneId']),
      milestone: serializer.fromJson<int>(json['milestone']),
      children: serializer.fromJson<int>(json['children']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'childMilestoneId': serializer.toJson<int>(childMilestoneId),
      'milestone': serializer.toJson<int>(milestone),
      'children': serializer.toJson<int>(children),
    };
  }

  ChildMilestone copyWith(
          {int? childMilestoneId, int? milestone, int? children}) =>
      ChildMilestone(
        childMilestoneId: childMilestoneId ?? this.childMilestoneId,
        milestone: milestone ?? this.milestone,
        children: children ?? this.children,
      );
  @override
  String toString() {
    return (StringBuffer('ChildMilestone(')
          ..write('childMilestoneId: $childMilestoneId, ')
          ..write('milestone: $milestone, ')
          ..write('children: $children')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(childMilestoneId, milestone, children);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChildMilestone &&
          other.childMilestoneId == this.childMilestoneId &&
          other.milestone == this.milestone &&
          other.children == this.children);
}

class ChildMilestonesCompanion extends UpdateCompanion<ChildMilestone> {
  final Value<int> childMilestoneId;
  final Value<int> milestone;
  final Value<int> children;
  const ChildMilestonesCompanion({
    this.childMilestoneId = const Value.absent(),
    this.milestone = const Value.absent(),
    this.children = const Value.absent(),
  });
  ChildMilestonesCompanion.insert({
    this.childMilestoneId = const Value.absent(),
    required int milestone,
    required int children,
  })  : milestone = Value(milestone),
        children = Value(children);
  static Insertable<ChildMilestone> custom({
    Expression<int>? childMilestoneId,
    Expression<int>? milestone,
    Expression<int>? children,
  }) {
    return RawValuesInsertable({
      if (childMilestoneId != null) 'child_milestone_id': childMilestoneId,
      if (milestone != null) 'milestone': milestone,
      if (children != null) 'children': children,
    });
  }

  ChildMilestonesCompanion copyWith(
      {Value<int>? childMilestoneId,
      Value<int>? milestone,
      Value<int>? children}) {
    return ChildMilestonesCompanion(
      childMilestoneId: childMilestoneId ?? this.childMilestoneId,
      milestone: milestone ?? this.milestone,
      children: children ?? this.children,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (childMilestoneId.present) {
      map['child_milestone_id'] = Variable<int>(childMilestoneId.value);
    }
    if (milestone.present) {
      map['milestone'] = Variable<int>(milestone.value);
    }
    if (children.present) {
      map['children'] = Variable<int>(children.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChildMilestonesCompanion(')
          ..write('childMilestoneId: $childMilestoneId, ')
          ..write('milestone: $milestone, ')
          ..write('children: $children')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $UsersTable users = $UsersTable(this);
  late final $ChildrensTable childrens = $ChildrensTable(this);
  late final $PreferencesTable preferences = $PreferencesTable(this);
  late final $GrowthsTable growths = $GrowthsTable(this);
  late final $NotificationsTable notifications = $NotificationsTable(this);
  late final $VaccinationsTable vaccinations = $VaccinationsTable(this);
  late final $VaccinesTable vaccines = $VaccinesTable(this);
  late final $MilestonesTable milestones = $MilestonesTable(this);
  late final $ChildMilestonesTable childMilestones =
      $ChildMilestonesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        users,
        childrens,
        preferences,
        growths,
        notifications,
        vaccinations,
        vaccines,
        milestones,
        childMilestones
      ];
}
