import 'package:contacts/bloc/contact_bloc.dart';
import 'package:contacts/bloc/contact_event.dart';
import 'package:contacts/bloc/contact_state.dart';
import 'package:contacts/contact_model.dart';
import 'package:contacts/views/contact_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    //Get all Contact data
    context.read<ContactBloc>().add(FetchContactData());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: BlocListener<ContactBloc, ContactState>(
        listener: (context, state) {
          if (state is ContactResult) {
            context.read<ContactBloc>().add(FetchContactData());

            //Show current state with snack bar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.message}. ${state.statusCode}'),
              ),
            );
          }
        },
        child: BlocBuilder<ContactBloc, ContactState>(
          builder: (context, state) {
            //Get all contacts data, If there is anything will show with ListView.builder and if it isn't it show a text
            if (state is AllContactLoaded) {
              return state.contacts.count == '0'
                  ? const Center(
                      child: Text('There is nothing. Please add new contacts.'),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(20.0),
                      itemCount: int.parse(state.contacts.count),
                      itemBuilder: (context, index) {
                        return _contactCard(state.contacts, index);
                      },
                    );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      //Go to get new user data in another page
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ContactDetailPage(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  //Contact widget
  Widget _contactCard(Contact contacts, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 60.0,
                height: 60.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person,
                  size: 48,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${contacts.data[index].firstName} ${contacts.data[index].lastName}',
                      style: const TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      contacts.data[index].email,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      contacts.data[index].phone,
                      style: const TextStyle(fontSize: 16.0),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      //Go to Contact detail page to see more details
      onTap: () {
        context
            .read<ContactBloc>()
            .add(ShowDetailContactPage(contacts.data[index].id));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ContactDetailPage(),
          ),
        );
      },
    );
  }
}
