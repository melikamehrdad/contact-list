import 'dart:convert';

import 'package:contacts/apis/add_contact.dart';
import 'package:contacts/apis/delete_contact.dart';
import 'package:contacts/apis/get_all_contacts.dart';
import 'package:contacts/apis/get_contact_data.dart';
import 'package:contacts/bloc/contact_event.dart';
import 'package:contacts/bloc/contact_state.dart';
import 'package:contacts/contact_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

//Contact or main Bloc
class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc(ContactState initialState) : super(ContactLoading()) {
    on<FetchContactData>(_onFetchContactData);
    on<ShowDetailContactPage>(_onGetContactDetailData);
    on<AddNewContact>(_onAddNewContact);
    on<DeleteContact>(_onDeleteContact);
  }

  //Fetch all contacts
  void _onFetchContactData(FetchContactData event,
      Emitter<ContactState> emit) async {
    http.Response response = await getAllContacts();
    if (response.statusCode == 200) {
      Contact allContacts = Contact.fromJson(jsonDecode(response.body));
      allContacts.data.toSet();
      emit(AllContactLoaded(allContacts));
    } else {
      String message = jsonDecode(response.body);
      emit(ContactResult(message, response.statusCode));
    }
  }

  //Get a Contact data with contact ID
  void _onGetContactDetailData(ShowDetailContactPage event,
      Emitter<ContactState> emit) async {
    http.Response response = await getContactData(event.contactId);
    if (response.statusCode == 200) {
      emit(ContactLoaded(Datum.fromJson(jsonDecode(response.body))));
    } else {
      String message = jsonDecode(response.body);
      emit(ContactResult(message, response.statusCode));
    }
  }

  //Add a new contact
  void _onAddNewContact(AddNewContact event, Emitter<ContactState> emit) async {
    http.Response response = await addContact(event.firstName,
        event.lastName, event.phoneNumber, event.email, event.note);
    if (response.statusCode == 200) {
      emit(ContactResult('Contact added', response.statusCode));
    } else {
      String message = jsonDecode(response.body);
      emit(ContactResult(message, response.statusCode));
    }
  }

  //Deleted contact
  void _onDeleteContact(DeleteContact event, Emitter<ContactState> emit) async {
    http.Response response = await deleteContact(event.contactId);
    if (response.statusCode == 204) {
      emit(ContactResult('User deleted!', response.statusCode));
    } else {
      String message = jsonDecode(response.body);
      emit(ContactResult(message, response.statusCode));
    }
  }
}
