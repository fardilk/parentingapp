// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on _HomeStore, Store {
  late final _$currentHomeIndexAtom =
      Atom(name: '_HomeStore.currentHomeIndex', context: context);

  @override
  int get currentHomeIndex {
    _$currentHomeIndexAtom.reportRead();
    return super.currentHomeIndex;
  }

  @override
  set currentHomeIndex(int value) {
    _$currentHomeIndexAtom.reportWrite(value, super.currentHomeIndex, () {
      super.currentHomeIndex = value;
    });
  }

  late final _$_HomeStoreActionController =
      ActionController(name: '_HomeStore', context: context);

  @override
  void setCurrentHomeIndex(int index) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.setCurrentHomeIndex');
    try {
      return super.setCurrentHomeIndex(index);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentHomeIndex: ${currentHomeIndex}
    ''';
  }
}
