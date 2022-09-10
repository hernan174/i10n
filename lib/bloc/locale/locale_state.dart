part of 'locale_bloc.dart';

class LocaleState extends Equatable {
  final bool isWorking;
  final String error;
  final String accion;

  ///Posee la refererencia a los String que se definieron en los archivos de la carpeta [lib/i10n]
  final AppLocalizations? strings;

  const LocaleState({
    this.isWorking = false,
    this.error = '',
    this.accion = '',
    this.strings,
  });

  LocaleState copyWith(
          {bool? isWorking,
          String? error,
          String? accion,
          bool? hasCompletedOnboarding,
          bool? hasDismissedSearchMessage,
          String? currentLocale,
          bool? isLoaded,
          AppLocalizations? strings}) =>
      LocaleState(
          isWorking: isWorking ?? this.isWorking,
          error: error ?? this.error,
          accion: accion ?? this.accion,
          strings: strings ?? this.strings);

  @override
  List<Object> get props => [
        isWorking,
        error,
        accion,
      ];
}
