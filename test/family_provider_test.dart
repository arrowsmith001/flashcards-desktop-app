import 'package:flashcard_desktop_app/main.dart';
import 'package:flashcard_desktop_app/src/classes/app_config.dart';
import 'package:flashcard_desktop_app/src/custom/data/abstract/repository.dart';
import 'package:flashcard_desktop_app/src/custom/data/implemented/local.dart';
import 'package:flashcard_desktop_app/src/notifiers/deck_collection_list_notifier.dart';
import 'package:flashcard_desktop_app/src/notifiers/deck_list_notifier.dart';
import 'package:flashcard_desktop_app/src/services/app_deck_service.dart';
import 'package:flashcard_desktop_app/src/services/implemented/local_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  final config = AppConfig();
  await config.configureForEnvironment('dev');

  final services = FlashcardAppLocalServices();
  await services.initialize(config);

  testWidgets('description', (tester) async {
    final widget = ProviderScope(overrides: [
      appConfigProvider.overrideWith((ref) => config),
      authServiceProvider.overrideWith((ref) => services.authService),
      userRepoProvider.overrideWith((ref) => Repository(services.userService)),
      flashcardRepoProvider
          .overrideWith((ref) => Repository(services.flashcardService)),
      deckRepoProvider.overrideWith((ref) => Repository(services.deckService)),
      deckCollectionRepoProvider
          .overrideWith((ref) => Repository(services.deckCollectionService)),
      dbServiceProvider.overrideWith((ref) => AppDeckService(
          ref.read(authServiceProvider),
          ref.read(deckCollectionRepoProvider),
          ref.read(deckRepoProvider),
          ref.read(flashcardRepoProvider))),
    ], child: TestWidget());

    await tester.pumpWidget(widget);

    expect(find.byType(Text), findsOneWidget);
  });
}

class TestWidget extends ConsumerWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
/*     final notifier = ref.watch(deckListNotifierProvider('').notifier);
    final value = notifier.getDecks();
    return Text((value != null).toString()); */
    return Container();
  }
}
