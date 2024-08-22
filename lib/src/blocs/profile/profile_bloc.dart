// import 'package:bd_shop/src/data/model/user_model.dart';
// import 'package:bd_shop/src/data/repository/repository.dart';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';

// part 'profile_event.dart';
// part 'profile_state.dart';

// class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
//   ProfileRepository profileRepository;
//   ProfileBloc(this.profileRepository) : super(ProfileInitial()) {
//     on<FetchUserDataFromFirebase>((event, emit) {
//     final user = profileRepository.getUserInfo();
//     emit(ProfileSuccess(userData: user));
//     });
//   }
// }
