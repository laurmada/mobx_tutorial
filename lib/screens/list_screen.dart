import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_tutorial/screens/login_screen.dart';
import 'package:mobx_tutorial/stores/list_store.dart';
import 'package:mobx_tutorial/stores/login_store.dart';
import 'package:mobx_tutorial/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final TextEditingController controller = TextEditingController();

  final ListStore listStore = ListStore();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          margin: const EdgeInsets.fromLTRB(32, 0, 32, 32),
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text('Tarefas',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 32,
                        )),
                    IconButton(
                      icon: const Icon(Icons.exit_to_app),
                      color: Colors.white,
                      onPressed: () {
                        Provider.of<LoginStore>(context, listen: false)
                            .logout();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 16,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      Observer(builder: (_) {
                        return CustomTextField(
                          textInputType: TextInputType.name,
                          onChanged: listStore.setNewToDoTitle,
                          enabled: true,
                          controller: controller,
                          hint: 'Tarefa',
                          suffix: listStore.isFormValid
                              ? GestureDetector(
                                  onTap: () {
                                    listStore.addTodo();
                                    controller.clear();
                                  },
                                  child: const Icon(Icons.add),
                                )
                              : null,
                        );
                      }),
                      const SizedBox(height: 8),
                      Expanded(child: Observer(builder: (_) {
                        return ListView.separated(
                          itemBuilder: (_, index) {
                            final todo = listStore.todoList[index];
                            return Observer(builder: (_) {
                              return ListTile(
                                title: Text(
                                  todo.title,
                                  style: TextStyle(
                                    decoration: todo.done
                                        ? TextDecoration.lineThrough
                                        : null,
                                    color:
                                        todo.done ? Colors.grey : Colors.black,
                                  ),
                                ),
                                onTap: todo.toggleDone,
                              );
                            });
                          },
                          separatorBuilder: (_, __) {
                            return const Divider();
                          },
                          itemCount: listStore.todoList.length,
                        );
                      })),
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
