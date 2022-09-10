import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl_standalone.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/foundation.dart';

part 'locale_event.dart';
part 'locale_state.dart';

///Bloc para cambiar el idioma de la aplicacion
///Para configurar el i10n en una aplicacion se debe crear una carpeta donde se encuetre archivos con
///una extencion que sea `.arb`. De preferencia debe estar en la ruta [lib/i10n]. Donde el archivo
///comience con algun nombre y finalice con `_es`,`_en` dependiendo el idioma que se este configurando
///En el se guarda datos en formato de mapa.
///Crear un archivo que se llame `i10n.yaml`. Ver archivo para saber que posee
///Configurar el `pubspec.yaml` segun lo indica el comentario en el archivo   
class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc() : super(const LocaleState()) {
    on<OnInitLocale>(_onInitLocale);
    on<OnCambiaIdioma>(_onCambiaIdioma);
  }

  Future<void> _onInitLocale(OnInitLocale event, Emitter emit) async {
    emit(state.copyWith(
        isWorking: true, error: '', isLoaded: false, accion: 'initLocale'));

    AppLocalizations? strings = state.strings;
    final localeCode =
        event.localeCode.isEmpty ? await findSystemLocale() : event.localeCode;
    Locale locale = Locale(localeCode.split('_')[0]);
    if (kDebugMode) {
      // Uncomment for testing in chinese
      // locale = Locale('zh');
    }
    if (AppLocalizations.supportedLocales.contains(locale) == false) {
      locale = const Locale('es');
    }
    strings = await AppLocalizations.delegate.load(locale);

    emit(state.copyWith(
        isWorking: false,
        error: '',
        strings: strings,
        isLoaded: true,
        accion: 'initLocale'));
  }

  Future<void> _onCambiaIdioma(OnCambiaIdioma event, Emitter emit) async {
    emit(state.copyWith(
        isWorking: true, error: '', isLoaded: false, accion: 'cambiaIdioma'));

    AppLocalizations? strings = state.strings;
    bool didChange =
        state.strings?.localeName != Locale(event.localeCode).languageCode;
    if (didChange &&
        AppLocalizations.supportedLocales.contains(Locale(event.localeCode))) {
      strings = await AppLocalizations.delegate.load(Locale(event.localeCode));
    }
    emit(state.copyWith(
        isWorking: false,
        error: '',
        strings: strings,
        isLoaded: true,
        accion: 'cambiaIdioma'));
  }
}
