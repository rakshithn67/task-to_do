



import '../helpers/helpers.dart';
import 'task_model.dart';

class UserServices {

  void saveUser(String title, String description) {
    DBHelper.insert(
        'users', {'id': DateTime.now().toString(), 'title': title, 'description': description});
  }

  Future<List<User>> fetchUsers() async {
    final usersList = await DBHelper.getData('users');
    return usersList
        .map((item) =>
        User(id: item['id'], title: item['title'], description: item['description']))
        .toList();
  }

  void deleteUser(String id) {
    DBHelper.deleteData('users', id);
  }

  void updateUser(String id, String title, String description) {
    DBHelper.updateData('users', id,
        {'id': DateTime.now().toString(), 'title': title, 'description': description});
  }
}