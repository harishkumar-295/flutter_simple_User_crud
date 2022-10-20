import 'package:flask_rest_api_user_crud/services/user_api.dart';
import 'package:flask_rest_api_user_crud/view/add_user_form.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Map<String, dynamic>? welcome;
  bool isLoaded = false;
  List<User>? users;
  bool usersEmpty = false;

  getDetails() async {
    var res = await UserAPI().getAllUsers();
    if (res != null) {
      if (res.success == true) {
        setState(() {
          isLoaded = true;
        });
        users = res.users;
        if (users!.isEmpty) {
          setState(() {
            usersEmpty = true;
          });
        }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Flask App"),
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: usersEmpty
            ? const Center(
                child: Text('no users..'),
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(users![index].name),
                    subtitle: Text(users![index].contact),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.edit)),
                        IconButton(
                            onPressed: () async {
                              // Implement dialog box here and only after the user clicks ok delete user
                              var response = await UserAPI()
                                  .deleteUser(users![index].id, context)
                                  .then((value) {
                                if (value != null) {
                                  if (value.success) {
                                    getDetails();
                                  }
                                }
                              });
                            },
                            icon: const Icon(Icons.delete)),
                      ],
                    ),
                  );
                },
                itemCount: users?.length,
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddUserForm()))
              .then((value) {
            if (value != null) {
              // print(value);
              if (value.success) {
                setState(() {
                  usersEmpty = false;
                });
                getDetails();
              }
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
