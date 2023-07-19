// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_service_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$windowManagerHash() => r'329183b875f50fa0169f8276df306e3b0f2c1b9b';

/// See also [windowManager].
@ProviderFor(windowManager)
final windowManagerProvider = Provider<AppWindowManager>.internal(
  windowManager,
  name: r'windowManagerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$windowManagerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WindowManagerRef = ProviderRef<AppWindowManager>;
String _$appConfigHash() => r'db3807d48d2d3633cbcde7f5956d9b9d11528900';

/// See also [appConfig].
@ProviderFor(appConfig)
final appConfigProvider = Provider<AppConfig>.internal(
  appConfig,
  name: r'appConfigProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appConfigHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AppConfigRef = ProviderRef<AppConfig>;
String _$authServiceHash() => r'c31e7c594735e8c01b849abdf93c9725e59c3404';

/// See also [authService].
@ProviderFor(authService)
final authServiceProvider = Provider<AuthService>.internal(
  authService,
  name: r'authServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthServiceRef = ProviderRef<AuthService>;
String _$userRepoHash() => r'2668308c71ad4de0db2bc33281f66121bd699a73';

/// See also [userRepo].
@ProviderFor(userRepo)
final userRepoProvider = Provider<Repository<User>>.internal(
  userRepo,
  name: r'userRepoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userRepoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserRepoRef = ProviderRef<Repository<User>>;
String _$flashcardRepoHash() => r'1a1d636f69c0dd39db7567312c9b0e615ffad0c1';

/// See also [flashcardRepo].
@ProviderFor(flashcardRepo)
final flashcardRepoProvider = Provider<Repository<Flashcard>>.internal(
  flashcardRepo,
  name: r'flashcardRepoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$flashcardRepoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FlashcardRepoRef = ProviderRef<Repository<Flashcard>>;
String _$deckRepoHash() => r'd40e783c7edfc321a80b4f7ba224e015203bdf26';

/// See also [deckRepo].
@ProviderFor(deckRepo)
final deckRepoProvider = Provider<Repository<Deck>>.internal(
  deckRepo,
  name: r'deckRepoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$deckRepoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DeckRepoRef = ProviderRef<Repository<Deck>>;
String _$deckCollectionRepoHash() =>
    r'0c9933924e4d9ffde87a073a2dbffaaf8dc7f864';

/// See also [deckCollectionRepo].
@ProviderFor(deckCollectionRepo)
final deckCollectionRepoProvider =
    Provider<Repository<DeckCollection>>.internal(
  deckCollectionRepo,
  name: r'deckCollectionRepoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$deckCollectionRepoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DeckCollectionRepoRef = ProviderRef<Repository<DeckCollection>>;
String _$dbServiceHash() => r'9b86f12f4314b0eb679637bc30541a9a18b45847';

/// See also [dbService].
@ProviderFor(dbService)
final dbServiceProvider = Provider<AppDataService>.internal(
  dbService,
  name: r'dbServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dbServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DbServiceRef = ProviderRef<AppDataService>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
