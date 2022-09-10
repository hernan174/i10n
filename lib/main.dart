import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i10n/bloc/locale/locale_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocaleBloc()),
      ],
      child: Builder(builder: (context) {
        context.read<LocaleBloc>().add(const OnInitLocale(localeCode: 'es'));
        return BlocBuilder<LocaleBloc, LocaleState>(
          builder: (context, state) {
            return MaterialApp(
              title: state.strings?.appTitle ?? '',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: MyHomePage(title: state.strings?.homePageTitle ?? ''),

              ///Configuracion de los idiomas en el materiaApp
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
            );
          },
        );
      }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleBloc, LocaleState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(state.strings?.homePageTextInfo ?? ''),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ),
          floatingActionButton: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.strings?.homePageButonIngles ?? ''),
                  const SizedBox(width: 10),
                  FloatingActionButton(
                    elevation: 0,
                    onPressed: () {
                      context
                          .read<LocaleBloc>()
                          .add(const OnCambiaIdioma(localeCode: 'en'));
                    },
                    child: const Icon(Icons.translate),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.strings?.homePageButonEspanol ?? ''),
                  const SizedBox(width: 10),
                  FloatingActionButton(
                    elevation: 0,
                    onPressed: () {
                      context
                          .read<LocaleBloc>()
                          .add(const OnCambiaIdioma(localeCode: 'es'));
                    },
                    child: const Icon(Icons.translate),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.strings?.homePageButonIncrementar ?? ''),
                  const SizedBox(width: 10),
                  FloatingActionButton(
                    onPressed: _incrementCounter,
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ), // This trailing comma makes auto-formatting nicer for build methods.
        );
      },
    );
  }
}
