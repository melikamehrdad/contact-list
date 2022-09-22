import 'package:contacts/bloc/contact_bloc.dart';
import 'package:contacts/bloc/contact_state.dart';
import 'package:contacts/views/contact_detail.dart';
import 'package:contacts/views/contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Create contact bloc
    return MultiBlocProvider(
      providers: [
        BlocProvider<ContactBloc>(
          create: (context) => ContactBloc(ContactLoading()),
          child: const ContactDetailPage(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Phonebook Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ContactPage(),
      ),
    );
  }
}
