import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  @observable
  int currentHomeIndex = 0;

  @action
  void setCurrentHomeIndex(int index) {
    this.currentHomeIndex = index;
  }
}
