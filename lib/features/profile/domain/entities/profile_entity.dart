import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final bool success;
  final UserEntity user;

  const ProfileEntity(this.success, this.user);

  @override
  List<Object> get props => [success, user];
}

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final AvatarEntity avtar;
  const UserEntity(this.id, this.name, this.email, this.avtar);

  @override
  List<Object> get props => [id, name, email, avtar];
}

class AvatarEntity extends Equatable {
  final String publicId;
  final String url;

  const AvatarEntity(this.publicId, this.url);
  


  @override
  List<Object> get props => [publicId, url];
}