import 'package:mobx/mobx.dart';
import 'package:mobx_tutorial/stores/todo_store.dart';
part 'list_store.g.dart';

class ListStore = _ListStore with _$ListStore;

abstract class _ListStore with Store {
  @observable
  String newToDoTitle = "";

  @action
  void setNewToDoTitle(String value) => newToDoTitle = value;

  @computed
  bool get isFormValid => newToDoTitle.isNotEmpty;

  @observable
  ObservableList<TodoStore> todoList = ObservableList<TodoStore>();

  @action
  void addTodo() {
    todoList.insert(0, TodoStore(newToDoTitle));
    newToDoTitle = "";
  }
}
