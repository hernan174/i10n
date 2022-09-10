part of 'locale_bloc.dart';

abstract class LocaleEvent extends Equatable {
  const LocaleEvent();

  @override
  List<Object> get props => [];
}

///Evento para cambiar entre os idiomas disponibles para la aplicacion
class OnCambiaIdioma extends LocaleEvent {
  final String localeCode;
  const OnCambiaIdioma({required this.localeCode});
}

///Inicializa el [AppLocalizations] que es el encargado de manipular los textos que se visualizara en la
///aplicacion.
///Recibe un parametro que es[localeCode] que es el idioma en el cual se va a iniciar
class OnInitLocale extends LocaleEvent {
  final String localeCode;
  const OnInitLocale({required this.localeCode});
}
