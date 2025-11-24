import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../authentication/domain/usecases/get_profile.dart';
import '../../../authentication/domain/usecases/complete_profile_usecase.dart'; // Import Gerekli

import 'profile_event.dart';
import 'profile_state.dart';

export 'profile_event.dart';
export 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final CompleteProfileUseCase completeProfileUseCase; // YENİ

  ProfileBloc({
    required this.getProfileUseCase,
    required this.completeProfileUseCase,
  }) : super(ProfileInitial()) {
    // Profil Getir
    on<LoadProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final user = await getProfileUseCase();
        emit(ProfileLoaded(user));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    // YENİ: Profili Güncelle
    on<UpdateProfileEvent>((event, emit) async {
      // Mevcut state yüklüyse, loading göstermeden önce veriyi koruyabiliriz
      // Ama basitlik adına tekrar loading gösterelim veya bir overlay loading state yapabiliriz.
      emit(ProfileLoading());
      try {
        await completeProfileUseCase(
          event.city,
          event.university,
          event.skillLevel,
        );
        // Güncelleme başarılı olunca profili tekrar çekiyoruz ki UI güncellensin
        add(LoadProfileEvent());
      } catch (e) {
        emit(ProfileError("Güncelleme başarısız: ${e.toString()}"));
      }
    });
  }
}
