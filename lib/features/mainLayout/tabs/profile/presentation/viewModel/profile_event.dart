import 'dart:io';

sealed class ProfileEvent {}

class GetLoggedUserDataEvent extends ProfileEvent {}

class EditVechicalEvent extends ProfileEvent {}

class OnImageSelectedEvent extends ProfileEvent {
  OnImageSelectedEvent({required this.file});
  final File file;
}

class CloseEvent extends ProfileEvent {}
