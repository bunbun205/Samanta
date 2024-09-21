import 'package:audioplayers/audioplayers.dart';
import 'package:flame/cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samanta/l10n/l10n.dart';
import 'package:samanta/loading/loading.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PreloadCubit(
            Images(prefix: ''),
            AudioCache(prefix: ''),
          )..loadSequentially(),
        ),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF2A48DF),
        appBarTheme: const AppBarTheme(color: Color(0xFF2A48DF)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF2A48DF),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(const Color(0xFF2A48DF)),
          ),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: ChapterPage(),
    );
  }
}

class ChapterPage extends StatelessWidget {
  ChapterPage({super.key});

  final List<String> chapters = [
    'chapter 1: build a buisness',
    'Chapter 2: test your knoledge on industries',
    'Chapter 3: advancement of company',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapters'),
      ),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5, // Occupy 50% of the screen width
          child: Padding(
            padding: const EdgeInsets.all(16), // Padding around the grid
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5, // Number of columns in the grid
                crossAxisSpacing: 16, // Spacing between the columns
                mainAxisSpacing: 16, // Spacing between the rows
              ),
              itemCount: chapters.length,
              itemBuilder: (context, index) {
                return ChapterButton(
                  chapterName: chapters[index],
                  chapterNumber: index + 1,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ChapterButton extends StatelessWidget {

  const ChapterButton({
    required this.chapterName,
    required this.chapterNumber,
    super.key,
  });
  final String chapterName;
  final int chapterNumber;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Handle chapter button press
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoadingPage(index: chapterNumber, name: chapterName),
            ),
          );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2A48DF), // Button color
        minimumSize: Size.zero, // Ensures no default minimum size
        padding: EdgeInsets.zero, // Removes the default padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5), // Makes the button square
        ),
      ),
      child: Center(
        child: Text(
          'Chapter $chapterNumber',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
