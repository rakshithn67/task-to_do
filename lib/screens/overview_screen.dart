// import 'package:flutter/material.dart';
// import 'package:task_to_do_own/models/task_model.dart';
//
// import '../helpers/helpers.dart';
//
// class OverViewScreen extends StatefulWidget {
//   const OverViewScreen({Key? key}) : super(key: key);
//
//   @override
//   State<OverViewScreen> createState() => _OverViewScreenState();
// }
//
// class _OverViewScreenState extends State<OverViewScreen> {
//   DbHelpers dbHelper = DbHelpers();
//   TextEditingController titleController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Todo App'),
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             TextField(
//               controller: titleController,
//               decoration: const InputDecoration(
//                 hintText: 'Enter the Title...',
//               ),
//             ),
//             const SizedBox(
//               height: 6,
//             ),
//             TextField(
//               controller: descriptionController,
//               decoration: const InputDecoration(
//                 hintText: 'Enter the Description...',
//               ),
//             ),
//             const SizedBox(
//               height: 9,
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   onInserted(titleController.text, descriptionController.text);
//                 });
//               },
//               style: ElevatedButton.styleFrom(
//                   shape: const StadiumBorder(), fixedSize: const Size(200, 0)),
//               child: const Text(
//                 'Submit',
//                 style: TextStyle(
//                   fontSize: 17,
//                 ),
//               ),
//             ),
//             Expanded(
//               child: FutureBuilder(
//                 future: dbHelper.getTask(),
//                 builder: (context, snapShot) {
//                   if (snapShot.hasData) {
//                     List<Task>? snapList = snapShot.data;
//                     return ListView.builder(
//                       itemCount: snapList!.length,
//                       itemBuilder: (ctx, i) {
//                         return Card(
//                           child: ListTile(
//                             title: Text(snapList[i].title),
//                             subtitle: Text(snapList[i].description),
//                           ),
//                         );
//                       },
//                     );
//                   }
//                   return const Center(
//                     child: Text('No Data Found...!'),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   onInserted(String text, String text2) {
//     Task newTask = Task(title: text, description: text2);
//     dbHelper.insertTask(newTask);
//   }
// }

import 'package:flutter/material.dart';

import '../models/services.dart';
import '../models/task_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAdded = false;

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descrController = TextEditingController();

  final services = UserServices();

  void showBottomModal(BuildContext ctx, String id, String name, String descr) {
    final TextEditingController updateTitleController = TextEditingController();

    final TextEditingController updateDescrController = TextEditingController();
    updateTitleController.text = name;
    updateDescrController.text = descr.toString();
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 10),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                  child: TextField(
                    controller: updateTitleController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Title'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: TextField(
                    minLines: 1,
                    maxLines: 4,
                    controller: updateDescrController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Description'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        services.updateUser(
                          id,
                          updateTitleController.text,
                          updateDescrController.text,
                        );

                        isAdded = true;
                      });
                      Navigator.of(ctx).pop();
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Save User'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task To_do'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Title'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextField(
                minLines: 1,
                maxLines: 4,
                controller: _descrController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Description'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    services.saveUser(
                        _titleController.text, _descrController.text);
                  });
                  _titleController.clear();
                  _descrController.clear();
                },
                icon: const Icon(Icons.add),
                label: const Text('Add'),
              ),
            ),
            const Divider(
              thickness: 2,
              color: Colors.white54,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: FutureBuilder(
                  future: services.fetchUsers(),
                  builder: (ctx, snap) {
                    List<User>? users = snap.data;
                    if (!snap.hasData) {
                      return const Center(
                        child: Text(
                          'No data found...!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: users!.length,
                      itemBuilder: (ctx, idx) {
                        return Column(
                          children: [
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 20),
                              padding: const EdgeInsets.only(
                                  right: 24, left: 24, top: 25, bottom: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    users[idx].title,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    users[idx].description,
                                    style: const TextStyle(
                                      height: 1.5,
                                      color: Colors.black87,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          showBottomModal(
                                            context,
                                            users[idx].id,
                                            users[idx].title,
                                            users[idx].description,
                                          );
                                        },
                                        icon: const Icon(Icons.edit),
                                        label: const Text('Edit'),
                                      ),
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          setState(() {
                                            services.deleteUser(users[idx].id);
                                          });
                                        },
                                        icon: const Icon(Icons.delete_forever),
                                        label: const Text('Delete'),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                        // return Card(
                        //   elevation: 3,
                        //   child: ListTile(
                        //     title: Text(users[idx].title),
                        //     subtitle: Text(users[idx].description),
                        //     trailing: Row(
                        //       mainAxisSize: MainAxisSize.min,
                        //       children: <Widget>[
                        //         IconButton(
                        //           icon: const Icon(Icons.delete),
                        //           onPressed: () {
                        //             setState(() {
                        //               services.deleteUser(users[idx].id);
                        //             });
                        //           },
                        //         ),
                        //         IconButton(
                        //           icon: const Icon(Icons.edit),
                        //           onPressed: () => showBottomModal(
                        //             context,
                        //             users[idx].id,
                        //             users[idx].title,
                        //             users[idx].description,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
