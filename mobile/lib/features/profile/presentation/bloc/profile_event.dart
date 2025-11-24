import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object> get props => [];
}

class LoadProfileEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final String city;
  final String university;
  final String skillLevel;

  const UpdateProfileEvent({
    required this.city,
    required this.university,
    required this.skillLevel,
  });

  @override
  List<Object> get props => [city, university, skillLevel];
}
