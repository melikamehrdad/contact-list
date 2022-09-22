import 'package:contacts/contact_model.dart';
import 'package:equatable/equatable.dart';

//Contact (app) states
class ContactState extends Equatable {
  @override
  List<Object?> get props => [];
}

//Loading contact page (waiting to getting data)
class ContactLoading extends ContactState {}

class ContactResult extends ContactState {
  final String message;
  final int statusCode;

  ContactResult(this.message, this.statusCode);
}

//Contacts loaded
class AllContactLoaded extends ContactState {
  final Contact _contacts;

  AllContactLoaded(this._contacts);

  Contact get contacts => _contacts;
}

//Got a contact data
class ContactLoaded extends ContactState {
  final Datum _contact;

  ContactLoaded(this._contact);

  Datum get contact => _contact;
}