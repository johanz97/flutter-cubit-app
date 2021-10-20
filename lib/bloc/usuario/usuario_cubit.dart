import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:estadosapp/models/usuario.dart';

part 'usuario_state.dart';

class UsuarioCubit extends Cubit<UsuarioState> {
  UsuarioCubit() : super(UsuarioInitial());

  void seleccionarUsuario(Usuario user) => emit(UsuarioActivo(user));

  void cambiarEdad(int edad) {
    final currentState = state;
    if (currentState is UsuarioActivo) {
      final user = currentState.usuario.copyWith(edad: edad);
      emit(UsuarioActivo(user));
    }
  }

  void addProfesion(String profesion) {
    final currentState = state;
    if (currentState is UsuarioActivo) {
      final Usuario user = currentState.usuario.copyWith();
      user.profesiones!.add(profesion);
      emit(UsuarioActivo(user));
    }
  }

  void borrarUsuario() => emit(UsuarioInitial());
}
