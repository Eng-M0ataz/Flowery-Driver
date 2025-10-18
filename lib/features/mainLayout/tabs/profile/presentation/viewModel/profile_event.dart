import 'dart:io';

sealed class ProfileEvent {}

class GetLoggedDriverDataEvent extends ProfileEvent {}

class LoadDriverDataEvent extends ProfileEvent {}

class EditProfileSubmitEvent extends ProfileEvent {}

class OnImageSelectedEvent extends ProfileEvent {
  OnImageSelectedEvent({required this.file});
  final File file;
}

class ResetSuccessStateEvent extends ProfileEvent {}

class CloseEvent extends ProfileEvent {}