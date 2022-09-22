import 'package:equatable/equatable.dart';

//Contact (app) events
class ContactEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

//Fetch data from API
class FetchContactData extends ContactEvent {}

class ShowDetailContactPage extends ContactEvent {
  final String contactId;

  ShowDetailContactPage(this.contactId);
}

//Add new contact
class AddNewContact extends ContactEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String note;

  AddNewContact(this.firstName, this.lastName, this.email, this.phoneNumber,
      this.note);
}

//Delete an existent contact
class DeleteContact extends ContactEvent {
  final String contactId;

  DeleteContact(this.contactId);
}
