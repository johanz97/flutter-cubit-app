import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:estadosapp/bloc/usuario/usuario_cubit.dart';
import 'package:estadosapp/models/usuario.dart';

class Pagina2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usuarioCubit = context.read<UsuarioCubit>();
    return Scaffold(
      appBar: AppBar(
        title: TitleAppBar(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
                child: const Text(
                  'Establecer usuario',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: () {
                  final user = Usuario(nombre: 'Johan', edad: 24, profesiones: [
                    'Software Developer',
                    'Analist of Software'
                  ]);
                  usuarioCubit.seleccionarUsuario(user);
                }),
            BlocBuilder<UsuarioCubit, UsuarioState>(
              builder: (_, state) {
                switch (state.runtimeType) {
                  case UsuarioInitial:
                    return BotonesAdicionales(usuarioCubit, false);
                  case UsuarioActivo:
                    return BotonesAdicionales(usuarioCubit, true);
                  default:
                    return const Text('Estado no reconocido');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BotonesAdicionales extends StatelessWidget {
  final UsuarioCubit usuarioCubit;
  final bool estado;
  const BotonesAdicionales(this.usuarioCubit, this.estado);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
            child: const Text(
              'Cambiar edad',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.blue,
            onPressed: estado
                ? () {
                    usuarioCubit.cambiarEdad(20);
                  }
                : null),
        MaterialButton(
            child: const Text(
              'Añadir Profesión',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.blue,
            onPressed: estado
                ? () {
                    usuarioCubit.addProfesion('Soccer Player');
                  }
                : null)
      ],
    );
  }
}

class TitleAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsuarioCubit, UsuarioState>(
      builder: (_, state) {
        switch (state.runtimeType) {
          case UsuarioInitial:
            return const Text('Pagina 2');
          case UsuarioActivo:
            return Text((state as UsuarioActivo).usuario.nombre);
          default:
            return const Text('Estado no reconocido');
        }
      },
    );
  }
}
