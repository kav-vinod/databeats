import 'package:flutter_bloc/flutter_bloc.dart';

class CodeVerifierCubit extends Cubit<String?> {
  CodeVerifierCubit(String? initial) : super(initial);

  void update(newCodeVerifier) => emit(newCodeVerifier); 

  void clear() => emit(null); 
}