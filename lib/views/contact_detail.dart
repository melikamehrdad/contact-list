import 'package:contacts/bloc/contact_bloc.dart';
import 'package:contacts/bloc/contact_event.dart';
import 'package:contacts/bloc/contact_state.dart';
import 'package:contacts/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactDetailPage extends StatefulWidget {

  const ContactDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ContactDetailPage> createState() => _ContactDetailPageState();
}

class _ContactDetailPageState extends State<ContactDetailPage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _noteController = TextEditingController();
  String contactId = '';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Contact detail'),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<ContactBloc>().add(FetchContactData());
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: BlocBuilder<ContactBloc, ContactState>(
          builder: (context, state) {
            //Set data from state to text editing controller
            if (state is ContactLoaded) {
              _setControllerData(state.contact);
              contactId = state.contact.id;
            }
            //Show loading
            else if (state is ContactLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      width: 140.0,
                      height: 140.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 120,
                      ),
                    ),
                    onTap: () {},
                  ),
                  TextField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(labelText: "FirstName"),
                  ),
                  TextField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(labelText: "LastName"),
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: "Email"),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextField(
                    controller: _phoneController,
                    decoration: const InputDecoration(labelText: "Phone"),
                    keyboardType: TextInputType.phone,
                  ),
                  TextField(
                    controller: _noteController,
                    decoration: const InputDecoration(labelText: "Note"),
                  ),
                  const SizedBox(
                    height: 40,
                  ),

                  //Delete account widget button
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      context.read<ContactBloc>().add(DeleteContact(contactId));
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      fixedSize: Size(MediaQuery.of(context).size.width, 30),
                    ),
                    child: const Text(
                      'Delete this account',
                    ),
                  )
                ],
              ),
            );
          },
        ),

        //Add account widget button
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<ContactBloc>().add(
                  AddNewContact(
                    _firstNameController.text,
                    _lastNameController.text,
                    _emailController.text,
                    _phoneController.text,
                    _noteController.text,
                  ),
                );
            Navigator.pop(context);
          },
          child: const Icon(Icons.save),
        ),
      ),
    );
  }

  //Back request in application
  Future<bool> _requestPop() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Discard Changes?"),
            content: const Text("If you leave as changes will be lost."),
            actions: <Widget>[
              TextButton(
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text("Yes"),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
    return Future.value(false);
  }

  //Set data to controller
  _setControllerData(Datum contact) {
    _firstNameController.text = contact.firstName;
    _lastNameController.text = contact.lastName;
    _emailController.text = contact.email;
    _phoneController.text = contact.phone;
    _noteController.text = contact.notes;
  }
}
