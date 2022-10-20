import 'package:flask_rest_api_user_crud/services/user_api.dart';
import 'package:flutter/material.dart';

class AddUserForm extends StatefulWidget {
  AddUserForm({Key? key}) : super(key: key);

  @override
  State<AddUserForm> createState() => _AddUserFormState();
}

class _AddUserFormState extends State<AddUserForm> {
  var _userNameController = TextEditingController();
  var _userContactController = TextEditingController();

  bool _validateName = false;
  bool _validateContact = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User Data'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text(
                'Add New User',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _userNameController,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Name',
                    labelText: 'Name',
                    errorText:
                        _validateName ? 'Name Value Can\'t Be Empty' : null),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _userContactController,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Contact Number',
                    labelText: 'Contact No',
                    errorText: _validateContact
                        ? 'Contact Value Can\'t Be Empty'
                        : null),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () async {
                      setState(() {
                        _userNameController.text.isEmpty
                            ? _validateName = true
                            : _validateName = false;
                        _userContactController.text.isEmpty
                            ? _validateContact = true
                            : _validateContact = false;
                      });
                      if (_validateName == false && _validateContact == false) {
                        var result = await UserAPI().addUser(
                            _userNameController.text,
                            _userContactController.text);
                        Navigator.pop(context, result);
                      }
                    },
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.blue,
                        textStyle: const TextStyle(fontSize: 15)),
                    child: const Text('Save Details'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      _userNameController.text = "";
                      _userContactController.text = "";
                    },
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.red,
                        textStyle: const TextStyle(fontSize: 15)),
                    child: const Text('Clear Details'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
